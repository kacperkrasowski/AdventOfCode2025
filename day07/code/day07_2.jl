
let COUNT = 0
let input = collect.(readlines(abspath(@__DIR__, "..","input","input.txt")))
    function stop_condition(input, position)
        len = length(input)
        if position[1]+1 > len
            return true
        else
            return false
        end
    end
    
    function check_split(input,position)
        if input[position[1]+1][position[2]] == '^'
            return true
        else 
            return false
        end
    end


    function move_down!(input, positions)
        #Positions - Dict of previous positiions with count
        new_pos = Dict()
        for position in keys(positions)
           #input[position[1]][position[2]] = Char('0' + positions[position])

            if stop_condition(input, position)
                COUNT += positions[position]
                return true

            elseif check_split(input, position)
                if [position[1]+1, position[2]+1] in keys(new_pos)
                    new_pos[[position[1]+1, position[2]+1]] += positions[position]
                else
                    new_pos[[position[1]+1, position[2]+1]] = positions[position]

                end

                if [position[1]+1, position[2]-1] in keys(new_pos)
                    new_pos[[position[1]+1, position[2]-1]] += positions[position]
                else
                    new_pos[[position[1]+1, position[2]-1]] = positions[position]   
                end 
            else
               if [position[1]+1, position[2]] in keys(new_pos)
                    new_pos[[position[1]+1, position[2]]] += positions[position]
                else
                    new_pos[[position[1]+1, position[2]]] = positions[position]
                end
            end
        end
        println(sum(values(new_pos)))
        move_down!(input, new_pos)
    end

    function main()
        start =  Dict([1, findall(x->x=='S', input[1])...] => 1)
        move_down!(input, start)
    end

    main()
end
end