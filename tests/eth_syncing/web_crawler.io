
urls := list("https://www.google.com", "https://www.github.com", "https://www.stackoverflow.com")

urls foreach(url,
    page := URL with(url) fetch
    title := page betweenSeq("<title>", "</title>")
    ("Title of " .. url .. ": " .. title) println
)