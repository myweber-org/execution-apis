
URLFetcher := Object clone do(
    fetch := method(url, timeout,
        request := URL with(url) fetch(timeout)
        if(request isError,
            Exception raise("Failed to fetch URL: #{url}" interpolate)
        )
        request content
    )
    
    fetchAsync := method(url, callback,
        URL with(url) asyncFetch(callback)
    )
)

Fetcher := URLFetcher clone

result := try(
    Fetcher fetch("https://example.com", 30)
) catch(Exception,
    writeln("Error: ", error)
)

Fetcher fetchAsync("https://example.com", 
    block(response, 
        if(response isError not,
            writeln("Async response length: ", response content size)
        )
    )
)