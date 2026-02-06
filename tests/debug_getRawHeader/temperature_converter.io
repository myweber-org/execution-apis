
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5 / 9
)

// Example usage
celsiusTemp := 25
fahrenheitTemp := CelsiusToFahrenheit(celsiusTemp)
(celsiusTemp .. "°C is " .. fahrenheitTemp .. "°F") println

fahrenheitTemp2 := 77
celsiusTemp2 := FahrenheitToCelsius(fahrenheitTemp2)
(fahrenheitTemp2 .. "°F is " .. celsiusTemp2 .. "°C") println