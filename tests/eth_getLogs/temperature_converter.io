
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "CtoF", return CelsiusToFahrenheit(value))
        if(unit == "CtoK", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion unit: #{unit}" interpolate)
    )
    
    displayConversions := method(celsiusValue,
        fahrenheit := CelsiusToFahrenheit(celsiusValue)
        kelvin := CelsiusToKelvin(celsiusValue)
        writeln("Celsius: ", celsiusValue, "°C")
        writeln("Fahrenheit: ", fahrenheit, "°F")
        writeln("Kelvin: ", kelvin, "K")
    )
)

// Example usage
if(isLaunchScript,
    converter := TemperatureConverter clone
    converter displayConversions(25)
    
    result := converter convert(100, "CtoF")
    writeln("100°C in Fahrenheit: ", result, "°F")
)
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

main := method(
    "Enter temperature in Celsius: " print
    input := File standardInput readLine asNumber
    fahrenheit := CelsiusToFahrenheit(input)
    ("Temperature in Fahrenheit: " .. fahrenheit) println
)

if(isLaunchScript, main)