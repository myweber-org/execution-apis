
urls := list("https://www.google.com", "https://www.github.com", "https://www.stackoverflow.com")

urls foreach(url,
    page := URL with(url) fetch
    title := page betweenSeq("<title>", "</title>")
    ("Title of " .. url .. ": " .. title) println
)
URL := "https://example.com"
html := URL fetch
parsed := html parseHTML

parsed findElements("h1") foreach(element,
    element text println
)

parsed findElements("a") foreach(link,
    href := link attributeAt("href")
    if(href, href println)
)