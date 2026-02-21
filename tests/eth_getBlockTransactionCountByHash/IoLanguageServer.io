
IoLanguageServer := Object clone do(
    init := method(
        self clients := Map clone
        self documents := Map clone
    )

    handleRequest := method(requestId, method, params,
        handler := self getSlot(method)
        if(handler,
            result := handler call(params)
            self sendResponse(requestId, result)
        ,
            self sendError(requestId, "Method not found: #{method}" interpolate)
        )
    )

    didOpen := method(params,
        uri := params at("textDocument") at("uri")
        text := params at("textDocument") at("text")
        documents atPut(uri, text)
        self analyzeDocument(uri, text)
    )

    didChange := method(params,
        uri := params at("textDocument") at("uri")
        changes := params at("contentChanges")
        text := documents at(uri)
        changes foreach(change,
            if(change hasKey("range"),
                range := change at("range")
                start := range at("start")
                end := range at("end")
                text = self applyTextChange(text, start, end, change at("text"))
            ,
                text = change at("text")
            )
        )
        documents atPut(uri, text)
        self analyzeDocument(uri, text)
    )

    completion := method(params,
        uri := params at("textDocument") at("uri")
        position := params at("position")
        line := position at("line") + 1
        char := position at("character") + 1
        
        text := documents at(uri)
        lines := text split("\n")
        currentLine := lines at(line - 1) exSlice(0, char)
        
        completions := List clone
        
        if(currentLine endsWithSeq("."),
            prefix := currentLine beforeSeq(".")
            completions = self getCompletionsForPrefix(prefix)
        )
        
        return completions map(completion,
            Map clone atPut("label", completion) atPut("kind", 2)
        )
    )

    analyzeDocument := method(uri, text,
        diagnostics := List clone
        
        try(
            Lobby doString(text)
        ) catch(Exception,
            diagnostics append(
                Map clone atPut("range", 
                    Map clone atPut("start", Map clone atPut("line", 0) atPut("character", 0))
                    atPut("end", Map clone atPut("line", 0) atPut("character", 1))
                ) atPut("severity", 1)
                atPut("message", Exception description)
            )
        )
        
        self sendNotification("textDocument/publishDiagnostics", 
            Map clone atPut("uri", uri) atPut("diagnostics", diagnostics)
        )
    )

    getCompletionsForPrefix := method(prefix,
        obj := Lobby getSlot(prefix)
        if(obj isNil, return List clone)
        
        return obj slotNames select(name, 
            name beginsWithSeq(prefix) not and 
            name beginsWithSeq("_") not
        )
    )

    applyTextChange := method(text, start, end, newText,
        lines := text split("\n")
        startLine := start at("line")
        endLine := end at("line")
        
        if(startLine == endLine,
            line := lines at(startLine)
            newLine := line exSlice(0, start at("character")) .. newText .. line exSlice(end at("character"))
            lines atPut(startLine, newLine)
        ,
            // Handle multi-line replacement
            firstPart := lines at(startLine) exSlice(0, start at("character"))
            lastPart := lines at(endLine) exSlice(end at("character"))
            newLines := lines slice(0, startLine) append(firstPart .. newText .. lastPart) append(lines slice(endLine + 1))
            lines = newLines
        )
        
        return lines join("\n")
    )

    sendResponse := method(requestId, result,
        // Implementation would send JSON-RPC response
        nil
    )

    sendError := method(requestId, message,
        // Implementation would send JSON-RPC error
        nil
    )

    sendNotification := method(method, params,
        // Implementation would send JSON-RPC notification
        nil
    )
)