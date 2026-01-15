
Matrix := Object clone
Matrix dim := method(x, y,
    self rows := x
    self cols := y
    self data := List clone
    for(i, 1, x,
        row := List clone
        for(j, 1, y, row append(0))
        data append(row)
    )
)

Matrix set := method(x, y, value,
    data at(x-1) atPut(y-1, value)
    self
)

Matrix get := method(x, y,
    data at(x-1) at(y-1)
)

Matrix print := method(
    data foreach(i, row,
        row foreach(j, element,
            element asString alignLeft(6, " ") print
        )
        "" println
    )
)

Matrix multiply := method(other,
    if(cols != other rows,
        Exception raise("Matrix dimension mismatch: " .. cols .. " != " .. other rows)
    )
    
    result := Matrix clone dim(rows, other cols)
    
    for(i, 1, rows,
        for(j, 1, other cols,
            sum := 0
            for(k, 1, cols,
                sum = sum + (get(i, k) * other get(k, j))
            )
            result set(i, j, sum)
        )
    )
    
    result
)

// Example usage
a := Matrix clone dim(2, 3)
a set(1, 1, 1) set(1, 2, 2) set(1, 3, 3)
a set(2, 1, 4) set(2, 2, 5) set(2, 3, 6)

b := Matrix clone dim(3, 2)
b set(1, 1, 7) set(1, 2, 8)
b set(2, 1, 9) set(2, 2, 10)
b set(3, 1, 11) set(3, 2, 12)

"Matrix A:" println
a print

"Matrix B:" println
b print

"Result of A * B:" println
c := a multiply(b)
c print

// Test error case
"Testing error handling:" println
d := Matrix clone dim(2, 2)
e := Matrix clone dim(3, 3)
try(
    d multiply(e)
) catch(Exception,
    "Caught expected error: " .. Exception description println
)