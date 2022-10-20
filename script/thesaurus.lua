----------------------------
-- @thesaurus
-- @author WazuSora & 简律纯.
----------------------------

---------settings-----------
-- @config 配置项
msg.ignored = true -- "禁止刷屏"
settings = {
    _FRAMEWORK = "Windows", -- 手机请使用"Linux"
    _REGEX = true -- 一个没用的开关
}
----------------------------
package.path = getDiceDir() .. "/mod/thesaurus/script/yaml.lua"

local yaml = require("yaml")

local write_file = function(path, text, mode)
    file = io.open(path, mode) --"a"
    io.output(file)
    io.write(text)
    io.close()
end

local read_file = function(path, mode)
    local text = ""
    local file = io.open(path, mode)
    if (file ~= nil) then
        text = file.read(file, "*a")
        io.close(file)
    else
        return "没有该文件或文件内容为空哦"
    end
    return tostring(text)
end

local split = function(str, pat)
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

local keys = function(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

local getFileList = function(path, _FRAMEWORK)
    txt = read_file(path .. "thesaurus.log")
    t = split(txt, "\n")
    if _FRAMEWORK == "Linux" then
        for k = 1, #t do
            t[k] = t[k]:match(".*/(.+)$")
        end
    end
    return t
end

local _PATH
local cmd

if settings._FRAMEWORK == "Windows" then
    _PATH = getDiceDir() .. "\\mod\\thesaurus\\speech\\"
    cmd = "dir " .. _PATH .. "*.yml" .. " /b > " .. _PATH .. "thesaurus.log"
elseif settings._FRAMEWORK == "Linux" then
    _PATH = getDiceDir() .. "/mod/thesaurus/speech/"
    cmd = "ls " .. _PATH .. "*.yml" .. " > " .. _PATH .. "thesaurus.log"
else
    return "笨蛋Master真的有认真填写_FRAMEWORK配置项吗..."
end

os.execute(cmd)

yml_list = getFileList(_PATH, settings._FRAMEWORK)
list = table.concat(yml_list, "\n")

if #yml_list ~= 0 then
    for k, v in ipairs(yml_list) do
        local content = read_file(tostring(_PATH .. v))
        local dict_list = yaml.parse(content)
        local str = string.match(msg.fromMsg, "(.*)")
        local comp_list = keys(dict_list)
        for k, v in ipairs(comp_list) do
            if string.match(str, v) then
                if type(dict_list[v]) == "table" then
                    if string.match(dict_list[v][ranint(1, #dict_list[v])], ">>>f") then
                        local split_table = split(dict_list[v], ">>>f")
                        return load(split_table[ranint(1, #split_table)])()
                    else
                        return dict_list[v][ranint(1, #dict_list[v])]
                    end
                else
                    if string.match(dict_list[v], ">>>f") then
                        local split_table = split(dict_list[v], ">>>f")
                        return load(split_table[ranint(1, #split_table)])()
                    else
                        return dict_list[v]
                    end 
                end
                --else
                -- 问答词典 
                -- 时间词典
            end
        end
    end
end
