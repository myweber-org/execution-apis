
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method((self - 32) * 5 / 9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9 / 5 + 32)

// Example usage
"25 Celsius in Fahrenheit: " print
Celsius toFahrenheit(25) println

"98.6 Fahrenheit in Celsius: " print
Fahrenheit toCelsius(98.6) println

"300 Kelvin in Celsius: " print
Kelvin toCelsius(300) println