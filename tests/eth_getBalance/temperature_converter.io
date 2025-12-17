
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
celsiusTemp := 25
fahrenheitTemp := CelsiusToFahrenheit(celsiusTemp)
("Celsius: " .. celsiusTemp .. " -> Fahrenheit: " .. fahrenheitTemp) println

fahrenheitTemp2 := 77
celsiusTemp2 := FahrenheitToCelsius(fahrenheitTemp2)
("Fahrenheit: " .. fahrenheitTemp2 .. " -> Celsius: " .. celsiusTemp2) println