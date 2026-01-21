
Celsius := Object clone
Celsius toFahrenheit := method((self * 9/5) + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5/9)
Fahrenheit toKelvin := method((self - 32) * 5/9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9/5 + 32)

// Example usage
celsiusValue := 100
fahrenheitValue := celsiusValue asCelsius toFahrenheit
kelvinValue := celsiusValue asCelsius toKelvin

("Original Celsius: " .. celsiusValue) println
("Converted to Fahrenheit: " .. fahrenheitValue) println
("Converted to Kelvin: " .. kelvinValue) println