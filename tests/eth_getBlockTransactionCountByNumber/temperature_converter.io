
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

main := method(
    "Enter temperature in Celsius: " print
    input := File standardInput readLine asNumber
    fahrenheit := CelsiusToFahrenheit(input)
    writeln(input, "°C = ", fahrenheit, "°F")
)

if(isLaunchScript, main)