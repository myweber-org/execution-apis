
URL := "https://example.com"
html := URL fetch
parsed := html asXML
parsed root name println
parsed root attributes foreach(key, value,
    writeln(key, "=", value)
)