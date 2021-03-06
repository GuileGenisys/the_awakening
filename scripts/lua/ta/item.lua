--- Functions
-- @section

local _ITEMS = {}
local Dyn = require 'ta.dynamo'
local Env = require 'ta.item_env'

local ip = require 'solstice.itemprop'
local ipc = ip.const
local Cre = require 'solstice.creature'

local env_mt = { __index = table.chain(M.env, ipc) }

--- Load item file.
-- @param file Item file to load.
function M.Load(file)
   E.item = setmetatable({}, env_mt)

   local res = runfile(file, E.item)
   _ITEMS[assert(res.resref)] = res

   E.item = nil
end

--- Generate item
-- @param object Object to create item on.
-- @param resref Resref of item to create.
-- @param[opt=false] max If true, the maximum value of an
-- item property parameter.
-- @see solstice.item.Load
function M.Generate(object, resref, max)
   local item = _ITEMS[resref]
   if not item then
      error("No such resref: " .. resref)
   end

   local it  = object:GiveItem(resref)
   if not it:GetIsValid() then
      error("Invalid item: Resref: " .. resref)
   end

   -- This probably could be done in a better fashion...

   if item.value then
      it:SetGoldValue(item.value)
   end

   for _, p in ipairs(item.properties) do
      local f = p.f
      if not f then
         error "No item property function!"
      end

      local t = {}
      for _, v in ipairs(p) do
         local val = Dyn.GetValue(v, max)
         table.insert(t, val)
      end

      local count = p.n or 1
      for i = 1,count do
         if not p.chance or math.random(1, 100) <= p.chance then
            it:AddItemProperty(Eff.DURATION_PERMANENT, ip[f](unpack(t)))
         end
      end
   end
end