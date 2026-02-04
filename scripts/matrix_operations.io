
Matrix := Object clone do(
    dim := method(x, y,
        self rows := x
        self cols := y
        self data := List clone
        for(i, 1, x,
            row := List clone
            for(j, 1, y, row append(0))
            data append(row)
        )
        self
    )
    
    set := method(x, y, value,
        data at(x-1) atPut(y-1, value)
        self
    )
    
    get := method(x, y,
        data at(x-1) at(y-1)
    )
    
    print := method(
        data foreach(i, row,
            row foreach(j, element,
                element asString alignLeft(6) print
            )
            "" println
        )
        self
    )
    
    multiply := method(other,
        if(cols != other rows, 
            Exception raise("Matrix dimensions incompatible for multiplication")
        )
        result := Matrix clone dim(rows, other cols)
        for(i, 1, rows,
            for(j, 1, other cols,
                sum := 0
                for(k, 1, cols,
                    sum = sum + get(i, k) * other get(k, j)
                )
                result set(i, j, sum)
            )
        )
        result
    )
    
    determinant := method(
        if(rows != cols, 
            Exception raise("Determinant only defined for square matrices")
        )
        if(rows == 1, return get(1, 1))
        if(rows == 2,
            return get(1, 1) * get(2, 2) - get(1, 2) * get(2, 1)
        )
        
        det := 0
        sign := 1
        for(col, 1, cols,
            submatrix := Matrix clone dim(rows-1, cols-1)
            for(i, 2, rows,
                subcol := 1
                for(j, 1, cols,
                    if(j == col, continue)
                    submatrix set(i-1, subcol, get(i, j))
                    subcol = subcol + 1
                )
            )
            det = det + sign * get(1, col) * submatrix determinant
            sign = sign * -1
        )
        det
    )
)

// Example usage
a := Matrix clone dim(3, 3)
a set(1, 1, 1) set(1, 2, 2) set(1, 3, 3)
a set(2, 1, 4) set(2, 2, 5) set(2, 3, 6)
a set(3, 1, 7) set(3, 2, 8) set(3, 3, 9)

b := Matrix clone dim(3, 2)
b set(1, 1, 1) set(1, 2, 0)
b set(2, 1, 0) set(2, 2, 1)
b set(3, 1, 1) set(3, 2, 1)

"Matrix A:" println
a print

"Matrix B:" println
b print

"Multiplication result:" println
c := a multiply(b)
c print

"Determinant of A:" println
a determinant println