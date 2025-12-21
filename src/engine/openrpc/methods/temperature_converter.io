
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
celsiusValue := 25
fahrenheitValue := celsiusValue toFahrenheit
kelvinValue := celsiusValue toKelvin

("Celsius: " .. celsiusValue) println
("Fahrenheit: " .. fahrenheitValue) println
("Kelvin: " .. kelvinValue) println