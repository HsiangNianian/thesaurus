msg_reply.main = {
    keyword = {
        regex = { "(.*)" }
    },
    limit = {
        cd = 2
    },
    echo = { lua = "main" }
}