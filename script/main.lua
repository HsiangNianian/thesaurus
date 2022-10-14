local yaml = require('yaml')

ToStringEx = function(value)
    if type(value) == 'table' then
        return table.list(value)
    elseif type(value) == 'string' then
        return "\'" .. value .. "\'"
    else
        return tostring(value)
    end
end

table.list = function(t)
    if t == nil then return "" end
    local retstr = "{"

    local i = 1
    for key, value in pairs(t) do
        local signal = ","
        if i == 1 then
            signal = ""
        end

        if key == i then
            retstr = retstr .. signal .. ToStringEx(value)
        else
            if type(key) == 'number' or type(key) == 'string' then
                retstr = retstr .. signal .. '[' .. ToStringEx(key) .. "]=" .. ToStringEx(value)
            else
                if type(key) == 'userdata' then
                    retstr = retstr .. signal .. "*s" .. TableToStr(getmetatable(key)) .. "*e" .. "=" ..
                        ToStringEx(value)
                else
                    retstr = retstr .. signal .. key .. "=" .. ToStringEx(value)
                end
            end
        end

        i = i + 1
    end

    retstr = retstr .. "}"
    return retstr
end

function table.keys(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

function table.keyof(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then return k end
    end
    return nil
end

readAll = function(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end

content = readAll(getDiceDir() .. '\\mod\\thesaurus\\speech\\dict.yml')
dict_list = yaml.parse(content)
dict_comp = load("return " .. table.list(dict_list))()
str = string.match(msg.fromMsg,'(.*)')
--a="坏蛋"
if dict_comp[str] then
    if type(dict_comp[str])=="table" then
        return dict_comp[str][ranint(1,#dict_comp[str])]
    end
    return dict_comp[str]
else
    return
end