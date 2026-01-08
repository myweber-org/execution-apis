
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
if(isLaunchScript,
    celsiusValue := 25
    fahrenheitValue := CelsiusToFahrenheit(celsiusValue)
    writeln(celsiusValue, "°C is ", fahrenheitValue, "°F")

    fahrenheitValue2 := 77
    celsiusValue2 := FahrenheitToCelsius(fahrenheitValue2)
    writeln(fahrenheitValue2, "°F is ", celsiusValue2, "°C")
)
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "CtoF", return CelsiusToFahrenheit(value))
        if(unit == "CtoK", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion unit: " .. unit)
    )
    
    displayConversions := method(celsiusValue,
        fahrenheit := CelsiusToFahrenheit(celsiusValue)
        kelvin := CelsiusToKelvin(celsiusValue)
        writeln(celsiusValue, "°C = ", fahrenheit, "°F = ", kelvin, "K")
    )
)

// Example usage
if(isLaunchScript,
    converter := TemperatureConverter clone
    converter displayConversions(0)
    converter displayConversions(100)
    
    writeln("25°C to Fahrenheit: ", converter convert(25, "CtoF"))
    writeln("25°C to Kelvin: ", converter convert(25, "CtoK"))
)