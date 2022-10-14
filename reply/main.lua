msg_reply.main = {
    keyword = {
        regex = { "(.*)" }
    },
    limit = {
        cd = 5
    },
    echo = { lua = "main" }
}