
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