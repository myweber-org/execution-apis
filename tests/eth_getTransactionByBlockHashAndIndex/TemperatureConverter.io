
TemperatureConverter := Object clone do(
    toFahrenheit := method(celsius,
        (celsius * 9/5) + 32
    )
    
    toKelvin := method(celsius,
        celsius + 273.15
    )
    
    convertAll := method(celsius,
        fahrenheit := self toFahrenheit(celsius)
        kelvin := self toKelvin(celsius)
        Map with(
            "celsius", celsius,
            "fahrenheit", fahrenheit,
            "kelvin", kelvin
        )
    )
)

converter := TemperatureConverter clone
result := converter convertAll(25)
result keys foreach(key,
    value := result at(key)
    ("#{key}: #{value}" interpolate) println
)