using LinearAlgebra, RowEchelon

function main()    
    path = @__DIR__
    input_path = abspath(path, "..","input","inputt.txt")
    input = split.(readlines(input_path), ",")
    search = 10
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
    vals = vals[1:2*search]
    connections = zeros(dim1,dim1)
    locs = []
    for i in 1:2:2*search
        loc1 = findall(x -> x == vals[i], dist_matrix)[1]
        
        loc2 = findall(x -> x == vals[i], dist_matrix)[2]
        push!(locs, sort([loc1[1], loc1[2]]))
        connections[loc1] = 1
        connections[loc2] = 1
    end
    s = graph_maker(locs, dim1)
    res = sort([values(s)...])
    res[end]*res[end-1]*res[end-2]
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

function graph_maker(locs, num)

    parent = Dict()
    size = Dict()
    for i in 1:num
        parent[i] = i
        size[i] = 1
    end

    for loc in locs
        x = loc[2]
        y = loc[1]
        union!(x,y,parent,size)
    end
    return size
end



function distance(cords1, cords)
    return sum((cords' .- cords1).^2,dims=1)
end

a = main()