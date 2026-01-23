
#!/usr/bin/env io

Server := Object clone do(
    handleRequest := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello, World from Io!")
        response close
    )
)

port := 8080
server := Server clone
server start(port)
writeln("Server running on port ", port)
server wait