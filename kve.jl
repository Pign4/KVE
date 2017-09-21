include("printfs.jl")
include("engine.jl")

function turn(player::Int8, board::Array{Tuple{Int8,Int8},1})::Int8
    reverseBoard = player == 0 ? board : board[end:-1:1]
    print_board(reverseBoard)
    moves = legal_moves(player, reverseBoard)
    # printBestMove(player, board, depth = 5)
    print_moves(player, moves)
    return 1
    # move = getMove()
    # executeMove(move, board)
    # if playerWins(player, board)
    #     return player
    # else
    #     turn(1 - player, board)
    # end
end

function main()
    # must change data structure for board in future
    board::Array{Tuple{Int8,Int8},1} =
            [(1,1),(1,2),(1,3),(1,4),(1,5),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (0,1),(0,2),(0,3),(0,4),(0,5)]
    winner = turn(zero(Int8), board)
    println("The $(winner == 0 ? "red" : "black") player wins!")
end

main()
