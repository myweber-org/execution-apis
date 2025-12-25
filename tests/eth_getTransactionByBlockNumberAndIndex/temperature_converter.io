
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
celsiusValue := 25
fahrenheitValue := CelsiusToFahrenheit(celsiusValue)
(celsiusValue .. "°C is " .. fahrenheitValue .. "°F") println

fahrenheitValue2 := 77
celsiusValue2 := FahrenheitToCelsius(fahrenheitValue2)
(fahrenheitValue2 .. "°F is " .. celsiusValue2 .. "°C") println