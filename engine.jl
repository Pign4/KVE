function dir2index(index::Int8, direction::String)::Int8
    if direction[1] == 'r'
        index % 5 == 0 && return 0
        length(direction) == 1 && return index + 1
        if direction[2] == 'u'
            index > 5 && return index - 4
        else
            index < 21 && return index + 6
        end
    elseif direction[1] == 'l'
        index % 5 == 1 && return 0
        length(direction) == 1 && return index - 1
        if direction[2] == 'u'
            index > 5 && return index - 6
        else
            index < 21 && return index + 4
        end
    elseif direction[1] == 'u'
        return index < 6 ? 0 : index - 5
    else
        return index > 20 ? 0 : index + 5
    end
end

function free(index::Int8, board::Array{Tuple{Int8,Int8},1})::Bool
    # must change in future
    board[index] == (2,0) && return true
    return false
end

function opposite(direction)
    if direction[1] in ['r','l']
        newDirection = replace("rl", direction[1], "")
         return length(direction) == 1 ? newDirection :
                                         newDirection * replace("ud", direction[2], "")
    else
        return replace("ud", direction, "")
    end
end

function possible(player::Int8, index::Int8, direction::String, board::Array{Tuple{Int8,Int8},1})::Int8
    realDirection = player == 0 ? direction : opposite(direction)
    newIndex = dir2index(index, realDirection)
    (newIndex == 0 || !free(newIndex, board)) && return 0
    while true
        nextIndex = dir2index(newIndex, realDirection)
        (nextIndex == 0 || !free(nextIndex, board)) && return newIndex
        newIndex = nextIndex
    end
end

function legal_moves(player::Int8, board::Array{Tuple{Int8,Int8},1})::Array{Any,1}
    moves = []
    for piece in UnitRange{Int8}(1:5)
        index::Int8 = findfirst(board, (player, piece))
        for direction in ["u", "ru", "r", "rd", "d", "ld", "l", "lu"]
            newIndex = possible(player, index, direction, board)
            newIndex == 0 && continue
            newIndex == 13 && piece != 3 && continue
            push!(moves, (int2str(piece)*direction, index, newIndex))
        end
    end
    return moves
end
