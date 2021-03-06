local Log = require 'solstice.log'
require 'logging'
require 'logging.file'

local M = {}

M.NWLog = logging.new(
   function(self, level, message)
      Log.WriteTimestampedLogEntry(message)
      return true
   end)

M.NXLog = logging.new(
   function(self, level, message)
      Log.WriteTimestampedLogEntryToNWNX(message)
      return true
   end)

M.Log = logging.file("/opt/nwn/logs.0/ta_log.txt")

return M