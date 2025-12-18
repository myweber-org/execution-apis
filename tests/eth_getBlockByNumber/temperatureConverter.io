
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, unit,
    if(unit == "C",
        list("Fahrenheit" : value toFahrenheit, "Kelvin" : value toKelvin),
        if(unit == "F",
            celsiusValue := (value - 32) * 5 / 9,
            list("Celsius" : celsiusValue, "Kelvin" : celsiusValue toKelvin)
        ),
        if(unit == "K",
            celsiusValue := value - 273.15,
            list("Celsius" : celsiusValue, "Fahrenheit" : celsiusValue toFahrenheit)
        )
    )
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(100, "C")
result println