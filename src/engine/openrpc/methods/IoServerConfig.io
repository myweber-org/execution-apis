
Config := Object clone do(
    port := 8080
    host := "localhost"
    debug := false

    loadFromEnv := method(
        if(System getEnvironmentVariable("IO_PORT"),
            port = System getEnvironmentVariable("IO_PORT") asNumber
        )
        if(System getEnvironmentVariable("IO_HOST"),
            host = System getEnvironmentVariable("IO_HOST")
        )
        if(System getEnvironmentVariable("IO_DEBUG"),
            debug = System getEnvironmentVariable("IO_DEBUG") asLowercase == "true"
        )
        self
    )

    loadFromFile := method(path,
        file := File with(path)
        if(file exists,
            file openForReading
            contents := file readToEnd
            file close

            lines := contents split("\n")
            lines foreach(line,
                if(line size > 0 and line beginsWithSeq("#") not,
                    parts := line split("=")
                    if(parts size == 2,
                        key := parts at(0) strip
                        value := parts at(1) strip

                        if(key == "port", port = value asNumber)
                        if(key == "host", host = value)
                        if(key == "debug", debug = value asLowercase == "true")
                    )
                )
            )
        )
        self
    )

    printConfig := method(
        "Server Configuration:" println
        ("  Host: " .. host) println
        ("  Port: " .. port) println
        ("  Debug: " .. debug) println
    )
)

// Example usage
config := Config clone
config loadFromEnv
config loadFromFile("config.ini")
config printConfig