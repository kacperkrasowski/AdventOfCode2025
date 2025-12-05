function data_ops(input)
    ranges = []
    products = []
    switch = false
    for row in input 

        if row == ""
            switch = true
        elseif switch == false
            push!(ranges, row)
        else
            push!(products, row) 
        end
    end
    return ranges, products
end

function ranges_into_pairs(ranges::Vector{Any})
    items = split.(ranges, "-")
    return items
end
push!

function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = readlines(input_path)
    ranges, products = data_ops(input) 
    products = parse.(Int, products)
    fresh =  ranges_into_pairs(ranges)
    count = 0
    for product in products 
        for range in fresh
            r = parse.(Int,range)

            if product > r[1]-1 && product < r[2]+1
                count += 1
                break
            end
        end
    end
    return count
end
 
main()