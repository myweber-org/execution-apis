
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

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
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
"25°C is #{CelsiusToFahrenheit(25)}°F" println
"77°F is #{FahrenheitToCelsius(77)}°C" println
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method((self - 32) * 5 / 9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9 / 5 + 32)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, fromUnit, toUnit,
    if(fromUnit == "C" and toUnit == "F", return value toFahrenheit)
    if(fromUnit == "C" and toUnit == "K", return value toKelvin)
    if(fromUnit == "F" and toUnit == "C", return value toCelsius)
    if(fromUnit == "F" and toUnit == "K", return value toKelvin)
    if(fromUnit == "K" and toUnit == "C", return value toCelsius)
    if(fromUnit == "K" and toUnit == "F", return value toFahrenheit)
    value
)

// Example usage
// 25 Celsius toFahrenheit println
// 98.6 Fahrenheit toCelsius println
// 300 Kelvin toCelsius println