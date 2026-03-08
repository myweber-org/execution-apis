
TemperatureConverter := Object clone do(
    toFahrenheit := method(celsius, celsius * 9 / 5 + 32)
    toKelvin := method(celsius, celsius + 273.15)
    fromFahrenheit := method(fahrenheit, (fahrenheit - 32) * 5 / 9)
    fromKelvin := method(kelvin, kelvin - 273.15)
)

converter := TemperatureConverter clone

"Testing temperature conversions:" println
"25°C = #{converter toFahrenheit(25)}°F" interpolate println
"25°C = #{converter toKelvin(25)}K" interpolate println
"77°F = #{converter fromFahrenheit(77)}°C" interpolate println
"298.15K = #{converter fromKelvin(298.15)}°C" interpolate println