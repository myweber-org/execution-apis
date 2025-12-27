
Matrix := Object clone do(
    init := method(data,
        self data := data
        self rows := data size
        self cols := if(data size > 0, data at(0) size, 0)
    )
    
    dims := method(list(rows, cols))
    
    multiply := method(other,
        if(cols != other rows, 
            Exception raise("Matrix dimension mismatch: " .. 
                           dims asString .. " vs " .. other dims asString)
        )
        
        result := List clone
        for(i, 0, rows - 1,
            row := List clone
            for(j, 0, other cols - 1,
                sum := 0
                for(k, 0, cols - 1,
                    sum = sum + (data at(i) at(k) * other data at(k) at(j))
                )
                row append(sum)
            )
            result append(row)
        )
        Matrix clone init(result)
    )
    
    asString := method(
        data map(row, row join(" ")) join("\n")
    )
)

// Example usage
a := Matrix clone init(list(list(1,2,3), list(4,5,6)))
b := Matrix clone init(list(list(7,8), list(9,10), list(11,12)))

result := a multiply(b)
result asString println

// This will throw an exception
c := Matrix clone init(list(list(1,2), list(3,4)))
try(
    a multiply(c)
) catch(Exception,
    writeln("Caught error: ", error)
)