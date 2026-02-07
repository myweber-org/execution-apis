
Matrix := Object clone do(
    dim := method(self size .. "x" .. self at(0) size)
    
    multiply := method(other,
        if(self at(0) size != other size,
            Exception raise("Matrix dimension mismatch: " .. self dim .. " cannot multiply " .. other dim)
        )
        
        result := List clone
        self foreach(i, row,
            newRow := List clone
            other at(0) foreach(j, col,
                sum := 0
                row foreach(k, value,
                    sum = sum + (value * other at(k) at(j))
                )
                newRow append(sum)
            )
            result append(newRow)
        )
        return result
    )
    
    print := method(
        self foreach(row,
            row foreach(value,
                value asString alignLeft(6, " ") print
            )
            "" println
        )
    )
)

// Create two matrices
matrixA := list(
    list(1, 2, 3),
    list(4, 5, 6)
)

matrixB := list(
    list(7, 8),
    list(9, 10),
    list(11, 12)
)

// Perform multiplication
result := Matrix clone multiply(matrixA, matrixB)
"Result of matrix multiplication:" println
result print

// Test error case
matrixC := list(
    list(1, 2),
    list(3, 4)
)

try(
    errorResult := Matrix clone multiply(matrixA, matrixC)
) catch(e,
    "Error caught: " .. e error println
)
Matrix := Object clone do(
    dim := method(self size .. self at(0) size)
    
    mul := method(other,
        if(self at(0) size != other size,
            Exception raise("Matrix dimension mismatch: " .. 
                self at(0) size asString .. " != " .. other size asString)
        )
        
        result := List clone
        self foreach(i, row,
            newRow := List clone
            other at(0) foreach(j, col,
                sum := 0
                row foreach(k, value,
                    sum = sum + (value * other at(k) at(j))
                )
                newRow append(sum)
            )
            result append(newRow)
        )
        result
    )
    
    print := method(
        self foreach(row,
            row foreach(value,
                (value asString alignLeft(8, " ")) print
            )
            "" println
        )
    )
)

// Example usage
a := list(list(1,2,3), list(4,5,6))
b := list(list(7,8), list(9,10), list(11,12))

matrixA := Matrix clone setProto(a)
matrixB := Matrix clone setProto(b)

"Matrix A:" println
matrixA print

"Matrix B:" println
matrixB print

"Result of A * B:" println
result := matrixA mul(matrixB)
result print
Matrix := Object clone
Matrix dim := method(x, y,
    self x := x
    self y := y
    self data := List clone
    for(i, 1, x,
        row := List clone
        for(j, 1, y, row append(0))
        data append(row)
    )
)

Matrix set := method(x, y, value,
    data at(x) atPut(y, value)
)

Matrix get := method(x, y,
    data at(x) at(y)
)

Matrix print := method(
    data foreach(i, row,
        row foreach(j, cell,
            cell asString print
            " " print
        )
        "" println
    )
)

Matrix multiply := method(other,
    if(self y != other x, Exception raise("Incompatible dimensions"))
    result := Matrix clone dim(self x, other y)
    for(i, 0, self x - 1,
        for(j, 0, other y - 1,
            sum := 0
            for(k, 0, self y - 1,
                sum = sum + (self get(i, k) * other get(k, j))
            )
            result set(i, j, sum)
        )
    )
    result
)

a := Matrix clone dim(2, 3)
a set(0, 0, 1) a set(0, 1, 2) a set(0, 2, 3)
a set(1, 0, 4) a set(1, 1, 5) a set(1, 2, 6)

b := Matrix clone dim(3, 2)
b set(0, 0, 7) b set(0, 1, 8)
b set(1, 0, 9) b set(1, 1, 10)
b set(2, 0, 11) b set(2, 1, 12)

c := a multiply(b)
c print