
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
        
        "Celsius: " .. celsiusValue .. " -> Fahrenheit: " .. fahrenheit .. ", Kelvin: " .. kelvin println
    )
)

// Example usage
converter := TemperatureConverter clone
converter displayConversions(25)
converter displayConversions(0)
converter displayConversions(100)