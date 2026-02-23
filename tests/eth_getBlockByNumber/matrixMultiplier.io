
Matrix := Object clone do(
    dim := method(x, y,
        self x := x
        self y := y
        self data := List clone
        for(i, 1, x,
            row := List clone
            for(j, 1, y, row append(0))
            data append(row)
        )
        self
    )
    
    set := method(i, j, value,
        data at(i-1) atPut(j-1, value)
        self
    )
    
    get := method(i, j,
        data at(i-1) at(j-1)
    )
    
    print := method(
        data foreach(row,
            row foreach(v, write(v, " "))
            writeln
        )
    )
    
    multiply := method(other,
        if(self y != other x,
            Exception raise("Matrix dimension mismatch: " .. self y .. " != " .. other x)
        )
        
        result := Matrix clone dim(self x, other y)
        
        for(i, 1, self x,
            for(j, 1, other y,
                sum := 0
                for(k, 1, self y,
                    sum = sum + (self get(i, k) * other get(k, j))
                )
                result set(i, j, sum)
            )
        )
        
        result
    )
)

// Example usage
a := Matrix clone dim(2, 3)
a set(1, 1, 1) set(1, 2, 2) set(1, 3, 3)
a set(2, 1, 4) set(2, 2, 5) set(2, 3, 6)

b := Matrix clone dim(3, 2)
b set(1, 1, 7) set(1, 2, 8)
b set(2, 1, 9) set(2, 2, 10)
b set(3, 1, 11) set(3, 2, 12)

writeln("Matrix A:")
a print

writeln("Matrix B:")
b print

writeln("Result A × B:")
c := a multiply(b)
c print

// Test error case
d := Matrix clone dim(2, 2)
d set(1, 1, 1) set(1, 2, 2)
d set(2, 1, 3) set(2, 2, 4)

writeln("Testing dimension error:")
try(
    a multiply(d)
) catch(Exception,
    writeln("Caught error: ", error)
)