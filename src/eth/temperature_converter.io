
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
        
        "Celsius: #{celsiusValue}" interpolate println
        "Fahrenheit: #{fahrenheit}" interpolate println
        "Kelvin: #{kelvin}" interpolate println
    )
)

// Example usage
converter := TemperatureConverter clone
converter displayConversions(25)
result := converter convert(100, "CtoF")
"100°C in Fahrenheit: #{result}" interpolate println
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

Fahrenheit := Object clone do(
    toCelsius := method((self - 32) * 5 / 9)
    toKelvin := method(self toCelsius + 273.15)
)

Kelvin := Object clone do(
    toCelsius := method(self - 273.15)
    toFahrenheit := method(self toCelsius * 9 / 5 + 32)
)

// Example usage
if(isLaunchScript,
    celsiusValue := 25
    fahrenheitValue := celsiusValue Celsius toFahrenheit
    kelvinValue := celsiusValue Celsius toKelvin
    
    celsiusValue println
    fahrenheitValue println
    kelvinValue println
)