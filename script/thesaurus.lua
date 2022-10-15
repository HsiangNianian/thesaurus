----------------------------
-- @thesaurus
-- @author Wazisora & 简律纯.
----------------------------
package.path = getDiceDir()..'\\mod\\thesaurus\\script\\yaml.lua'

local yaml = require("yaml")

local readAll = function(file)
  local f = io.open(file, "rb")
  local content = f:read("*all")
  f:close()
  return content
end

local content = readAll(getDiceDir() .. '\\mod\\thesaurus\\speech\\dict.yml')
local dict_list = yaml.parse(content)
local str = string.match(msg.fromMsg, '(.*)')

if dict_list[str] then
  if type(dict_list[str]) == "table" then
    return dict_list[str][ranint(1, #dict_list[str])]
  end
  return dict_list[str]
else
  return --To-Do:学习功能
end
