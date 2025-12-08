
function check_split(input,position)
    if input[position[1]+1][position[2]] == '^'
        return true
    else 
        return false
    end
end

function stop_condition(input, position)
    len = length(input)
    if position[1]+1 > len
        return true
    else
        return false
    end
end

function move_down!(input, positions)
    new_pos = Set()
    count = 0
    val = true
    for position in positions
        input[position[1]][position[2]] = '|'
        if stop_condition(input, position)
            val = false
            return new_pos, count , val
        elseif check_split(input, position)
            
            push!(new_pos, [position[1]+1, position[2]+1]) 
            push!(new_pos, [position[1]+1, position[2]-1])
            count += 1
        else
            push!(new_pos, [position[1]+1, position[2]]) 
        end
    end
    return new_pos, count , val
end

function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = collect.(readlines(input_path))
    positions =  [[1, findall(x->x=='S', input[1])...]]
    count = 0
    val = true
    while val
        positions, c, val = move_down!(input, positions)
        count += c
    end
    return count
end

main()