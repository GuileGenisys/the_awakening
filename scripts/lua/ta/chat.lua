local fmt = string.format
local bit = require 'bit'
local ffi = require 'ffi'
local C = ffi.C
local lfs = require 'lfs'

local GetIsValid = require('solstice.object').Object.GetIsValid

local _COMMANDS = {}
local _SYMBOLS = {}

local M = {}

--- ChatInfo table.
--     A table containing the following fields will be passed to the
--     chat command function.
-- @table ChatInfo
-- @field channel Chat channel.
-- @field speaker Chat speaker.
-- @field cmd Chat command
-- @field param Chat command parameters.  I.e. all text
-- following the chat command.
-- @see solstice.chat.RegisterCommand

local function get_command(start, cmd)
   local first_space
   for i=1, #cmd do
      if cmd:index(i) == " " then
         first_space = i
         break
      end
   end

   local command, action

   if first_space then
      command = string.sub(cmd, #start+1, first_space - 1)
      action = string.sub(cmd, first_space+1, #cmd)
   else
      command = string.sub(cmd, #start+1, #cmd)
      action = ""
   end

   return command, action
end

local info

local function get_symbol(cmd)
   for i = 1, #_SYMBOLS, 2 do
      sym, ver = _SYMBOLS[i], _SYMBOLS[i+1]
      if cmd:starts(sym) then
         return sym, ver
      end
   end
end


local function run_command(cmd)
   local dispatch
   local symbol

   local sym, ver = get_symbol(cmd)
   if not sym then return end

   local speaker = info.speaker

   if ver == true or ver(info.speaker) then
      symbol   = sym
      dispatch = _COMMANDS[sym]
   else
      speaker:SendMessage("You are not authorized to use this command!")
   end

   -- If not a command or emote return false and don't suppress
   -- chat.
   if not dispatch then return false end

   info.cmd, info.param = get_command(symbol, cmd)
   --print (info.cmd, info.param)

   if dispatch[info.cmd] then
      if info.param:match("--help") then
         speaker:SendMessage(dispatch[info.cmd].description)
      else
         dispatch[info.cmd].func(info)
      end

      return true
--   else
--      speaker:SendMessage("Invalid Command!")
   end
end

--- Chat Handler
-- @param channel
-- @param speaker
-- @param msg
-- @param to
function M.ChatHandler(channel, speaker, msg, to)
   -- Speaker must be a valid PC and the msg must start with
   -- a command.
   if not GetIsValid(speaker) or
      speaker.type ~= OBJECT_TRUETYPE_CREATURE or
      not speaker:GetIsPC() or
      not get_symbol(msg)
   then
      return false
   end

   local commands = msg:split('&&')

   info = {
      channel  = channel,
      speaker  = speaker,
      target   = to
   }

   each(run_command, iter(commands))

   return false
end

local function load_dir(symbol, dir)
   local chatdir = lfs.currentdir() .. "/lua/" .. dir .. '/'

   for f in lfs.dir(chatdir) do
      if string.find(f:lower(), ".lua", -4)  then
         local file =  chatdir .. f
         local c = setmetatable({}, { __index = _G })
         local res = runfile(file, c)
         if res.command and type(res.command) == "string" and
            res.action and type(res.action) == "function"
         then
            C.Local_NWNXLog(0, "Loaded Chat Command: " .. file .. "\n")
            M.RegisterCommand(symbol, res.command, res.description or "", res.action)
         else
            C.Local_NWNXLog(0, "Error Loading Chat Command: " .. file .. "\n")
         end
      end
   end
end

--- Register chat symbol.
-- @param symbol
-- @param[opt] verify
function M.RegisterSymbol(symbol, dir, verify)
   if type(symbol) ~= "string" then
      error "Chat symbols must be strings!"
   end

   if verify ~= nil and type(verify) ~= "function" then
      error "The symbol verifier if passed must be a function!"
   end
   table.insert(_SYMBOLS, symbol)
   table.insert(_SYMBOLS, verify or true)
   load_dir(symbol, dir)
end

function IsRegisteredSymbol(cmd)
   for i=1, #_SYMBOLS, 2 do
      if cmd == _SYMBOLS[i] then
         return cmd
      end
   end
end

--- Register chat command.
-- @param symbol
-- @param name
-- @param desc
-- @param func
function M.RegisterCommand(symbol, name, desc, func)
   if not IsRegisteredSymbol(symbol) then
      error(fmt("Symbol %s has not been registered!", symbol))
   end
   _COMMANDS[symbol] = _COMMANDS[symbol] or {}
   _COMMANDS[symbol][name] = {func = func, description = desc }
end

function M.CCMessageHandler(msg)

   if msg.type == 11 and msg.subtype == 151 then
      return true
   elseif msg.type == 3 then
      local sum = 0
      for i = 0, 12 do
         if msg.msg_data.integers.data[i] > 0 then
            sum = sum + msg.msg_data.integers.data[i]
         end
      end
      return sum <= 0
   end
   return false
end

local NXChat = safe_require 'solstice.nwnx.chat'
NXChat.SetChatHandler(M.ChatHandler)
NXChat.SetCombatMessageHandler(M.CCMessageHandler)

return M
