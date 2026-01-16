
Matrix := Object clone do(
    dim := method(x, y,
        self data := List clone
        for(i, 1, x,
            row := List clone
            for(j, 1, y, row append(0))
            data append(row)
        )
        self
    )
    
    set := method(x, y, value, data at(x) atPut(y, value))
    get := method(x, y, data at(x) at(y))
    rows := method(data size)
    cols := method(data at(0) size)
    
    print := method(
        data foreach(row,
            row foreach(element, element print; " " print)
            "" println
        )
    )
)

matrixMultiply := method(a, b,
    if(a cols != b rows, 
        Exception raise("Matrix dimension mismatch: " .. a cols .. " != " .. b rows)
    )
    
    result := Matrix clone dim(a rows, b cols)
    
    for(i, 0, a rows - 1,
        for(j, 0, b cols - 1,
            sum := 0
            for(k, 0, a cols - 1,
                sum = sum + (a get(i, k) * b get(k, j))
            )
            result set(i, j, sum)
        )
    )
    
    result
)

// Example usage
a := Matrix clone dim(2, 3)
a set(0, 0, 1); a set(0, 1, 2); a set(0, 2, 3)
a set(1, 0, 4); a set(1, 1, 5); a set(1, 2, 6)

b := Matrix clone dim(3, 2)
b set(0, 0, 7); b set(0, 1, 8)
b set(1, 0, 9); b set(1, 1, 10)
b set(2, 0, 11); b set(2, 1, 12)

"Matrix A:" println
a print

"Matrix B:" println
b print

"Result of A * B:" println
try(
    result := matrixMultiply(a, b)
    result print
) catch(Exception,
    "Error: " .. error println
)