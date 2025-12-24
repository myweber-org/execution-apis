
Celsius := Object clone do(
    toFahrenheit := method(self * 9/5 + 32)
    toKelvin := method(self + 273.15)
)

Fahrenheit := Object clone do(
    toCelsius := method((self - 32) * 5/9)
    toKelvin := method((self - 32) * 5/9 + 273.15)
)

Kelvin := Object clone do(
    toCelsius := method(self - 273.15)
    toFahrenheit := method((self - 273.15) * 9/5 + 32)
)

// Example usage (commented out in actual utility)
// 25 Celsius toFahrenheit println  // 77
// 100 Fahrenheit toCelsius println // 37.77777777777778
// 300 Kelvin toCelsius println     // 26.85
CelsiusToFahrenheit := method(celsius,
    celsius * 9 / 5 + 32
)

CelsiusToKelvin := method(celsius,
    celsius + 273.15
)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "CtoF", return CelsiusToFahrenheit(value))
        if(unit == "CtoK", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion unit: " .. unit)
    )
    
    displayConversions := method(celsius,
        fahrenheit := CelsiusToFahrenheit(celsius)
        kelvin := CelsiusToKelvin(celsius)
        writeln(celsius, "°C = ", fahrenheit, "°F")
        writeln(celsius, "°C = ", kelvin, "K")
    )
)

// Example usage
converter := TemperatureConverter clone
converter displayConversions(25)
result := converter convert(100, "CtoF")
writeln("100°C in Fahrenheit: ", result)