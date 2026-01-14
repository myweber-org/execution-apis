
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
converter := Object clone
converter convert := method(value, fromUnit, toUnit,
    unitMap := Map clone
    unitMap atPut("C", Celsius)
    unitMap atPut("F", Fahrenheit)
    unitMap atPut("K", Kelvin)
    
    fromObj := unitMap at(fromUnit) clone
    fromObj setProto(value)
    
    conversionMethod := "to" .. toUnit
    fromObj perform(conversionMethod)
)

// Test conversions
converter convert(100, "C", "F") println
converter convert(212, "F", "C") println
converter convert(0, "C", "K") println
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