
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(celsiusValue,
    if(celsiusValue isNil, return nil)
    celsius := celsiusValue asNumber
    if(celsius isNil, return nil)
    
    Map clone atPut("celsius", celsius) \
         atPut("fahrenheit", Celsius clone toFahrenheit(celsius)) \
         atPut("kelvin", Celsius clone toKelvin(celsius))
)

// Example usage (commented out in actual utility):
// converter := TemperatureConverter clone
// result := converter convert(25)
// result at("fahrenheit") println  // Outputs 77
// result at("kelvin") println      // Outputs 298.15
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5 / 9
)

// Example usage
celsiusTemp := 25
fahrenheitTemp := CelsiusToFahrenheit(celsiusTemp)
convertedBack := FahrenheitToCelsius(fahrenheitTemp)

("Original Celsius: " .. celsiusTemp) println
("Converted to Fahrenheit: " .. fahrenheitTemp) println
("Converted back to Celsius: " .. convertedBack) println
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
"25°C is #{CelsiusToFahrenheit(25)}°F" println
"77°F is #{FahrenheitToCelsius(77)}°C" println