
URL := "https://example.com"
html := URL fetch asString

startTag := "<title>"
endTag := "</title>"

startIndex := html findSeq(startTag)
if(startIndex,
    endIndex := html findSeq(endTag, startIndex)
    if(endIndex,
        titleStart := startIndex + startTag size
        title := html slice(titleStart, endIndex)
        title println
    )
)