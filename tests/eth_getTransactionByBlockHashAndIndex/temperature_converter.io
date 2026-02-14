
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5 / 9
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

// Example usage
"25 Celsius in Fahrenheit: " print
(25 Celsius toFahrenheit) println

"98.6 Fahrenheit in Celsius: " print
(98.6 Fahrenheit toCelsius) println

"300 Kelvin in Celsius: " print
(300 Kelvin toCelsius) println
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

Fahrenheit := Object clone do(
    toCelsius := method((self - 32) * 5 / 9)
    toKelvin := method((self - 32) * 5 / 9 + 273.15)
)

Kelvin := Object clone do(
    toCelsius := method(self - 273.15)
    toFahrenheit := method((self - 273.15) * 9 / 5 + 32)
)

// Example usage
/*
celsiusTemp := 100
fahrenheitTemp := celsiusTemp Celsius toFahrenheit
kelvinTemp := celsiusTemp Celsius toKelvin

("Celsius: " .. celsiusTemp) println
("Fahrenheit: " .. fahrenheitTemp) println
("Kelvin: " .. kelvinTemp) println
*/
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
        
        ("Original: " .. celsiusValue .. "°C") println
        ("Fahrenheit: " .. fahrenheit .. "°F") println
        ("Kelvin: " .. kelvin .. "K") println
    )
)

// Example usage
converter := TemperatureConverter clone
converter displayConversions(25)
result := converter convert(100, "CtoF")
("100°C in Fahrenheit: " .. result .. "°F") println