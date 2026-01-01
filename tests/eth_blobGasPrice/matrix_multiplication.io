
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
Matrix set := method(x, y, value, data at(y-1) atPut(x-1, value); self)
Matrix get := method(x, y, data at(y-1) at(x-1))
Matrix rows := method(data size)
Matrix cols := method(if(data size > 0, data at(0) size, 0))
Matrix print := method(data foreach(i, row, writeln(row join(" "))); writeln)

Matrix multiply := method(other,
    if(cols != other rows, Exception raise("Matrix dimensions incompatible"))
    result := Matrix dim(other cols, rows)
    for(i, 1, rows,
        for(j, 1, other cols,
            sum := 0
            for(k, 1, cols,
                sum = sum + (get(k, i) * other get(j, k))
            )
            result set(j, i, sum)
        )
    )
    result
)

a := Matrix dim(2, 3)
a set(1,1,1); a set(2,1,2)
a set(1,2,3); a set(2,2,4)
a set(1,3,5); a set(2,3,6)

b := Matrix dim(3, 2)
b set(1,1,7); b set(2,1,8); b set(3,1,9)
b set(1,2,10); b set(2,2,11); b set(3,2,12)

writeln("Matrix A:")
a print
writeln("Matrix B:")
b print
writeln("Result A * B:")
c := a multiply(b)
c print