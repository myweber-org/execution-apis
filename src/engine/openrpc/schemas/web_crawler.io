
URL := "https://example.com"
titleRegex := Regex with("(?i)<title>(.*?)</title>")

fetchTitle := method(url,
    request := URL with(url) fetch
    if(request isNil,
        writeln("Failed to fetch: ", url),
        matches := titleRegex matchesInString(request)
        if(matches size > 0,
            writeln("Title: ", matches at(0) at(1)),
            writeln("No title found")
        )
    )
)

fetchTitle(URL)