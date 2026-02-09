
URL := "https://example.com"
html := URL fetch
parsed := html parseHTML

parsed findElements("h1") foreach(element,
    element text println
)

parsed findElements("a") foreach(link,
    link getAttribute("href") println
)
UrlList := list("https://www.example.com", "https://www.google.com", "https://github.com")

UrlList foreach(url,
    title := URL with(url) fetch at("title")
    if(title,
        ("Title for " .. url .. ": " .. title) println
    ,
        ("Failed to fetch title from " .. url) println
    )
)