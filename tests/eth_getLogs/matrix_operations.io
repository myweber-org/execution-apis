
Matrix := Object clone do(
    init := method(
        self data := list()
    )

    setData := method(dataList,
        self data = dataList map(row, row clone)
        self rows = data size
        self cols = if(data size > 0, data at(0) size, 0)
        self
    )

    print := method(
        data foreach(row,
            row foreach(element,
                element asString alignLeft(8, " ") print
            )
            "" println
        )
        self
    )

    multiply := method(other,
        if(self cols != other rows,
            Exception raise("Matrix dimensions incompatible for multiplication")
        )
        result := Matrix clone
        resultData := list()
        for(i, 0, self rows - 1,
            row := list()
            for(j, 0, other cols - 1,
                sum := 0
                for(k, 0, self cols - 1,
                    sum = sum + (self data at(i) at(k) * other data at(k) at(j))
                )
                row append(sum)
            )
            resultData append(row)
        )
        result setData(resultData)
    )

    determinant := method(
        if(self rows != self cols,
            Exception raise("Determinant only defined for square matrices")
        )
        if(self rows == 1, return self data at(0) at(0))
        if(self rows == 2,
            return (self data at(0) at(0) * self data at(1) at(1)) - 
                   (self data at(0) at(1) * self data at(1) at(0))
        )
        
        det := 0
        for(col, 0, self cols - 1,
            subMatrix := Matrix clone
            subData := list()
            for(i, 1, self rows - 1,
                row := list()
                for(j, 0, self cols - 1,
                    if(j != col, row append(self data at(i) at(j)))
                )
                subData append(row)
            )
            subMatrix setData(subData)
            sign := if(col % 2 == 0, 1, -1)
            det = det + (sign * self data at(0) at(col) * subMatrix determinant)
        )
        det
    )
)

// Example usage
matrixA := Matrix clone setData(list(list(1, 2, 3), list(4, 5, 6), list(7, 8, 9)))
matrixB := Matrix clone setData(list(list(9, 8, 7), list(6, 5, 4), list(3, 2, 1)))

"Matrix A:" println
matrixA print

"Matrix B:" println
matrixB print

"Matrix A * B:" println
result := matrixA multiply(matrixB)
result print

"Determinant of A: " print
matrixA determinant println