local Lt = require 'ta.loot'

command = 'loot'
description = 'Loot System related commands'

function action(chat_info)
   local act = chat_info.param:split(' ')
   if not act then return end
   local pc = chat_info.speaker

   if act[1] == "test" and act[2] then
      pc:SendMessage(Lt.Test(act[2]))
   elseif act[1] == "list" then
      pc:SendMessage(Lt.List())
   end
end