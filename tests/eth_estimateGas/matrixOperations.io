
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
        for(i, 0, rows - 1,
            for(j, 0, cols - 1,
                (self get(i, j)) print
                " " print
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
        for(i, 0, rows - 1,
            for(j, 0, other cols - 1,
                sum := 0
                for(k, 0, cols - 1,
                    sum = sum + (self get(i, k) * other get(k, j))
                )
                result set(i, j, sum)
            )
        )
        result
    )
)

a := Matrix clone dim(2, 3)
a set(0, 0, 1) set(0, 1, 2) set(0, 2, 3)
a set(1, 0, 4) set(1, 1, 5) set(1, 2, 6)

b := Matrix clone dim(3, 2)
b set(0, 0, 7) set(0, 1, 8)
b set(1, 0, 9) set(1, 1, 10)
b set(2, 0, 11) set(2, 1, 12)

"Matrix A:" println
a print

"Matrix B:" println
b print

"Result of A * B:" println
c := a multiply(b)
c print