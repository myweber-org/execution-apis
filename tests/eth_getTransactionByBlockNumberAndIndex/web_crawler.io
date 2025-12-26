
URL := "https://example.com"
html := URL fetch
if(html,
    "Fetched #{html size} bytes from #{URL}" println
    // Extract all links from the HTML
    links := html findRegex("<a href=\"([^\"]+)\"")
    links foreach(i, link,
        "Found link: #{link at(1)}" println
    )
    "Total links found: #{links size}" println,
    "Failed to fetch #{URL}" println
)