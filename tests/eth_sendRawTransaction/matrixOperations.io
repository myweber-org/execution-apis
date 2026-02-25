
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
        data at(x) atPut(y, value)
        self
    )
    
    get := method(x, y,
        data at(x) at(y)
    )
    
    print := method(
        data foreach(row,
            row foreach(element,
                element asString alignLeft(4, " ") print
            )
            "" println
        )
        self
    )
    
    add := method(other,
        if(rows != other rows or cols != other cols,
            Exception raise("Matrix dimensions must match for addition")
        )
        result := Matrix clone dim(rows, cols)
        for(i, 0, rows - 1,
            for(j, 0, cols - 1,
                result set(i, j, get(i, j) + other get(i, j))
            )
        )
        result
    )
    
    multiply := method(other,
        if(cols != other rows,
            Exception raise("Matrix dimensions incompatible for multiplication")
        )
        result := Matrix clone dim(rows, other cols)
        for(i, 0, rows - 1,
            for(j, 0, other cols - 1,
                sum := 0
                for(k, 0, cols - 1,
                    sum = sum + get(i, k) * other get(k, j)
                )
                result set(i, j, sum)
            )
        )
        result
    )
)

// Example usage
a := Matrix clone dim(2, 3)
a set(0, 0, 1) set(0, 1, 2) set(0, 2, 3)
a set(1, 0, 4) set(1, 1, 5) set(1, 2, 6)

b := Matrix clone dim(2, 3)
b set(0, 0, 6) set(0, 1, 5) set(0, 2, 4)
b set(1, 0, 3) set(1, 1, 2) set(1, 2, 1)

c := Matrix clone dim(3, 2)
c set(0, 0, 1) set(0, 1, 2)
c set(1, 0, 3) set(1, 1, 4)
c set(2, 0, 5) set(2, 1, 6)

"Matrix A:" println
a print

"Matrix B:" println
b print

"Matrix A + B:" println
a add(b) print

"Matrix A * C:" println
a multiply(c) print