
Server := Object clone do(
    handleRequest := method(request,
        "Received: #{request}" interpolate
    )
)

server := Server clone
server handleRequest("Test request from client") println