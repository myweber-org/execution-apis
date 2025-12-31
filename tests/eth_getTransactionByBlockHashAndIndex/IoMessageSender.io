MessageSender := Object clone do(
    maxRetries := 3
    retryDelay := 1000

    send := method(message, recipient,
        retries := 0
        while(retries < maxRetries,
            try(
                "Sending message to #{recipient}: #{message}" interpolate println
                // Simulate network operation
                if(Random value > 0.3, 
                    return "Message delivered successfully to #{recipient}" interpolate
                ,
                    Exception raise("Network error")
                )
            ) catch(Exception,
                retries = retries + 1
                if(retries < maxRetries,
                    "Attempt #{retries} failed, retrying in #{retryDelay}ms" interpolate println
                    Duration sleep(retryDelay)
                )
            )
        )
        "Failed to send message after #{maxRetries} attempts" interpolate
    )
)

// Example usage
sender := MessageSender clone
result := sender send("Hello World", "user@example.com")
result println