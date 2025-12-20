
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