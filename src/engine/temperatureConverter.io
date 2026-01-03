
TemperatureConverter := Object clone do(
    toFahrenheit := method(celsius, (celsius * 9/5) + 32)
    toKelvin := method(celsius, celsius + 273.15)
    convertAll := method(celsius,
        fahrenheit := self toFahrenheit(celsius)
        kelvin := self toKelvin(celsius)
        list(celsius, fahrenheit, kelvin)
    )
)

converter := TemperatureConverter clone
result := converter convertAll(25)
"Input: #{result at(0)}°C" println
"Fahrenheit: #{result at(1)}°F" println
"Kelvin: #{result at(2)}K" println