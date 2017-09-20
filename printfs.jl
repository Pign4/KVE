function paint(space::String)
    print_with_color(Crayon(background = :blue), space)
end

function paint(square::Tuple{Int8,Int8})
    color = square[1] == 0 ? :red :
            square[1] == 1 ? :black : :white
    symbol = square[2] == 0 ? "   " :
             square[2] == 3? " K " : " "*string(square[2])*" "
    print_with_color(Crayon(background = color), symbol)
end

function print_board(player::Int8, board::Array{Tuple{Int8,Int8},1})
    board_to_print = player == 0 ? board : board[end:-1:1]
    paint(" "^21)
    println()
    for y in 1:5:21
        paint(" ")
        for x in y:y+4
            paint(board_to_print[x])
            paint(" ")
        end
        println()
        paint(" "^21)
        println()
    end
end
