
TemperatureConverter := Object clone do(
    celsiusToFahrenheit := method(celsius,
        (celsius * 9/5) + 32
    )
    
    celsiusToKelvin := method(celsius,
        celsius + 273.15
    )
    
    fahrenheitToCelsius := method(fahrenheit,
        (fahrenheit - 32) * 5/9
    )
    
    kelvinToCelsius := method(kelvin,
        kelvin - 273.15
    )
    
    convert := method(value, fromUnit, toUnit,
        celsius := nil
        if(fromUnit == "C", celsius = value)
        if(fromUnit == "F", celsius = fahrenheitToCelsius(value))
        if(fromUnit == "K", celsius = kelvinToCelsius(value))
        
        if(celsius == nil, return "Invalid source unit")
        
        if(toUnit == "C", return celsius)
        if(toUnit == "F", return celsiusToFahrenheit(celsius))
        if(toUnit == "K", return celsiusToKelvin(celsius))
        
        return "Invalid target unit"
    )
)

// Example usage (commented out in actual file)
// converter := TemperatureConverter clone
// converter convert(100, "C", "F") println  // Prints 212
// converter convert(32, "F", "K") println   // Prints 273.15
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

// Example usage (commented out in actual utility)
// 25 Celsius toFahrenheit println
// 98.6 Fahrenheit toCelsius println
// 300 Kelvin toFahrenheit println