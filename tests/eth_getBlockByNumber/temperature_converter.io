
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

TemperatureConverter := Object clone do(
    convert := method(value, unit, targetUnit,
        if(unit == "C" and targetUnit == "F", return value toFahrenheit)
        if(unit == "C" and targetUnit == "K", return value toKelvin)
        if(unit == "F" and targetUnit == "C", return (value - 32) * 5 / 9)
        if(unit == "F" and targetUnit == "K", return (value - 32) * 5 / 9 + 273.15)
        if(unit == "K" and targetUnit == "C", return value - 273.15)
        if(unit == "K" and targetUnit == "F", return (value - 273.15) * 9 / 5 + 32)
        Exception raise("Unsupported conversion from #{unit} to #{targetUnit}" interpolate)
    )
    
    displayConversions := method(value, unit,
        if(unit == "C",
            f := value toFahrenheit
            k := value toKelvin
            writeln("#{value}°C = #{f}°F = #{k}K" interpolate)
        )
        if(unit == "F",
            c := (value - 32) * 5 / 9
            k := c + 273.15
            writeln("#{value}°F = #{c}°C = #{k}K" interpolate)
        )
        if(unit == "K",
            c := value - 273.15
            f := c * 9 / 5 + 32
            writeln("#{value}K = #{c}°C = #{f}°F" interpolate)
        )
    )
)