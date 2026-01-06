
Matrix := Object clone do(
    init := method(
        self data := nil
        self rows := 0
        self cols := 0
    )

    setData := method(inputData,
        self data := inputData
        self rows := inputData size
        self cols := if(inputData size > 0, inputData at(0) size, 0)
        self
    )

    isValid := method(
        if(data == nil, return false)
        for(i, 0, rows - 1,
            if(data at(i) size != cols, return false)
        )
        true
    )

    print := method(
        if(isValid not, return "Invalid matrix")
        result := ""
        for(i, 0, rows - 1,
            for(j, 0, cols - 1,
                result = result .. data at(i) at(j) asString .. "\t"
            )
            result = result .. "\n"
        )
        result
    )

    add := method(other,
        if(isValid not or other isValid not, 
            Exception raise("Cannot add invalid matrices")
        )
        if(rows != other rows or cols != other cols,
            Exception raise("Matrix dimensions must match for addition")
        )

        resultData := List clone
        for(i, 0, rows - 1,
            row := List clone
            for(j, 0, cols - 1,
                row append(data at(i) at(j) + other data at(i) at(j))
            )
            resultData append(row)
        )
        
        newMatrix := Matrix clone
        newMatrix setData(resultData)
    )

    multiply := method(other,
        if(isValid not or other isValid not,
            Exception raise("Cannot multiply invalid matrices")
        )
        if(cols != other rows,
            Exception raise("Columns of first must equal rows of second")
        )

        resultData := List clone
        for(i, 0, rows - 1,
            row := List clone
            for(j, 0, other cols - 1,
                sum := 0
                for(k, 0, cols - 1,
                    sum = sum + data at(i) at(k) * other data at(k) at(j)
                )
                row append(sum)
            )
            resultData append(row)
        )
        
        newMatrix := Matrix clone
        newMatrix setData(resultData)
    )
)

// Example usage
matrixA := Matrix clone setData(list(list(1,2), list(3,4)))
matrixB := Matrix clone setData(list(list(5,6), list(7,8)))

"Matrix A:" println
matrixA print println

"Matrix B:" println
matrixB print println

"Sum of A and B:" println
try(
    sumMatrix := matrixA add(matrixB)
    sumMatrix print println
) catch(Exception,
    ("Error: " .. error) println
)

"Product of A and B:" println
try(
    productMatrix := matrixA multiply(matrixB)
    productMatrix print println
) catch(Exception,
    ("Error: " .. error) println
)