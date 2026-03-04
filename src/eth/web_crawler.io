#!/usr/bin/env io

Url := Object clone do(
    fetch := method(url,
        url := if(url asString beginsWithSeq("http"), url, "http://" .. url)
        response := URL with(url) fetch
        if(response isError,
            Exception raise("Failed to fetch URL: " .. url .. " - " .. response error),
            response
        )
    )
)

HtmlParser := Object clone do(
    extractLinks := method(html,
        links := List clone
        html findallSeq("<a href=\"") foreach(i, pos,
            endPos := html findSeq("\"", pos + 9)
            if(endPos, links append(html slice(pos + 9, endPos)))
        )
        links
    )
    
    extractText := method(html,
        text := html asMutable
        while(text containsSeq("<"),
            start := text findSeq("<")
            end := text findSeq(">", start)
            if(start and end, text removeSlice(start, end))
        )
        text replaceSeq("&nbsp;", " ") replaceSeq("&amp;", "&") asMutable strip
    )
)

WebCrawler := Object clone do(
    visitedUrls := Map clone
    
    crawl := method(url, maxDepth := 2,
        if(visitedUrls at(url) or maxDepth < 1, return)
        visitedUrls atPut(url, true)
        
        writeln("Crawling: ", url)
        
        try(
            html := Url fetch(url)
            parser := HtmlParser clone
            
            text := parser extractText(html)
            writeln("Text preview: ", text slice(0, 100) .. "...")
            
            links := parser extractLinks(html)
            writeln("Found ", links size, " links")
            
            links foreach(link,
                if(link beginsWithSeq("http"),
                    crawl(link, maxDepth - 1)
                )
            )
        ) catch(Exception,
            writeln("Error crawling ", url, ": ", error)
        )
    )
)

if(isLaunchScript,
    crawler := WebCrawler clone
    crawler crawl("example.com", 1)
)
WebCrawler := Object clone do(
    fetch := method(url,
        request := URL with(url) fetch
        if(request isError,
            Exception raise("Failed to fetch URL: " .. url)
        )
        request body
    )
    
    extractLinks := method(html,
        links := List clone
        html findSeq("<a href=\"") repeat(
            startPos := html findSeq("<a href=\"") 
            if(startPos isNil, break)
            
            html removeSeq(0, startPos + 9)
            endPos := html findSeq("\"")
            if(endPos isNil, break)
            
            link := html slice(0, endPos)
            links append(link)
            html removeSeq(0, endPos + 1)
        )
        links
    )
    
    crawl := method(url, maxDepth,
        self crawlImpl(url, maxDepth, List clone)
    )
    
    crawlImpl := method(url, depth, visited,
        if(depth < 1 or visited contains(url), return List clone)
        
        visited append(url)
        result := Map clone atPut("url", url)
        
        try(
            html := self fetch(url)
            result atPut("content", html slice(0, 100) .. "...")
            
            links := self extractLinks(html)
            result atPut("links", links)
            
            childResults := List clone
            links foreach(link,
                fullUrl := if(link beginsWithSeq("http"), 
                    link, 
                    url .. (if(url endsWithSeq("/"), "", "/")) .. link
                )
                childResults appendSeq(self crawlImpl(fullUrl, depth - 1, visited))
            )
            result atPut("children", childResults)
        ) catch(Exception,
            result atPut("error", "Failed to crawl: " .. Exception description)
        )
        
        list(result)
    )
)

// Example usage
crawler := WebCrawler clone
results := crawler crawl("https://example.com", 2)
results foreach(result,
    ("URL: " .. result at("url")) println
    ("Content preview: " .. (result at("content") ?: "No content")) println
    ("Links found: " .. (result at("links") size ?: 0)) println
    "" println
)