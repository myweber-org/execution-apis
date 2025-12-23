
#!/usr/local/bin/io

Url := Object clone do(
    fetch := method(url,
        page := URL with(url) fetch
        if(page,
            title := page betweenSeq("<title>", "</title>")
            if(title, title strip, "No title found")
        )
    )
)

if(System args size > 1,
    url := System args at(1)
    title := Url fetch(url)
    title println
,
    "Please provide a URL as an argument." println
)