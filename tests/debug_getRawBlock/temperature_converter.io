
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
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

main := method(
    "Enter Celsius temperature: " print
    input := File standardInput readLine asNumber
    fahrenheit := CelsiusToFahrenheit(input)
    ("Temperature in Fahrenheit: " .. fahrenheit) println
)

main()
Celsius := Object clone do(
    toFahrenheit := method(self * 9/5 + 32)
    toKelvin := method(self + 273.15)
)

Fahrenheit := Object clone do(
    toCelsius := method((self - 32) * 5/9)
    toKelvin := method((self - 32) * 5/9 + 273.15)
)

Kelvin := Object clone do(
    toCelsius := method(self - 273.15)
    toFahrenheit := method((self - 273.15) * 9/5 + 32)
)

// Example usage
/*
celsiusValue := 25
fahrenheitValue := celsiusValue asNumber Celsius toFahrenheit
kelvinValue := celsiusValue asNumber Celsius toKelvin

("Celsius: " .. celsiusValue) println
("Fahrenheit: " .. fahrenheitValue) println
("Kelvin: " .. kelvinValue) println
*/