
#!/usr/bin/env io

WebCrawler := Object clone do(
    fetchUrl := method(url,
        urlObj := URL with(url)
        try(
            content := urlObj fetch
            return content
        ) catch(Exception,
            writeln("Error fetching URL: ", url, " - ", Exception description)
            return nil
        )
    )

    extractLinks := method(html,
        links := List clone
        if(html,
            html split("\n") foreach(line,
                if(line containsSeq("href=\""),
                    start := line findSeq("href=\"") + 6
                    end := line findSeq("\"", start)
                    if(end,
                        link := line exSlice(start, end)
                        if(link beginsWithSeq("http"),
                            links append(link)
                        )
                    )
                )
            )
        )
        return links
    )

    crawl := method(startUrl, maxDepth,
        visited := Map clone
        toVisit := list(list(startUrl, 0))

        while(toVisit size > 0,
            current := toVisit removeFirst
            url := current at(0)
            depth := current at(1)

            if(visited hasKey(url) not and depth <= maxDepth,
                visited atPut(url, true)
                writeln("Crawling [Depth ", depth, "]: ", url)

                html := fetchUrl(url)
                if(html,
                    links := extractLinks(html)
                    links foreach(link,
                        toVisit append(list(link, depth + 1))
                    )
                )
            )
        )

        writeln("\nCrawl completed. Visited ", visited size, " unique URLs.")
    )
)

if(isLaunchScript,
    if(System args size >= 2,
        startUrl := System args at(1)
        maxDepth := if(System args size >= 3, System args at(2) asNumber, 2)
        WebCrawler crawl(startUrl, maxDepth)
    ,
        writeln("Usage: io web_crawler.io <start_url> [max_depth]")
    )
)