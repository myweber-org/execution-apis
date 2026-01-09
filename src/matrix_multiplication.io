
Matrix := Object clone do(
    init := method(data,
        self data := data
        self rows := data size
        self cols := data at(0) size
    )
    
    print := method(
        data foreach(row,
            row join(" ") println
        )
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
                    sum = sum + (data at(i) at(k) * other data at(k) at(j))
                )
                row append(sum)
            )
            result append(row)
        )
        Matrix clone init(result)
    )
)

// Example usage
a := Matrix clone init(list(list(1,2,3), list(4,5,6)))
b := Matrix clone init(list(list(7,8), list(9,10), list(11,12)))

"Matrix A:" println
a print

"\nMatrix B:" println
b print

"\nResult of A * B:" println
c := a multiply(b)
c print

// Test error case
d := Matrix clone init(list(list(1,2), list(3,4)))
"\nAttempting invalid multiplication (should fail):" println
e := try(
    a multiply(d)
) catch(Exception,
    writeln("Caught error: ", error)
)