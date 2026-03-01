
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