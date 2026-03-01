
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
    
    set := method(x, y, value,
        data at(x) atPut(y, value)
        self
    )
    
    get := method(x, y,
        data at(x) at(y)
    )
    
    multiply := method(other,
        if(self y != other x,
            Exception raise("Matrix dimension mismatch: " .. self y .. " != " .. other x)
        )
        
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
    
    toString := method(
        output := ""
        data foreach(i, row,
            output = output .. row join(" ") .. "\n"
        )
        output
    )
)

// Example usage
a := Matrix clone dim(2, 3)
a set(0, 0, 1) set(0, 1, 2) set(0, 2, 3)
a set(1, 0, 4) set(1, 1, 5) set(1, 2, 6)

b := Matrix clone dim(3, 2)
b set(0, 0, 7) set(0, 1, 8)
b set(1, 0, 9) set(1, 1, 10)
b set(2, 0, 11) set(2, 1, 12)

c := a multiply(b)
c toString println

// This will throw an exception
d := Matrix clone dim(2, 2)
e := Matrix clone dim(3, 3)
// d multiply(e) // Uncomment to see error