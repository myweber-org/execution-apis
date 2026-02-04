
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method(self toCelsius + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method(self toCelsius * 9 / 5 + 32)

// Example usage
convertTemperature := method(value, unit,
    if(unit == "C",
        list("F" = value toFahrenheit, "K" = value toKelvin),
    if(unit == "F",
        list("C" = value toCelsius, "K" = value toKelvin),
    if(unit == "K",
        list("C" = value toCelsius, "F" = value toFahrenheit),
        "Invalid unit"
    )))
)

// Test conversions
testConversion := method(
    "25°C conversions:" println
    result := convertTemperature(25, "C")
    result foreach(key, value, ("  " .. key .. " = " .. value) println)
    
    "\n77°F conversions:" println
    result := convertTemperature(77, "F")
    result foreach(key, value, ("  " .. key .. " = " .. value) println)
    
    "\n300K conversions:" println
    result := convertTemperature(300, "K")
    result foreach(key, value, ("  " .. key .. " = " .. value) println)
)

testConversion