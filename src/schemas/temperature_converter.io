
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