
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method((self - 32) * 5 / 9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9 / 5 + 32)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, fromUnit, toUnit,
    if(fromUnit == "C" and toUnit == "F", return value asNumber Celsius toFahrenheit)
    if(fromUnit == "C" and toUnit == "K", return value asNumber Celsius toKelvin)
    if(fromUnit == "F" and toUnit == "C", return value asNumber Fahrenheit toCelsius)
    if(fromUnit == "F" and toUnit == "K", return value asNumber Fahrenheit toKelvin)
    if(fromUnit == "K" and toUnit == "C", return value asNumber Kelvin toCelsius)
    if(fromUnit == "K" and toUnit == "F", return value asNumber Kelvin toFahrenheit)
    "Invalid conversion" println
)

// Example usage
// TemperatureConverter convert(100, "C", "F") println
// TemperatureConverter convert(212, "F", "K") println