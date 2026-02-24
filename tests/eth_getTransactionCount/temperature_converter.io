
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