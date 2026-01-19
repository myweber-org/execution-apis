
List filter := Object clone do(
    filterEven := method(list,
        list select(i, i % 2 == 0)
    )
    
    squareValues := method(list,
        list map(i, i * i)
    )
    
    processData := method(list,
        squared := squareValues(list)
        filterEven(squared)
    )
)

processor := List filter clone
numbers := list(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
result := processor processData(numbers)
result println