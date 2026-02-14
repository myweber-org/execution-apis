
IoLanguageServer := Object clone do(
    init := method(
        self buffer := Map clone
        self handlers := Map clone
        self setupHandlers
    )
    
    setupHandlers := method(
        handlers atPut("initialize", method(params, 
            Map clone atPut("capabilities", Map clone atPut("textDocumentSync", 1))
        ))
        
        handlers atPut("textDocument/didOpen", method(params,
            textDocument := params at("textDocument")
            uri := textDocument at("uri")
            text := textDocument at("text")
            buffer atPut(uri, text)
            nil
        ))
        
        handlers atPut("textDocument/didChange", method(params,
            textDocument := params at("textDocument")
            contentChanges := params at("contentChanges")
            uri := textDocument at("uri")
            if(contentChanges size > 0,
                buffer atPut(uri, contentChanges first at("text"))
            )
            nil
        ))
        
        handlers atPut("textDocument/hover", method(params,
            textDocument := params at("textDocument")
            position := params at("position")
            uri := textDocument at("uri")
            currentText := buffer at(uri)
            
            if(currentText,
                Map clone atPut("contents", "Io Language: " .. currentText slice(0, 30))
            ,
                Map clone atPut("contents", "")
            )
        ))
        
        handlers atPut("textDocument/completion", method(params,
            completions := list(
                Map clone atPut("label", "Object") atPut("kind", 7),
                Map clone atPut("label", "List") atPut("kind", 7),
                Map clone atPut("label", "Map") atPut("kind", 7),
                Map clone atPut("label", "clone") atPut("kind", 2),
                Map clone atPut("label", "do") atPut("kind", 2),
                Map clone atPut("label", "method") atPut("kind", 2)
            )
            Map clone atPut("isIncomplete", false) atPut("items", completions)
        ))
        
        handlers atPut("shutdown", method(params, nil))
        
        handlers atPut("exit", method(params, System exit(0)))
    )
    
    handleRequest := method(method, params, id,
        handler := handlers at(method)
        if(handler,
            result := handler call(params)
            if(id, 
                Map clone atPut("id", id) atPut("result", result) atPut("jsonrpc", "2.0")
            )
        ,
            if(id,
                Map clone atPut("id", id) atPut("error", Map clone atPut("code", -32601) atPut("message", "Method not found")) atPut("jsonrpc", "2.0")
            )
        )
    )
    
    handleNotification := method(method, params,
        handler := handlers at(method)
        if(handler, handler call(params))
    )
    
    evaluateCode := method(code,
        try(
            result := doString(code)
            Map clone atPut("result", result asString) atPut("success", true)
        ) catch(Exception,
            Map clone atPut("error", Exception description) atPut("success", false)
        )
    )
)

server := IoLanguageServer clone
server init

"LSP server initialized" println