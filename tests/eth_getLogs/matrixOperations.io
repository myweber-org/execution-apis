
Matrix := Object clone
Matrix dim := method(x, y,
    self data := List clone
    for(i, 1, y,
        row := List clone
        for(j, 1, x, row append(0))
        data append(row)
    )
    self
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
        row foreach(v, v asString alignLeft(4, " ") print)
        "" println
    )
)

Matrix multiply := method(other,
    result := Matrix clone dim(other data first size, data size)
    for(i, 0, data size - 1,
        for(j, 0, other data first size - 1,
            sum := 0
            for(k, 0, data first size - 1,
                sum = sum + (data at(i) at(k) * other data at(k) at(j))
            )
            result set(j+1, i+1, sum)
        )
    )
    result
)

Matrix determinant := method(
    if(data size != data first size, return "Not a square matrix")
    if(data size == 1, return data at(0) at(0))
    if(data size == 2,
        return data at(0) at(0) * data at(1) at(1) - data at(0) at(1) * data at(1) at(0)
    )
    
    det := 0
    sign := 1
    for(col, 0, data first size - 1,
        submatrix := Matrix clone dim(data size-1, data size-1)
        rowIndex := 0
        for(i, 1, data size - 1,
            colIndex := 0
            for(j, 0, data first size - 1,
                if(j != col,
                    submatrix set(colIndex+1, rowIndex+1, data at(i) at(j))
                    colIndex = colIndex + 1
                )
            )
            rowIndex = rowIndex + 1
        )
        det = det + sign * data at(0) at(col) * submatrix determinant
        sign = sign * -1
    )
    det
)