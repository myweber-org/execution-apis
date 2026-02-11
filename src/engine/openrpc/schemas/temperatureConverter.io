
TemperatureConverter := Object clone do(
    toFahrenheit := method(celsius, (celsius * 9/5) + 32)
    toKelvin := method(celsius, celsius + 273.15)
    toCelsiusFromFahrenheit := method(fahrenheit, (fahrenheit - 32) * 5/9)
    toCelsiusFromKelvin := method(kelvin, kelvin - 273.15)
    
    convert := method(value, fromUnit, toUnit,
        celsius := if(fromUnit == "C", value,
            fromUnit == "F", toCelsiusFromFahrenheit(value),
            fromUnit == "K", toCelsiusFromKelvin(value),
            Exception raise("Invalid source unit"))
        
        if(toUnit == "C", celsius,
            toUnit == "F", toFahrenheit(celsius),
            toUnit == "K", toKelvin(celsius),
            Exception raise("Invalid target unit"))
    )
    
    printConversions := method(value, unit,
        if(unit == "C",
            f := toFahrenheit(value) round(2)
            k := toKelvin(value) round(2)
            writeln(value, "°C = ", f, "°F = ", k, "K"),
        unit == "F",
            c := toCelsiusFromFahrenheit(value) round(2)
            k := toKelvin(c) round(2)
            writeln(value, "°F = ", c, "°C = ", k, "K"),
        unit == "K",
            c := toCelsiusFromKelvin(value) round(2)
            f := toFahrenheit(c) round(2)
            writeln(value, "K = ", c, "°C = ", f, "°F"),
            Exception raise("Invalid unit"))
    )
)

// Example usage
converter := TemperatureConverter clone
converter printConversions(100, "C")
converter printConversions(212, "F")
converter printConversions(373.15, "K")

result := converter convert(25, "C", "F")
writeln("25°C in Fahrenheit: ", result)