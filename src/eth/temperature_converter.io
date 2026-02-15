
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method(self toCelsius + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method(self toCelsius * 9 / 5 + 32)

// Example usage
"25°C in Fahrenheit: " print; (25 Celsius toFahrenheit) println
"100°F in Celsius: " print; (100 Fahrenheit toCelsius) println
"300K in Celsius: " print; (300 Kelvin toCelsius) println
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
c := 100
f := CelsiusToFahrenheit(c)
c2 := FahrenheitToCelsius(f)

("Original Celsius: " .. c .. " -> Fahrenheit: " .. f) println
("Converted back: " .. f .. " -> Celsius: " .. c2) println