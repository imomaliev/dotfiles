if exists("g:loaded_nerdtree_create_python_package")
  finish
endif

let g:loaded_nerdtree_create_python_package = 1


function! CreatePythonPackage()
    let curDirNode = g:NERDTreeDirNode.GetSelected()

    let newNodeName = input("Add a package\n".
                          \ "==========================================================\n".
                          \ "", curDirNode.path.str() . g:NERDTreePath.Slash(), "file")

    let newNodeName = newNodeName."/__init__.py" 
    if newNodeName ==# ''
        call nerdtree#echo("Node Creation Aborted.")
        return
    endif

    try
        let newPath = g:NERDTreePath.Create(newNodeName)
        let parentNode = b:NERDTree.root.findNode(newPath.getParent())

        let newTreeNode = g:NERDTreeFileNode.New(newPath, b:NERDTree)
        if empty(parentNode)
            call b:NERDTree.root.refresh()
            call b:NERDTree.render()
        elseif parentNode.isOpen || !empty(parentNode.children)
            call parentNode.addChild(newTreeNode, 1)
            call NERDTreeRender()
            call newTreeNode.putCursorHere(1, 0)
        endif
    catch /^NERDTree/
        call nerdtree#echoWarning("Node Not Created.")
    endtry
endfunction

call NERDTreeAddMenuItem({
    \ 'text': 'create python packa(g)e',
    \ 'shortcut': 'g',
    \ 'callback': 'CreatePythonPackage' })
