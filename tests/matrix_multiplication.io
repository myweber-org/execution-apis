
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

Matrix set := method(dataList,
    for(i, 0, x-1,
        for(j, 0, y-1,
            data at(i) atPut(j, dataList at(i) at(j))
        )
    )
    self
)

Matrix print := method(
    data foreach(i, row,
        row foreach(j, element,
            element asString print
            " " print
        )
        "" println
    )
)

Matrix multiply := method(other,
    if(y != other x, return nil)
    result := Matrix clone dim(x, other y)
    for(i, 0, x-1,
        for(j, 0, other y-1,
            sum := 0
            for(k, 0, y-1,
                sum = sum + (data at(i) at(k) * other data at(k) at(j))
            )
            result data at(i) atPut(j, sum)
        )
    )
    result
)

a := Matrix clone dim(2, 3) set(list(list(1,2,3), list(4,5,6)))
b := Matrix clone dim(3, 2) set(list(list(7,8), list(9,10), list(11,12)))
c := a multiply(b)
if(c, c print)