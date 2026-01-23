
TemperatureConverter := Object clone do(
    toFahrenheit := method(celsius, celsius * 9 / 5 + 32)
    toKelvin := method(celsius, celsius + 273.15)
    fromFahrenheit := method(fahrenheit, (fahrenheit - 32) * 5 / 9)
    fromKelvin := method(kelvin, kelvin - 273.15)
    
    convert := method(value, unit,
        if(unit == "C",
            return list(value, toFahrenheit(value), toKelvin(value)),
            if(unit == "F",
                celsius := fromFahrenheit(value)
                return list(celsius, value, toKelvin(celsius)),
                if(unit == "K",
                    celsius := fromKelvin(value)
                    return list(celsius, toFahrenheit(celsius), value)
                )
            )
        )
    )
    
    printConversion := method(value, unit,
        result := convert(value, unit)
        writeln(value, "°", unit, " = ", result at(1), "°F = ", result at(2), "°K")
    )
)

// Example usage
converter := TemperatureConverter clone
converter printConversion(25, "C")
converter printConversion(77, "F")
converter printConversion(300, "K")