
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
        
        ("Input: " .. celsiusValue .. "°C") println
        ("Fahrenheit: " .. fahrenheit .. "°F") println
        ("Kelvin: " .. kelvin .. "K") println
    )
)

// Example usage
if(isLaunchScript,
    converter := TemperatureConverter clone
    converter displayConversions(25)
    
    "Testing conversions:" println
    ("25°C to Fahrenheit: " .. converter convert(25, "CtoF")) println
    ("0°C to Kelvin: " .. converter convert(0, "CtoK")) println
)