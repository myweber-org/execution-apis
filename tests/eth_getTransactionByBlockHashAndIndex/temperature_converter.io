
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

Fahrenheit := Object clone do(
    toCelsius := method((self - 32) * 5 / 9)
    toKelvin := method(self toCelsius + 273.15)
)

Kelvin := Object clone do(
    toCelsius := method(self - 273.15)
    toFahrenheit := method(self toCelsius * 9 / 5 + 32)
)

TemperatureConverter := Object clone do(
    convert := method(value, fromUnit, toUnit,
        unitMap := Map clone atPut("C", Celsius) atPut("F", Fahrenheit) atPut("K", Kelvin)
        fromObj := unitMap at(fromUnit)
        toMethod := "to" .. toUnit
        fromObj getSlot(toMethod) call(value)
    )
    
    formatResult := method(value, fromUnit, toUnit, result,
        value asString .. fromUnit .. " = " .. result asString(0, 2) .. toUnit
    )
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(100, "C", "F")
converter formatResult(100, "C", "F", result) println

result2 := converter convert(212, "F", "K")
converter formatResult(212, "F", "K", result2) println