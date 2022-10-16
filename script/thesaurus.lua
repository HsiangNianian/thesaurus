----------------------------
-- @thesaurus
-- @author Wazisora & 简律纯.
----------------------------

---------settings-----------
-- @config 配置项
_FRAMEWORK = "Windows"
----------------------------
package.path = getDiceDir() .. '/mod/thesaurus/script/yaml.lua'

local yaml = require("yaml")

local readAll = function(file)
	local f = io.open(file, "rb")
	local content = f:read("*all")
	f:close()
	return content
end

local getFileList_Windows = function(path, sub)
	local sub = sub or ""
	a = io.popen("dir " .. path .. "\\" .. sub .. " /b")
	local fileTable = {}

	if a == nil then
	else
		for l in a:lines() do table.insert(fileTable, l) end
	end
	return fileTable
end

local getFileList_Linux = function(path, sub)
	local sub = sub or ""
	os.execute("ls " .. path .. "/" .. sub ..
		" > " .. getDiceDir() .. "/thesaurus.log")
	a = readAll(getDiceDir() .. "/thesaurus.log")
	local fileTable = {}

	if a == nil then
	else
		for l in a:lines() do table.insert(fileTable, l) end
	end
	return fileTable
end

local function split(str, pat)
	local t = {}
	local fpat = "(.-)" .. pat
	local last_end = 1
	local s, e, cap = str:find(fpat, 1)
	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(t, cap)
		end
		last_end = e + 1
		s, e, cap = str:find(fpat, last_end)
	end
	if last_end <= #str then
		cap = str:sub(last_end)
		table.insert(t, cap)
	end
	return t
end

if _FRAMEWORK == "Windows" then
	yml_list = getFileList_Windows(getDiceDir() .. '\\mod\\thesaurus\\speech', '*.yml')
elseif _FRAMEWORK == "Linux" then
	yml_list = getFileList_Linux(getDiceDir() .. '\\mod\\thesaurus\\speech')
else
	return "笨蛋Master是不是写错了_FRAMEWORK配置呀"
end

if #yml_list ~= 0 then
	for k, v in ipairs(yml_list) do
		local content = readAll(getDiceDir() .. '/mod/thesaurus/speech/' .. v)
		local dict_list = yaml.parse(content)
		local str = string.match(msg.fromMsg, '(.*)')

		if dict_list[str] then
			if type(dict_list[str]) == "table" then
				if string.match(dict_list[str][ranint(1, #dict_list[str])], ">>>f") then
					local split_table = split(dict_list[str], ">>>f")
					return load(split_table[ranint(1, #split_table)])()
				else
					return dict_list[str][ranint(1, #dict_list[str])]
				end
			end
			if string.match(dict_list[str], ">>>f") then
				local split_table = split(dict_list[str], ">>>f")
				return load(split_table[ranint(1, #split_table)])()
			else
				return dict_list[str]
			end
		end
	end
end
