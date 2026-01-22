
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "CtoF", return CelsiusToFahrenheit(value))
        if(unit == "CtoK", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion: " .. unit)
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
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "CtoF", return CelsiusToFahrenheit(value))
        if(unit == "CtoK", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion unit: " .. unit)
    )
    
    displayConversions := method(celsiusValue,
        fahrenheit := CelsiusToFahrenheit(celsiusValue)
        kelvin := CelsiusToKelvin(celsiusValue)
        writeln(celsiusValue, "°C = ", fahrenheit, "°F")
        writeln(celsiusValue, "°C = ", kelvin, "K")
    )
)

// Example usage
converter := TemperatureConverter clone
converter displayConversions(25)
result := converter convert(100, "CtoF")
writeln("100°C in Fahrenheit: ", result)
Celsius := Object clone
Celsius toFahrenheit := method((self * 9/5) + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5/9)
Fahrenheit toKelvin := method((self - 32) * 5/9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9/5 + 32)

// Example usage
25 asCelsius := method(Celsius clone setSlot("value", self))
98.6 asFahrenheit := method(Fahrenheit clone setSlot("value", self))
300 asKelvin := method(Kelvin clone setSlot("value", self))

"25°C in Fahrenheit: " print
(25 asCelsius) toFahrenheit println

"98.6°F in Celsius: " print
(98.6 asFahrenheit) toCelsius println

"300K in Celsius: " print
(300 asKelvin) toCelsius println

"300K in Fahrenheit: " print
(300 asKelvin) toFahrenheit println