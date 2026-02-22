
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

TemperatureConverter := Object clone do(
    convertCelsius := method(celsiusValue,
        result := Map clone
        result atPut("celsius", celsiusValue)
        result atPut("fahrenheit", Celsius clone setSlot("", celsiusValue) toFahrenheit)
        result atPut("kelvin", Celsius clone setSlot("", celsiusValue) toKelvin)
        result
    )
    
    printConversions := method(celsiusValue,
        conversions := self convertCelsius(celsiusValue)
        ("Celsius: " .. conversions at("celsius")) println
        ("Fahrenheit: " .. conversions at("fahrenheit")) println
        ("Kelvin: " .. conversions at("kelvin")) println
    )
)

// Example usage
converter := TemperatureConverter clone
converter printConversions(25)
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method(self toCelsius + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method(self toCelsius * 9 / 5 + 32)

// Example usage (commented out in actual utility)
// 25 Celsius toFahrenheit println  // Output: 77
// 100 Celsius toKelvin println     // Output: 373.15
// 32 Fahrenheit toCelsius println  // Output: 0
// 0 Kelvin toCelsius println       // Output: -273.15
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
        "" println
    )
)

// Example usage
if(isLaunchScript,
    converter := TemperatureConverter clone
    
    "Temperature Conversion Examples" println
    "==============================" println
    "" println
    
    list(0, 25, 100, -40) foreach(celsius,
        converter displayConversions(celsius)
    )
    
    "Single conversion test:" println
    result := converter convert(100, "CtoF")
    ("100°C to Fahrenheit: " .. result .. "°F") println
)