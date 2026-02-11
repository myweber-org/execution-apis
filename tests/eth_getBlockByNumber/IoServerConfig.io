ServerConfig := Object clone do(
    configPath := "config/server.json"
    defaultConfig := Map with(
        "port", 8080,
        "host", "127.0.0.1",
        "maxConnections", 100,
        "logLevel", "info"
    )

    load := method(
        config := defaultConfig clone
        if(File with(configPath) exists,
            try(
                jsonConfig := doFile(configPath)
                config mergeInPlace(jsonConfig)
            ) catch(Exception,
                writeln("Warning: Failed to load config file, using defaults")
            )
        )
        validate(config)
        config
    )

    validate := method(config,
        requiredKeys := list("port", "host", "maxConnections", "logLevel")
        requiredKeys foreach(key,
            if(config hasKey(key) not,
                Exception raise("Missing required config key: #{key}" interpolate)
            )
        )
        if(config at("port") < 1 or config at("port") > 65535,
            Exception raise("Port must be between 1 and 65535")
        )
        validLogLevels := list("debug", "info", "warn", "error")
        if(validLogLevels contains(config at("logLevel")) not,
            Exception raise("Invalid log level: #{config at('logLevel')}" interpolate)
        )
    )

    save := method(config,
        jsonString := "{\n"
        config keys foreach(i, key,
            value := config at(key)
            jsonString = jsonString .. "    \"#{key}\": " .. value asJson
            if(i < config size - 1, jsonString = jsonString .. ",")
            jsonString = jsonString .. "\n"
        )
        jsonString = jsonString .. "}"
        File with(configPath) openForUpdating write(jsonString) close
    )
)