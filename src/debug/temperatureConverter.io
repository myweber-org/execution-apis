
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, unit,
    if(unit == "C",
        list("F" = value toFahrenheit, "K" = value toKelvin),
    if(unit == "F",
        celsius := (value - 32) * 5 / 9,
        list("C" = celsius, "K" = celsius toKelvin)),
    if(unit == "K",
        celsius := value - 273.15,
        list("C" = celsius, "F" = celsius toFahrenheit))
    )
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(100, "C")
result foreach(key, value, writeln(key, ": ", value))
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, unit,
    if(unit == "C",
        list("F" = value toFahrenheit, "K" = value toKelvin),
    if(unit == "F",
        list("C" = (value - 32) * 5 / 9, "K" = ((value - 32) * 5 / 9) + 273.15),
    if(unit == "K",
        list("C" = value - 273.15, "F" = ((value - 273.15) * 9 / 5) + 32),
        "Invalid unit"
    )))
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(100, "C")
result println

result2 := converter convert(212, "F")
result2 println