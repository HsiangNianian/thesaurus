# thesaurus

```json
{
    "mod":"thesaurus",
    "author":"简律纯",
    "ver":"1.2.0",
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

> 直接丢进mod文件夹就可以了。

## 1.2 config

### 1.2.1 cd

直接修改 `mod\thesaurus\reply\main.lua`第 `6`行 `cd`值。

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

配置词典,因为暂时只是一个测试版本，所以你需要自行打开 `mod\thesaurus\speech\dict.yml`并按照已有格式进行删改操作。当然，此文件遵守 `yaml`语法。
> 自`1.2.0(20221016)`版本以后支持了多个`*.yml`的 检索，当`dict1.yml`内没有触发词时会继续寻找剩下的`*.yml`文件直到有结果为止。

下面给出一些示例:

> 一对一

```yaml
# 这是一个注释
思考: ummm...?
```

> 多对一，仅支持嵌套一层

```yaml
哦: 
  - 不要之说一个哦！很没礼貌的！
  - 哦...?
  - o~
# 或采用行内表示法
简子姐: ["欸...?","咦惹——"]
```

> 转义

```yaml
笨蛋: 
  - "{nick}你才是！"
  - "baka{at}"
```

> 换行符

```yaml
# |使输出时保留换行符\n
早: |
  bad
  morning
# >可在编写时直接表示换行
晚上好: >
  good
  night
```

> 特别的,你可以在`|模式`用扩展语法`>>>f`来返回一个或多个Lua脚本
```yaml
丢我: |
  >>>f
    pic = "https://xiaobai.klizi.cn/API/ce/diu.php?qq="..msg.uid
    return "[CQ:image,file="..pic.."]"
```