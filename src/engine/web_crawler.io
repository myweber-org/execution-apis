#!/usr/bin/env io

Url := Object clone do(
    fetchTitle := method(url,
        page := URL with(url) fetch
        if(page,
            matches := page findSeq("<title>")
            if(matches,
                start := matches at(0) begin + 7
                end := page findSeq("</title>") at(0) begin
                page slice(start, end)
            ,
                "No title found"
            )
        ,
            "Failed to fetch page"
        )
    )
)

if(isLaunchScript,
    if(System args size > 1,
        title := Url fetchTitle(System args at(1))
        title println
    ,
        "Usage: web_crawler.io <url>" println
    )
)