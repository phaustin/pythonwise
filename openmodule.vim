" Open a module (in sys.path) in a new window (like CTRL-M in IDLE)
" Place this somewhere in your .vimrc

func OpenModule(name)
python << EOF
import vim
name = vim.eval("a:name")
try:
    module = __import__(name)
    filename = getattr(module, "__file__", None)
    if filename:
        import re
        filename = re.sub(".py[co]", ".py", filename)
        vim.command("e %s" % filename)
    else:
        print "error: can't find module `%s` source" % name
except ImportError:
    print "error: can't find `%s` module" % name
EOF
endfunc
comm! -nargs=1 OM call OpenModule(<f-args>)
