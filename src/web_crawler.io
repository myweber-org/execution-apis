
URL := "https://example.com"
html := URL fetch asString

if(html containsSeq("Example Domain"),
    writeln("Found target content"),
    writeln("Content not found")
)

links := html findRegex("<a href=\"(.*?)\">")
links foreach(link, writeln("Link found: ", link at(1)))