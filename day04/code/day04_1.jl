
function  paper_around(input::Vector{String}, pos::Tuple{Int64, Int64})
    h = length(input)
    len = length(input[1])
    count = 0
    for i in -1:1
        for j in -1:1
            if all([pos[1]-i>0, pos[2]-j>0, pos[1]-i<h+1, pos[2]-j<len+1])
                if input[pos[1]-i][pos[2]-j] == '@'
                    count += 1
                    if count > 4
                        return 0
                    end
                end
            end
        end
    end
    return 1
end

function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = readlines(input_path)
    len = length(input)
    count = 0
    for i in 1:len
        for j in 1:len
            if input[i][j] == '@'
                count += paper_around(input, (i,j))
            end
        end
    end
    
    return count
end
main()
