
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