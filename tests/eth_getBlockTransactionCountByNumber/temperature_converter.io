
CelsiusToFahrenheit := method(celsius,
    celsius * 9 / 5 + 32
)

main := method(
    "Enter temperature in Celsius: " print
    input := File standardInput readLine asNumber
    
    if(input isNil,
        "Invalid input" println,
        fahrenheit := CelsiusToFahrenheit(input)
        ("%.1f°C = %.1f°F" interpolate(input, fahrenheit)) println
    )
)

if(isLaunchScript, main)