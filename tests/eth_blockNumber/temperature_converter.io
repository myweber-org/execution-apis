
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
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5 / 9
)

// Example usage
celsiusTemp := 25
fahrenheitTemp := CelsiusToFahrenheit(celsiusTemp)
(celsiusTemp .. "°C is " .. fahrenheitTemp .. "°F") println

fahrenheitTemp2 := 77
celsiusTemp2 := FahrenheitToCelsius(fahrenheitTemp2)
(fahrenheitTemp2 .. "°F is " .. celsiusTemp2 .. "°C") println