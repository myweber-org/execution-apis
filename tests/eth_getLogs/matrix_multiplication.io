
Matrix := Object clone do(
    data ::= nil
    rows ::= 0
    cols ::= 0
    
    init := method(arr,
        self data = arr
        self rows = arr size
        self cols = if(arr size > 0, arr at(0) size, 0)
        self
    )
    
    dims := method(list(rows, cols))
    
    at := method(i, j,
        data at(i) at(j)
    )
    
    multiply := method(other,
        if(cols != other rows,
            Exception raise("Matrix dimension mismatch: #{cols} != #{other rows}" interpolate)
        )
        
        result := List clone
        for(i, 0, rows - 1,
            row := List clone
            for(j, 0, other cols - 1,
                sum := 0
                for(k, 0, cols - 1,
                    sum = sum + (at(i, k) * other at(k, j))
                )
                row append(sum)
            )
            result append(row)
        )
        
        Matrix clone init(result)
    )
    
    toString := method(
        data map(row, row join(" ")) join("\n")
    )
)

createMatrix := method(arr,
    Matrix clone init(arr map(row, row asList))
)

a := createMatrix(list(list(1,2,3), list(4,5,6)))
b := createMatrix(list(list(7,8), list(9,10), list(11,12)))

result := a multiply(b)
result toString println

try(
    invalid := createMatrix(list(list(1,2), list(3,4)))
    a multiply(invalid)
) catch(Exception,
    ("Error: " .. error) println
)
Matrix := Object clone
Matrix dims := method(list(x, y))
Matrix set := method(x, y, value, self data at(x) atPut(y, value))
Matrix get := method(x, y, self data at(x) at(y))

Matrix new := method(rows, cols,
    m := Matrix clone
    m data := List clone
    rows repeat(
        row := List clone
        cols repeat(row append(0))
        m data append(row)
    )
    m
)

Matrix print := method(
    self data foreach(i, row,
        row foreach(j, elem,
            elem asString alignLeft(4, " ") print
        )
        "" println
    )
)

Matrix multiply := method(other,
    if(self data size == 0 or other data size == 0,
        Exception raise("Empty matrix")
    )
    
    selfRows := self data size
    selfCols := self data at(0) size
    otherRows := other data size
    otherCols := other data at(0) size
    
    if(selfCols != otherRows,
        Exception raise("Dimension mismatch: " .. selfCols .. " != " .. otherRows)
    )
    
    result := Matrix new(selfRows, otherCols)
    
    for(i, 0, selfRows - 1,
        for(j, 0, otherCols - 1,
            sum := 0
            for(k, 0, selfCols - 1,
                sum = sum + (self get(i, k) * other get(k, j))
            )
            result set(i, j, sum)
        )
    )
    
    result
)

// Example usage
a := Matrix new(2, 3)
a set(0, 0, 1); a set(0, 1, 2); a set(0, 2, 3)
a set(1, 0, 4); a set(1, 1, 5); a set(1, 2, 6)

b := Matrix new(3, 2)
b set(0, 0, 7); b set(0, 1, 8)
b set(1, 0, 9); b set(1, 1, 10)
b set(2, 0, 11); b set(2, 1, 12)

"Matrix A:" println
a print

"Matrix B:" println
b print

"Result of A * B:" println
try(
    c := a multiply(b)
    c print
) catch(Exception,
    "Error: " .. error println
)

// Test error case
d := Matrix new(2, 2)
"Testing dimension mismatch:" println
try(
    a multiply(d)
) catch(Exception,
    "Caught: " .. error println
)