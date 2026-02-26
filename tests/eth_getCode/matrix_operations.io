
Matrix := Object clone do(
    dim := method(x, y,
        m := Matrix clone
        m data := List clone
        for(i, 1, y,
            row := List clone
            for(j, 1, x, row append(0))
            m data append(row)
        )
        m
    )
    
    set := method(x, y, value,
        data at(y-1) atPut(x-1, value)
        self
    )
    
    get := method(x, y,
        data at(y-1) at(x-1)
    )
    
    print := method(
        data foreach(row,
            row foreach(v, write(v, " "))
            writeln
        )
    )
    
    multiply := method(other,
        result := Matrix dim(data first size, other data size)
        for(i, 0, data size-1,
            for(j, 0, other data first size-1,
                sum := 0
                for(k, 0, data first size-1,
                    sum = sum + (data at(i) at(k) * other data at(k) at(j))
                )
                result set(j+1, i+1, sum)
            )
        )
        result
    )
    
    transpose := method(
        result := Matrix dim(data size, data first size)
        for(i, 0, data size-1,
            for(j, 0, data first size-1,
                result set(i+1, j+1, data at(j) at(i))
            )
        )
        result
    )
)

a := Matrix dim(2, 2)
a set(1, 1, 1) set(2, 1, 2) set(1, 2, 3) set(2, 2, 4)

b := Matrix dim(2, 2)
b set(1, 1, 5) set(2, 1, 6) set(1, 2, 7) set(2, 2, 8)

writeln("Matrix A:")
a print

writeln("Matrix B:")
b print

writeln("A * B:")
c := a multiply(b)
c print

writeln("Transpose of A:")
a transpose print