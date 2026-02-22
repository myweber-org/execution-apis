
URL := "https://www.example.com"
title := URL fetch asString betweenSeq("<title>", "</title>")
("Title: " .. title) println
URL := "https://example.com"
html := URL fetch
"Fetched #{html size} bytes from #{URL}" println

// Extract all links from the HTML
links := html findRegex("href=\"(http[^\"]+)\"")
links foreach(link, "Found link: #{link at(1)}" println)