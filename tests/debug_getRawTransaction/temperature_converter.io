
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
    units := Map clone
    units atPut("C", Celsius)
    units atPut("F", Fahrenheit)
    units atPut("K", Kelvin)
    
    conversionMethod := "to" .. toUnit
    sourceUnit := units at(fromUnit)
    
    if(sourceUnit hasSlot(conversionMethod),
        return sourceUnit getSlot(conversionMethod) call(value)
    )
    
    Exception raise("Unsupported conversion from #{fromUnit} to #{toUnit}" interpolate)
)

// Example usage
// converter := TemperatureConverter clone
// converter convert(100, "C", "F") println  // 212
// converter convert(32, "F", "K") println   // 273.15