
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