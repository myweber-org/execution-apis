
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

TemperatureConverter := Object clone do(
    convert := method(value, unit, targetUnit,
        if(unit == "C",
            if(targetUnit == "F", return value toFahrenheit)
            if(targetUnit == "K", return value toKelvin)
        )
        if(unit == "F" and targetUnit == "C",
            return (value - 32) * 5 / 9
        )
        if(unit == "K" and targetUnit == "C",
            return value - 273.15
        )
        "Unsupported conversion" raise
    )
    
    formatResult := method(value, fromUnit, toUnit, result,
        "#{value}°#{fromUnit} = #{result}°#{toUnit}" interpolate
    )
)
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(celsiusValue,
    fahrenheit := celsiusValue toFahrenheit
    kelvin := celsiusValue toKelvin
    list(celsiusValue, fahrenheit, kelvin)
)

// Example usage (commented out in actual utility)
// result := TemperatureConverter convert(25)
// result foreach(v, v println)