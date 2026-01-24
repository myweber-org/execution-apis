
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
/*
c := 100
c println
(c Celsius toFahrenheit) println
(c Celsius toKelvin) println

f := 212
(f Fahrenheit toCelsius) println

k := 373.15
(k Kelvin toCelsius) println
*/