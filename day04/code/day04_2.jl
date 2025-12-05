
function  paper_around(input::Vector{Vector{Char}}, pos::Vector{Int64})
    h = length(input)
    len = length(input[1])
    count = 0
    for i in -1:1
        for j in -1:1
            if all([pos[1]-i>0, pos[2]-j>0, pos[1]-i<h+1, pos[2]-j<len+1])
                if input[pos[1]-i][pos[2]-j] == '@'
                    count += 1
                    if count > 4
                        return 
                    end
                end
            end
        end
    end
    return pos
end


function remove!(input::Vector{Vector{Char}}, positions::Vector{Any})
    removed = 0
    if length(positions) < 1
        return removed
    end

    for pos in positions
        if pos != nothing
            input[pos[1]][pos[2]] = 'x'
            removed += 1
        end
    end
    return removed
end
function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = collect.(readlines(input_path))
    len = length(input)
    removed = 1
    count = 0
    while removed != 0
        positions = []
        for i in 1:len
            for j in 1:len
                if input[i][j] == '@'
                    push!(positions, paper_around(input, [i,j]))
                end
            end
        end
        removed = remove!(input, positions)
        count += removed
    end
    return count
end
main()
