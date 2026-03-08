
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "C",
            list("F" = value toFahrenheit, "K" = value toKelvin),
        if(unit == "F",
            celsius := (value - 32) * 5 / 9
            list("C" = celsius, "K" = celsius toKelvin),
        if(unit == "K",
            celsius := value - 273.15
            list("C" = celsius, "F" = celsius toFahrenheit),
            "Invalid unit"
        )))
    )
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(100, "C")
result println

result2 := converter convert(212, "F")
result2 println
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5 / 9
)

// Example usage
"25°C is #{CelsiusToFahrenheit(25)}°F" println
"77°F is #{FahrenheitToCelsius(77)}°C" println