
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convertCtoF := method(celsius,
        if(celsius isNil, return nil)
        CelsiusToFahrenheit(celsius)
    )
    
    convertCtoK := method(celsius,
        if(celsius isNil, return nil)
        CelsiusToKelvin(celsius)
    )
    
    convertAll := method(celsius,
        if(celsius isNil, return nil)
        Map clone atPut("celsius", celsius) \
            atPut("fahrenheit", CelsiusToFahrenheit(celsius)) \
            atPut("kelvin", CelsiusToKelvin(celsius))
    )
)

// Example usage (commented out in actual utility):
// converter := TemperatureConverter clone
// converter convertCtoF(100) println  // 212
// converter convertCtoK(0) println    // 273.15
// converter convertAll(25) println    // Map with all three units