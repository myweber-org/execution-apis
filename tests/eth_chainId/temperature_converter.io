
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
/*
c := 100
f := c asCelsius toFahrenheit
k := c asCelsius toKelvin
("Celsius: " .. c .. " -> Fahrenheit: " .. f .. ", Kelvin: " .. k) println
*/

Number asCelsius := method(Celsius clone setProto(self))
Number asFahrenheit := method(Fahrenheit clone setProto(self))
Number asKelvin := method(Kelvin clone setProto(self))
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
        celsius := if(fromUnit == "C", value,
            if(fromUnit == "F", fahrenheitToCelsius(value),
                if(fromUnit == "K", kelvinToCelsius(value), nil)
            )
        )
        
        if(celsius == nil, return "Invalid source unit")
        
        result := if(toUnit == "C", celsius,
            if(toUnit == "F", celsiusToFahrenheit(celsius),
                if(toUnit == "K", celsiusToKelvin(celsius), nil)
            )
        )
        
        if(result == nil, return "Invalid target unit", result)
    )
)

converter := TemperatureConverter clone
"25°C to Fahrenheit: " print
converter convert(25, "C", "F") println

"98.6°F to Celsius: " print
converter convert(98.6, "F", "C") println

"0°C to Kelvin: " print
converter convert(0, "C", "K") println