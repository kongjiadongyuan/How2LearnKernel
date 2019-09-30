HOOK_FUNCTION_STR = """probe kernel.function("{0}"){{
    if (execname() == "{1}"){{
        printf("%s -> {0} (%s)\\n", thread_indent(2), $$parms)
    }}
}}
probe kernel.function("{0}").return{{
    if (execname() == "{1}"){{
        printf("%s <- {0} (%s)\\n", thread_indent(-2), $$return)
    }}
}}

"""

HOOK_SYSCALL_STR = """probe syscall.{0}{{
    if (execname() == "{1}"){{
        printf("%s -> {0} (%s)\\n", thread_indent(2), $$parms)
    }}
}}
probe syscall.{0}.return{{
    if (execname() == "{1}"){{
        printf("%s <- {0} (%s)\\n", thread_indent(-2), $$return)
    }}
}}

"""



class HookException(Exception):
    pass

def parseconfig(path = './hook.config'):
    NAME = 0
    TYPE = 1
    TARGET = 2
    with open(path, encoding='utf-8') as f:
        content = f.read()
    contentlist = content.split('\n')
    while contentlist[-1] == '':
        contentlist = contentlist[:-1]
    for idx in range(len(contentlist)):
        if not contentlist[idx].strip().startswith('#'):
            contentlist[idx] = contentlist[idx].split(',')
            if not len(contentlist[idx]) == 3:
                raise HookException('Format: [funcname/syscallname], [type: function, syscall], [target: filename]')
            for i in range(len(contentlist[idx])):
                contentlist[idx][i] = contentlist[idx][i].strip()
    res = ''
    for it in contentlist:
        if not type(it) == str:
            if it[TYPE] == 'function':
                res += HOOK_FUNCTION_STR.format(it[NAME], it[TARGET])
            elif it[TYPE] == 'syscall':
                res += HOOK_SYSCALL_STR.format(it[NAME], it[TARGET])
            else:
                raise HookException('Type: function, syscall...')
        else:
            print(it)
    return res


if __name__ == '__main__':
    with open('mq_notify.c', 'w', encoding='utf-8') as f:
        f.write(parseconfig())