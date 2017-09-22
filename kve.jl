include("printfs.jl")
include("engine.jl")

function execute_move!(player::Int8, move::Tuple{Int8,String,Int8,Int8}, board::Array{Tuple{Int8,Int8},1})
    # should create move history
    board[move[3]] = (2,0)
    board[move[4]] = (player, move[1])
end

function turn(player::Int8, board::Array{Tuple{Int8,Int8},1})::Int8
    print_board(player, board)
    moves = legal_moves(player, board)
    # best_move(player, board, depth = 5)
    print_moves(player, moves)
    move = get_move(moves)
    println("\33[2J")
    execute_move!(player, move, board)
    return board[13] == (player, 3) ? player :
                                      turn(one(Int8) - player, board)
end

function main()
    println("\33[2J")
    # must change data structure for board in future
    board::Array{Tuple{Int8,Int8},1} =
            [(1,5),(1,4),(1,3),(1,2),(1,1),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (0,1),(0,2),(0,3),(0,4),(0,5)]
    winner = turn(zero(Int8), board)
    println("The $(winner == 0 ? "red" : "black") player wins!")
    print_board(0, board)
end

main()
