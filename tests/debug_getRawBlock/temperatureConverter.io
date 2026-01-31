
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, unit,
    if(unit == "C",
        return list(value, value toFahrenheit, value toKelvin),
        if(unit == "F",
            celsius := (value - 32) * 5 / 9,
            return list(celsius, celsius toFahrenheit, celsius toKelvin)
        ),
        if(unit == "K",
            celsius := value - 273.15,
            return list(celsius, celsius toFahrenheit, celsius toKelvin)
        )
    )
    return "Invalid unit"
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(25, "C")
result println

result2 := converter convert(77, "F")
result2 println