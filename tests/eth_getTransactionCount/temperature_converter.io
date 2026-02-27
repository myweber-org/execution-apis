
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method((self - 32) * 5 / 9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9 / 5 + 32)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, fromUnit, toUnit,
    unitMap := Map clone
    unitMap atPut("C", Celsius)
    unitMap atPut("F", Fahrenheit)
    unitMap atPut("K", Kelvin)
    
    fromObj := unitMap at(fromUnit)
    toObj := unitMap at(toUnit)
    
    if(fromObj and toObj,
        if(fromUnit == "C",
            if(toUnit == "F", return fromObj toFahrenheit(value))
            if(toUnit == "K", return fromObj toKelvin(value))
        )
        if(fromUnit == "F",
            if(toUnit == "C", return fromObj toCelsius(value))
            if(toUnit == "K", return fromObj toKelvin(value))
        )
        if(fromUnit == "K",
            if(toUnit == "C", return fromObj toCelsius(value))
            if(toUnit == "F", return fromObj toFahrenheit(value))
        )
    )
    return nil
)

// Example usage
// result := TemperatureConverter convert(100, "C", "F")
// result println
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

main := method(
    "Enter Celsius temperature: " print
    input := File standardInput readLine asNumber
    fahrenheit := CelsiusToFahrenheit(input)
    ("Temperature in Fahrenheit: " .. fahrenheit) println
)

if(isLaunchScript,
    main()
)
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
converter := TemperatureConverter clone
converter displayConversions(0)
converter displayConversions(100)
converter displayConversions(-40)

// Test individual conversions
"Testing individual conversions:" println
("0°C to Fahrenheit: " .. converter convert(0, "CtoF")) println
("100°C to Kelvin: " .. converter convert(100, "CtoK")) println