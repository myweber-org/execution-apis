
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

// Example usage
converter := TemperatureConverter clone
"25°C to Fahrenheit: " print
converter convert(25, "C", "F") println

"98.6°F to Celsius: " print
converter convert(98.6, "F", "C") println

"0°C to Kelvin: " print
converter convert(0, "C", "K") println