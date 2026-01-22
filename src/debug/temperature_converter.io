
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
"77°F in Celsius: " print; (77 Fahrenheit toCelsius) println
"300K in Celsius: " print; (300 Kelvin toCelsius) println