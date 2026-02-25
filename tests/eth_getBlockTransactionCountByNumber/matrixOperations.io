
Matrix := Object clone do(
    init := method(
        self rows := list()
    )

    setRows := method(rowsList,
        self rows = rowsList map(row, row clone)
        self
    )

    rowsCount := method(rows size)
    colsCount := method(if(rows isEmpty, 0, rows at(0) size))

    print := method(
        rows foreach(i, row,
            row foreach(j, element,
                element asString alignLeft(6) print
            )
            "\n" print
        )
        self
    )

    multiply := method(other,
        if(colsCount != other rowsCount,
            Exception raise("Matrix dimensions incompatible for multiplication")
        )
        
        result := Matrix clone
        newRows := list()
        
        for(i, 0, rowsCount - 1,
            newRow := list()
            for(j, 0, other colsCount - 1,
                sum := 0
                for(k, 0, colsCount - 1,
                    sum = sum + (rows at(i) at(k) * other rows at(k) at(j))
                )
                newRow append(sum)
            )
            newRows append(newRow)
        )
        
        result setRows(newRows)
    )

    determinant := method(
        if(rowsCount != colsCount,
            Exception raise("Determinant only defined for square matrices")
        )
        
        if(rowsCount == 1, return rows at(0) at(0))
        if(rowsCount == 2,
            return (rows at(0) at(0) * rows at(1) at(1)) - 
                   (rows at(0) at(1) * rows at(1) at(0))
        )
        
        det := 0
        sign := 1
        
        for(col, 0, colsCount - 1,
            subMatrix := Matrix clone
            subRows := list()
            
            for(i, 1, rowsCount - 1,
                subRow := list()
                for(j, 0, colsCount - 1,
                    if(j != col, subRow append(rows at(i) at(j)))
                )
                subRows append(subRow)
            )
            
            subMatrix setRows(subRows)
            det = det + (sign * rows at(0) at(col) * subMatrix determinant)
            sign = sign * -1
        )
        
        det
    )
)

// Example usage
a := Matrix clone setRows(list(list(1, 2, 3), list(4, 5, 6), list(7, 8, 9)))
b := Matrix clone setRows(list(list(9, 8, 7), list(6, 5, 4), list(3, 2, 1)))

"Matrix A:" println
a print

"\nMatrix B:" println
b print

"\nA * B:" println
product := a multiply(b)
product print

"\nDeterminant of A: " print
a determinant println

"\nDeterminant of product: " print
product determinant println