
Celsius := Object clone
Celsius toFahrenheit := method((self * 9/5) + 32)

"Temperature converter loaded" println
"Example: 0 Celsius = " print
0 Celsius toFahrenheit println