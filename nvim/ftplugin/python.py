from __future__ import unicode_literals, absolute_import, print_function

import imp
import os
import re
import vim


def gf_python_find_module(module, path=None):
    parts = module.split('.')
    if len(parts) == 1:
        if path:
            fh, filename, (suffix, mode, type_) = imp.find_module(module, [path])
        else:
            fh, filename, (suffix, mode, type_) = imp.find_module(module)
        try:
            if type_ == imp.PKG_DIRECTORY:
                return os.path.join(filename, '__init__.py')
            elif type_ == imp.PY_COMPILED:
                return filename.rstirp('c')
            elif type_ == imp.PY_SOURCE:
                return filename
            else:
                raise Exception()
        finally:
            if fh:
                fh.close()
    else:
        if path:
            fh, filename, (suffix, mode, type_) = imp.find_module(parts[0], [path])
        else:
            fh, filename, (suffix, mode, type_) = imp.find_module(parts[0])
        try:
            return gf_python_find_module('.'.join(parts[1:]), filename)
        finally:
            if fh:
                fh.close()


def python_goto_file():
    cw = vim.eval("getline('.')")
    if 'from ' in cw:
        _cw = '.'
    else:
        _cw = ''
    cw = cw.replace('from ', '').replace('import ', _cw).replace(' ', '')
    print(cw)
    module = re.sub('\.', '/', cw)
    try:
        filename = gf_python_find_module(module)
    except:
        print('E447: Can\'t find module "%s"' % module, file=sys.stderr)
    else:
        vim.command('edit %s' % filename)
    return
