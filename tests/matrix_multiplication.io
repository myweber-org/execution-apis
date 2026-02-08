
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
Matrix := Object clone
Matrix dim := method(x, y,
    self data := List clone
    for(i, 1, y,
        row := List clone setSize(x)
        self data append(row)
    )
    self
)

Matrix set := method(x, y, value,
    self data at(y) atPut(x, value)
    self
)

Matrix get := method(x, y,
    self data at(y) at(x)
)

Matrix rows := method(self data size)
Matrix cols := method(if(self data isEmpty, 0, self data first size))

Matrix print := method(
    self data foreach(i, row,
        row foreach(j, elem,
            if(elem, elem asString, "0") print
            if(j < row size - 1, " " print)
        )
        "" println
    )
)

Matrix multiply := method(other,
    if(self cols != other rows, Exception raise("Incompatible dimensions"))
    
    result := Matrix clone dim(other cols, self rows)
    
    for(i, 0, self rows - 1,
        for(j, 0, other cols - 1,
            sum := 0
            for(k, 0, self cols - 1,
                sum = sum + (self get(k, i) * other get(j, k))
            )
            result set(j, i, sum)
        )
    )
    
    result
)

// Example usage
m1 := Matrix clone dim(2, 2)
m1 set(0, 0, 1) set(1, 0, 2)
m1 set(0, 1, 3) set(1, 1, 4)

m2 := Matrix clone dim(2, 2)
m2 set(0, 0, 5) set(1, 0, 6)
m2 set(0, 1, 7) set(1, 1, 8)

"Matrix 1:" println
m1 print

"Matrix 2:" println
m2 print

"Result of multiplication:" println
m1 multiply(m2) print