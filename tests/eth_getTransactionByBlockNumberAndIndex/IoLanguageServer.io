
Lobby do(
    LanguageServer := Object clone do(
        handleRequest := method(request,
            // Process LSP request and return response
            response := Map clone
            response atPut("jsonrpc", "2.0")
            response atPut("id", request at("id"))
            response atPut("result", processMethod(request at("method"), request at("params")))
            response
        )
        
        processMethod := method(methodName, params,
            // Route to appropriate handler based on method
            handlers := Map clone
            handlers atPut("initialize", block(initialize(params)))
            handlers atPut("textDocument/completion", block(completion(params)))
            handlers atPut("textDocument/hover", block(hover(params)))
            
            handler := handlers at(methodName)
            if(handler, handler call, Map clone)
        )
        
        initialize := method(params,
            Map clone atPut("capabilities", Map clone atPut("completionProvider", true))
        )
        
        completion := method(params,
            items := list(
                Map clone atPut("label", "Object") atPut("kind", 7),
                Map clone atPut("label", "List") atPut("kind", 7),
                Map clone atPut("label", "Map") atPut("kind", 7)
            )
            Map clone atPut("items", items) atPut("isIncomplete", false)
        )
        
        hover := method(params,
            Map clone atPut("contents", "Io Language Server v1.0")
        )
    )
    
    // Start server when file is executed
    if(System args size > 0 and System args first == "--server",
        server := LanguageServer clone
        while(true,
            request := File standardInput readLine
            if(request,
                response := server handleRequest(doString(request))
                response asJson println
            )
        )
    )
)