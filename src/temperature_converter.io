
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
celsiusTemp := 25
fahrenheitTemp := CelsiusToFahrenheit(celsiusTemp)
writeln(celsiusTemp, "°C is ", fahrenheitTemp, "°F")

fahrenheitTemp := 77
celsiusTemp := FahrenheitToCelsius(fahrenheitTemp)
writeln(fahrenheitTemp, "°F is ", celsiusTemp, "°C")