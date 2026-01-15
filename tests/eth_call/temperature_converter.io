
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

Fahrenheit := Object clone do(
    toCelsius := method((self - 32) * 5 / 9)
    toKelvin := method(self toCelsius + 273.15)
)

Kelvin := Object clone do(
    toCelsius := method(self - 273.15)
    toFahrenheit := method(self toCelsius * 9 / 5 + 32)
)

// Example usage
"25°C in Fahrenheit: " print
(25 Celsius toFahrenheit) println

"77°F in Kelvin: " print
(77 Fahrenheit toKelvin) println

"300K in Celsius: " print
(300 Kelvin toCelsius) println