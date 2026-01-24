
#!/usr/bin/env io

Url := Object clone do(
    fetchTitle := method(url,
        request := URL with(url) fetch
        if(request isError,
            return "Error fetching URL: #{url}" interpolate
        )
        html := request asString
        titleStart := html findSeq("<title>")
        titleEnd := html findSeq("</title>")
        if(titleStart and titleEnd,
            title := html slice(titleStart + 7, titleEnd)
            return title strip
        ,
            return "No title found for URL: #{url}" interpolate
        )
    )
)

if(isLaunchScript,
    if(System args size < 2,
        "Usage: #{System args at(0)} <url>" interpolate println
        System exit(1)
    )
    url := System args at(1)
    title := Url fetchTitle(url)
    title println
)