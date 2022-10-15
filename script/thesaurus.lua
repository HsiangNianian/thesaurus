----------------------------
-- @thesaurus
-- @author Wazisora & 简律纯.
----------------------------
package.path = getDiceDir() .. '\\mod\\thesaurus\\script\\yaml.lua'

local yaml = require("yaml")

local readAll = function(file)
  local f = io.open(file, "rb")
  local content = f:read("*all")
  f:close()
  return content
end

local split = function(str, delimiter)
  str = tostring(str)
  delimiter = tostring(delimiter)
  if (delimiter=='') then return false end
  local pos,arr = 0, {}
  -- for each divider found
  for st,sp in function() return string.find(str, delimiter, pos, true) end do
    table.insert(arr, string.sub(str, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(str, pos))
  return arr
end

local content = readAll(getDiceDir() .. '\\mod\\thesaurus\\speech\\dict.yml')
local dict_list = yaml.parse(content)
local str = string.match(msg.fromMsg, '(.*)')

if dict_list[str] then
  if type(dict_list[str]) == "table" then
    if string.match(dict_list[str][ranint(1, #dict_list[str])], "%[%^%d+%]") then
      local split_table = split(dict_list[str],"%[%^%d+%]")
      return load(string.sub(dict_list[str][ranint(1, #dict_list[str])],#"#lua"+1))()
    else
      return dict_list[str][ranint(1, #dict_list[str])]
    end
  end
  if string.match(dict_list[str], "%[%^%d+%]") then
    return load(string.sub(dict_list[str],#"#lua"+1))()
  else
    return dict_list[str]
  end
else
  return --To-Do:学习功能
end
