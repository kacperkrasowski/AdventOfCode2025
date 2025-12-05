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

function counting(pairs)
    count = 0
    for pair_int in pairs

        count += pair_int[2] - pair_int[1] + 1
    end
    return count
end
function reduce!(pairs, id1, id2)
    # Triplet 1 is the established one and Triplet 2 is the one subject to being reduced 
    # Case 1 - Triplet 2 is a subset of Triplet 1 - delete Triplet 2:
    if pairs[id2][1] > pairs[id1][1]-1 && pairs[id2][2] < pairs[id1][2]+1
        pairs[id2][1] = pairs[id1][1]
        pairs[id2][2] = pairs[id1][2]
    
    # Case 2 - Triplet 2 is part of Triplet 1 from the bottom - trim the top of Triplet 1        
    elseif pairs[id2][2] > pairs[id1][1]-1 && pairs[id2][2] < pairs[id1][2]+1
        pairs[id2][2] = pairs[id1][1]-1
        
    # Case 3 - Triplet 2 is part of Triplet 1 from the top - trim the bottom of Triplet 1
    elseif pairs[id2][1] > pairs[id1][1]-1 && pairs[id2][1] < pairs[id1][2]+1
        pairs[id2][1] = pairs[id1][2]+1
    
    # Case 4 - Triplet 1 is a subset of Triplet 2 - turn Triplet 1 into Triplet 2 (??)
    elseif pairs[id1][1] > pairs[id2][1]-1 && pairs[id1][2] < pairs[id2][2]+1 
        pairs[id1][1] = pairs[id2][1]
        pairs[id1][2] = pairs[id2][2]
    end
    return 0
end

function parse_pairs!(pairs)
    pairs2 = []
    for pair in pairs
        push!(pairs2,parse.(Int, pair))
    end
    return pairs2
end

function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = readlines(input_path)
    ranges, products = data_ops(input) 
    pairs = ranges_into_pairs(ranges)
    pairs =  parse_pairs!(pairs)

    for i in 1:length(pairs)
        for j in i+1:length(pairs)
            #println(i," ",j, " ", length(pairs))
            reduce!(pairs,i,j)
        end
    end
    println(Set)
    count = counting(Set(pairs))
end
 
@time main()