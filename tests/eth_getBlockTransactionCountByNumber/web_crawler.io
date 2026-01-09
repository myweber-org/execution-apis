
#!/usr/bin/env io

UrlFetcher := Object clone do(
    fetchTitle := method(url,
        request := URL with(url) fetch
        if(request isError,
            return "Error fetching URL: #{url}" interpolate
        )
        html := request contents
        titleMatch := html findSeq("<title>")
        if(titleMatch,
            start := titleMatch + 7
            end := html findSeq("</title>", start)
            if(end,
                return html slice(start, end)
            )
        )
        return "No title found"
    )
)

if(isLaunchScript,
    if(System args size > 1,
        url := System args at(1)
        title := UrlFetcher fetchTitle(url)
        title println
    ,
        "Usage: #{System launchPath} <url>" interpolate println
    )
)