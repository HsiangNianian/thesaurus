# thesaurus
```json
{
    "mod":"thesaurus",
    "author":"简律纯",
    "ver":"1.0.4",
    "dice_build":612,
    "brief":"词典匹配回复",
    "comment":"",
    "helpdoc":{
        "thesaurus":"https://github.com/cypress0522/thesaurus"
    }
}
```

# 1. Usage

## 1.1 install

> 除了plugin文件夹里的yaml.lua是直接丢进plugin文件夹外，其他的直接丢进mod文件夹就可以了

## 1.2 config

### 1.2.1 cd

直接修改`mod\thesaurus\reply\main.lua`第`6`行`cd`值。

```lua
msg_reply.main = {
    keyword = {
        regex = { "(.*)" }
    },
    limit = {
        cd = 2 --就是这个数字，单位秒.
    },
    echo = { lua = "main" }
}
```

### 1.2.2 dict

配置词典,因为暂时只是一个测试版本，所以你需要自行打开`mod\thesaurus\speech\dict.yml`并按照已有格式进行删改操作。当然，此文件遵守`yaml`语法。

下面给出一些示例:

> 一对一
```yaml
思考: ummm...?
```

> 多选一，目前仅支持嵌套一层
```yaml
哦: 
  - 不要之说一个哦！很没礼貌的！
  - 哦...?
  - o~
```

> 转义
```yaml
笨蛋: 
  - "{nick}你才是！"
  - "baka{at}"
```