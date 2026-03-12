
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

TemperatureConverter := Object clone do(
    convert := method(value, unit, targetUnit,
        if(unit == "C" and targetUnit == "F", return value toFahrenheit)
        if(unit == "C" and targetUnit == "K", return value toKelvin)
        if(unit == "F" and targetUnit == "C", return (value - 32) * 5 / 9)
        if(unit == "F" and targetUnit == "K", return (value - 32) * 5 / 9 + 273.15)
        if(unit == "K" and targetUnit == "C", return value - 273.15)
        if(unit == "K" and targetUnit == "F", return (value - 273.15) * 9 / 5 + 32)
        Exception raise("Unsupported conversion from #{unit} to #{targetUnit}" interpolate)
    )
    
    displayConversions := method(value, unit,
        if(unit == "C",
            f := value toFahrenheit
            k := value toKelvin
            writeln("#{value}°C = #{f}°F = #{k}K" interpolate)
        )
        if(unit == "F",
            c := (value - 32) * 5 / 9
            k := c + 273.15
            writeln("#{value}°F = #{c}°C = #{k}K" interpolate)
        )
        if(unit == "K",
            c := value - 273.15
            f := c * 9 / 5 + 32
            writeln("#{value}K = #{c}°C = #{f}°F" interpolate)
        )
    )
)
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5 / 9
)

// Example usage
"25°C is #{CelsiusToFahrenheit(25)}°F" println
"77°F is #{FahrenheitToCelsius(77)}°C" println
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
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method((self - 32) * 5 / 9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9 / 5 + 32)

// Example usage
"25°C in Fahrenheit: " print; 25 Celsius toFahrenheit println
"77°F in Celsius: " print; 77 Fahrenheit toCelsius println
"300K in Celsius: " print; 300 Kelvin toCelsius println