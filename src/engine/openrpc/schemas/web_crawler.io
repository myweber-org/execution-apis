#!/usr/bin/env io

UrlFetcher := Object clone do(
    fetchTitle := method(url,
        request := URL with(url) fetch
        if(request isError,
            return "Error fetching URL: #{url}" interpolate,
            // Extract title from HTML
            html := request contents
            titleStart := html findSeq("<title>")
            titleEnd := html findSeq("</title>")
            if(titleStart and titleEnd,
                return html exclusiveSlice(titleStart + 7, titleEnd)
            ,
                return "No title found for URL: #{url}" interpolate
            )
        )
    )
)

// Example usage
fetcher := UrlFetcher clone
title := fetcher fetchTitle("https://example.com")
title println