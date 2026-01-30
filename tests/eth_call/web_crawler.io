
URL := "https://example.com"
html := URL fetch
parsed := html parseHTML

parsed findElements("h1") foreach(element,
    element text println
)

parsed findElements("a") foreach(link,
    link getAttribute("href") println
)