
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
/*
c := 100
f := c asCelsius toFahrenheit
k := c asCelsius toKelvin
("Celsius: " .. c .. " -> Fahrenheit: " .. f .. ", Kelvin: " .. k) println
*/

Number asCelsius := method(Celsius clone setProto(self))
Number asFahrenheit := method(Fahrenheit clone setProto(self))
Number asKelvin := method(Kelvin clone setProto(self))