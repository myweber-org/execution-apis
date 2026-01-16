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