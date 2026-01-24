
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, unit,
    if(unit == "C",
        list("F" = value toFahrenheit, "K" = value toKelvin),
    if(unit == "F",
        celsiusValue := (value - 32) * 5 / 9,
        list("C" = celsiusValue, "K" = celsiusValue toKelvin)),
    if(unit == "K",
        celsiusValue := value - 273.15,
        list("C" = celsiusValue, "F" = celsiusValue toFahrenheit))
    )
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(100, "C")
result println

result2 := converter convert(212, "F")
result2 println