
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
*/
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
    unitMap := Map clone
    unitMap atPut("C", Celsius)
    unitMap atPut("F", Fahrenheit)
    unitMap atPut("K", Kelvin)
    
    fromObj := unitMap at(fromUnit)
    toObj := unitMap at(toUnit)
    
    if(fromObj and toObj,
        conversionMethod := "to" .. toUnit
        if(fromUnit == toUnit, return value)
        return fromObj getSlot(conversionMethod) call(value)
    ,
        Exception raise("Invalid temperature unit")
    )
)

// Example usage
// converter := TemperatureConverter clone
// result := converter convert(100, "C", "F")
// result println // Should print 212
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
celsiusTemp := 25
fahrenheitTemp := CelsiusToFahrenheit(celsiusTemp)
writeln(celsiusTemp, "°C is ", fahrenheitTemp, "°F")

fahrenheitTemp2 := 77
celsiusTemp2 := FahrenheitToCelsius(fahrenheitTemp2)
writeln(fahrenheitTemp2, "°F is ", celsiusTemp2, "°C")