
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
"25°C in Fahrenheit: " print
CelsiusToFahrenheit(25) println

"77°F in Celsius: " print
FahrenheitToCelsius(77) println