
Celsius := Object clone do(
    toFahrenheit := method(self * 9/5 + 32)
    toKelvin := method(self + 273.15)
)

TemperatureConverter := Object clone do(
    convert := method(value, unit, targetUnit,
        if(unit == "C",
            if(targetUnit == "F", return value toFahrenheit)
            if(targetUnit == "K", return value toKelvin)
        )
        if(unit == "F" and targetUnit == "C",
            return (value - 32) * 5/9
        )
        if(unit == "K" and targetUnit == "C",
            return value - 273.15
        )
        "Unsupported conversion" println
    )
)

// Example usage
converter := TemperatureConverter clone
converter convert(100, "C", "F") println  // 212
converter convert(32, "F", "C") println  // 0
converter convert(0, "C", "K") println   // 273.15
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method(self toCelsius + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method(self toCelsius * 9 / 5 + 32)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, fromUnit, toUnit,
    unitMap := Map clone
    unitMap atPut("C", Celsius)
    unitMap atPut("F", Fahrenheit)
    unitMap atPut("K", Kelvin)
    
    fromObj := unitMap at(fromUnit)
    toObj := unitMap at(toUnit)
    
    if(fromObj and toObj,
        intermediate := getSlot("fromObj") doMessage(value asMessage)
        conversionMethod := "to" .. toUnit
        result := getSlot("intermediate") doMessage(Message clone setName(conversionMethod))
        return result
    ,
        return "Invalid units"
    )
)

// Example usage
// converter := TemperatureConverter clone
// converter convert(100, "C", "F") println  // 212
// converter convert(32, "F", "K") println   // 273.15