
URL := "https://www.example.com"
title := URL fetch asXML root at("head") at("title") text
("Title: " .. title) println
URL := "https://www.example.com"
titleRegex := Regex with("(?i)<title>(.*?)</title>")

fetchTitle := method(url,
    try(
        pageContent := URL with(url) fetch
        matches := titleRegex matchesIn(pageContent)
        if(matches size > 0,
            matches at(0) groupAt(1) strip
        ,
            "No title found"
        )
    ) catch(Exception,
        "Error fetching URL: " .. (Exception error)
    )
)

title := fetchTitle(URL)
title println