
#!/usr/local/bin/io

Url := Object clone do(
    fetch := method(url,
        url := if(url asLower beginsWithSeq("http"), url, "http://" .. url)
        page := URL with(url) fetch
        if(page,
            titleRegex := Regex with("<title>(.*?)</title>")
            match := titleRegex matches(page)
            if(match, match at(1) strip, "No title found")
        ,
            "Failed to fetch page"
        )
    )
)

if(System args size > 1,
    url := System args at(1)
    title := Url fetch(url)
    title println
,
    "Usage: web_crawler.io <url>" println
)