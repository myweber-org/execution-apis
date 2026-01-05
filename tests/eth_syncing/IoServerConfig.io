Server := Object clone do(
    port := 8080
    handler := method(request, response,
        response setStatus(200)
        response setHeader("Content-Type", "text/plain")
        response write("Hello from Io server")
        response close
    )
    
    start := method(
        "Server starting on port #{port}" interpolate println
        NetworkService startServer("0.0.0.0", port, handler)
    )
)

if(isLaunchScript,
    Server start
    "Press Enter to stop server" println
    File standardInput readLine
    "Server stopped" println
)