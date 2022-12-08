# thesaurus
> 一定程度上弱化了reply的概念，同时也解决了MA不能在reply里设置Lua回复的bug。

[![](https://img.shields.io/github/issues/cypress0522/thesaurus)](https://github.com/cypress0522/thesaurus/issues) [![](https://img.shields.io/github/issues-pr/cypress0522/thesaurus)](https://github.com/cypress0522/thesaurus/pulls)[![GitHub last commit](https://img.shields.io/github/last-commit/cypress0522/thesaurus.svg)](https://github.com/cypress0522/thesaurus/commits) [![release](https://img.shields.io/github/v/release/cypress0522/thesaurus.svg)](https://github.com/cypress0522/thesaurus/releases) [![download](https://img.shields.io/github/downloads/cypress0522/thesaurus/total.svg)](https://github.com/cypress0522/thesaurus/releases/download/v2.0.3/thesaurus_v2.0.3.zip)

```json
{
    "mod":"thesaurus",
    "author":"简律纯",
    "ver":"2.0.3",
    "dice_build":612,
    "brief":"词典匹配回复",
    "comment":"",
    "helpdoc":{
        "thesaurus":"https://github.com/cypress0522/thesaurus"
    }
}
```

# To-Do

- [ ] 词典白名单(这也是已知的一个bug)
- [X] Regex 正则表达式
- [X] 多 `*.yml`文件读取
- [ ] 单个词典正则开关
- [ ] 学习词库

# 1. install

- Dice版本2.6.5beta12(624+)以上安装方法:

  1. 在 `./DiceQQ/conf/mod/source.list`文件内（没有mod文件夹和这文件就新建）输入 `https://ssjskfjdj.netlify.app/Module/`。
  2. 使用 `.system load`命令重载bot，这样做的目的是为了让步骤1里的远程地址生效。
  3. 对bot发送 `.mod get thesaurus`命令，等待安装。
  4. 回到第二步，这样做的目的是为了让mod被加载。
  5. Enjoy Your Self!
- Dice版本2.6.4b(612+)以上安装方法：

  1. 浏览器访问 `https://github.com/ssJSKFJDJ/thesaurus`并点击绿色按钮 `Code`下的 `Download Zip`按钮下载仓库压缩包。
  2. 解压压缩包，将里面的文件和文件夹全部丢进 `./DiceQQ/mod/`文件夹内。
  3. 使用 `.system load`命令重载。
  4. Enjoy Your Self!

# 2. settings

## 2.1 cd

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

## 2.2 dict

配置词典,因为暂时只是一个测试版本，所以你需要自行打开 `mod\thesaurus\speech\dict.yml`并按照已有格式进行删改操作。当然，此文件遵守 `yaml`语法。

下面给出一些示例:

> 一对一：

```yaml
# 这是一个注释
思考: ummm...?
```

> 多对一，仅支持嵌套一层：

```yaml
哦: 
  - 不要之说一个哦！很没礼貌的！
  - 哦...?
  - o~

# 或采用行内表示法
简子姐: ["欸...?","咦惹——"]
```

> 转义：

```yaml
笨蛋: 
  - "{nick}你才是！"
  - "baka{at}"
```

> 换行符：

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

> 特别的,你可以在 `|模式`用扩展语法 `>>>f`来返回一个或多个Lua脚本:

```yaml
丢我: |
  >>>f
    pic = "https://xiaobai.klizi.cn/API/ce/diu.php?qq="..msg.uid
    return "[CQ:image,file="..pic.."]"
```

> 使用正则:

在做到输出回复词可以多回复功能以后，为实现更加强大的匹配词设定，加入了正则表达式。
你可以这样:

```yaml
^简子姐.*: ["欸...?", "咦惹——"]
```

当检测到有人发言符合 `简子姐xxx`(包括只有 `简子姐`本身)的时候即可触发回复。

# 3. config

> 一些原理和配置上的说明

## 3.1 *.yml

自 `1.2.0(20221016)`版本以后支持了多个 `*.yml`的 检索，当 `dict1.yml`内没有触发词时会继续寻找剩下的 `*.yml`文件直到有结果为止。

关于词典触发词冲突

试想这样一种情况，`dict1.yml`里写着这样一段:

```yaml
笨蛋: 你真的好笨呀
```

而 `dict2.yml`里写着这样一段：

```yaml
笨蛋: 你也是呢~
```

那么当有人说出笨蛋时，会输出哪个？——答案是 `dict1.yml`里的词典回复。
为什么？——这和 `getFileList(path,exp)`函数有关，**默认按照首字母排序机制**，如果有需求，在以后的版本里可以考虑加上其他排序方式来改变词典的重复词输出（比如按照修改时间排序等）。

## 3.2 _FRAMEWORK

初衷是为简单分配词条回复，主要用户是MA骰主，但发现这种方法解决MA`reply`无法添加Lua是可行的，又因为安卓与Windows是两个不同的系统，于是写了两个版本——`Windows`与`Linux`。

MA所搭载的Lua并没有`io.popen()`这样的函数，但是令人欣慰的是可以使用`os.execute()`，并且命令格式就是`Linux`系统命令。

如果你是MA用户，可以把配置项里的`_FRAMEWORK`改成`"Linux"`，这样才可正常运行模块。

***

未完待续...
