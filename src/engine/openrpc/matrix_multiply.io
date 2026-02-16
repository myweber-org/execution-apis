Matrix := Object clone
Matrix dim := method(x, y,
    m := Matrix clone
    m data := List clone
    for(i, 1, y,
        row := List clone
        for(j, 1, x, row append(0))
        m data append(row)
    )
    m
)

Matrix set := method(x, y, value,
    data at(y-1) atPut(x-1, value)
    self
)

Matrix get := method(x, y,
    data at(y-1) at(x-1)
)

Matrix print := method(
    data foreach(row,
        row foreach(v, v print; " " print)
        "" println
    )
)

Matrix multiply := method(other,
    h1 := data size
    w1 := if(h1>0, data at(0) size, 0)
    h2 := other data size
    w2 := if(h2>0, other data at(0) size, 0)
    
    if(w1 != h2, Exception raise("Matrix dimensions incompatible"))
    
    result := Matrix dim(w2, h1)
    
    for(i, 0, h1-1,
        for(j, 0, w2-1,
            sum := 0
            for(k, 0, w1-1,
                sum = sum + (data at(i) at(k) * (other data at(k) at(j)))
            )
            result set(j+1, i+1, sum)
        )
    )
    result
)

a := Matrix dim(2,3)
a set(1,1,1) set(2,1,2)
a set(1,2,3) set(2,2,4)
a set(1,3,5) set(2,3,6)

b := Matrix dim(3,2)
b set(1,1,7) set(2,1,8) set(3,1,9)
b set(1,2,10) set(2,2,11) set(3,2,12)

c := a multiply(b)
c print