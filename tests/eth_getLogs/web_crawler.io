
URL := "https://www.example.com"
titleRegex := Regex clone with("(?i)<title>(.*?)</title>")

fetchTitle := method(url,
    try(
        pageContent := URL with(url) fetch
        matches := titleRegex matchesIn(pageContent)
        if(matches size > 0,
            matches first at(1) strip
        ,
            "No title found"
        )
    ) catch(Exception,
        "Failed to fetch: " .. Exception error
    )
)

result := fetchTitle(URL)
result println
URL := "https://example.com"
html := URL fetch asString
"Fetched #{html size} bytes from #{URL}" println

doc := html parseHTML
links := doc links
"Found #{links size} links:" println
links foreach(link, link println)