using LinearAlgebra, RowEchelon

function main()    
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = split.(readlines(input_path), ",")
    search = 1000
    data = Vector{Vector{Int}}()
    for line in input
        push!(data, parse.(Int, line))
    end

    matrix = reduce(hcat, data)'
    dim1 = size(matrix)[1]
    dist_matrix = zeros(dim1, dim1)

    for i in 1:dim1
        dist_matrix[i,:] = distance(matrix[i,:], matrix)
    end

    vals = sort(filter(x->x>0, [dist_matrix...]))
    
    connections = zeros(dim1,dim1)
    locs = []
    parent, siz = initialize(dim1)
    stoping = 0
    i = 0 
    loc = CartesianIndex{2}()
    current = loc
    while stoping != dim1
        i += 1
        loc = findall(x -> x == vals[i], dist_matrix)[1]
        current = loc
        union!(loc[2], loc[1], parent, siz)
        
        stoping = maximum([values(siz)...])
    end
    return matrix[current[1],1] * matrix[current[2],1]
end

function find(x, parent)
    while x != parent[x]
        x = parent[x]
    end
    return x
end

function union!(x,y, parent, size)
    rx = find(x, parent)
    ry = find(y, parent)

    if rx == ry
        return
    end 

    if size[rx] < size[ry]
        rx, ry = ry, rx
    end
    parent[ry] = rx
    size[rx] += size[ry]

end
function initialize(num)
    parent = Dict()
    size = Dict()
    for i in 1:num
        parent[i] = i
        size[i] = 1
    end
    return parent, size
end




function distance(cords1, cords)
    return sum((cords' .- cords1).^2,dims=1)
end

a = main()