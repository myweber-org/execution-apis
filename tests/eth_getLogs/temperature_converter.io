
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
celsiusValue := 100
fahrenheitValue := celsiusValue asCelsius toFahrenheit
kelvinValue := celsiusValue asCelsius toKelvin

("Original Celsius: " .. celsiusValue) println
("Converted to Fahrenheit: " .. fahrenheitValue) println
("Converted to Kelvin: " .. kelvinValue) println
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5 / 9
)

// Example usage
"25°C is #{CelsiusToFahrenheit(25)}°F" println
"77°F is #{FahrenheitToCelsius(77)}°C" println
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5 / 9
)

// Example usage
"25°C is #{CelsiusToFahrenheit(25)}°F" println
"77°F is #{FahrenheitToCelsius(77)}°C" println
CelsiusToFahrenheit := method(celsius, celsius * 9/5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "C2F", return CelsiusToFahrenheit(value))
        if(unit == "C2K", return CelsiusToKelvin(value))
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
result := converter convert(100, "C2F")
writeln("100°C in Fahrenheit: ", result)