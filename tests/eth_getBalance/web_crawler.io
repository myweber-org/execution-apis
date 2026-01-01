
URL := "https://example.com"
html := URL fetch asString
"Fetched #{html size} bytes from #{URL}" println

if(html contains("Example Domain"),
    "Found 'Example Domain' in the response" println,
    "Did not find expected content" println
)