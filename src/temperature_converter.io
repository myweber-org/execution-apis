
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

do(
    "Enter temperature in Celsius: " print
    input := File standardInput readLine asNumber
    fahrenheit := CelsiusToFahrenheit(input)
    ("Temperature in Fahrenheit: " .. fahrenheit) println
)