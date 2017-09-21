include("printfs.jl")
include("engine.jl")

function execute_move!(player::Int8, move::Tuple{Int8,String,Int8,Int8}, board::Array{Tuple{Int8,Int8},1})
    # should create move history
    board[move[3]] = (2,0)
    board[move[4]] = (player, move[1])
end

function getMove(nMoves::Int8)::Int8
    while true
        print("What's your move? ")
        move = get(tryparse(Int8, readline(STDIN)), Int8(0))
        1 <= move <= nMoves && return move
        println("The move must be an integer between 1 and $(moves)!")
    end
end

function turn(player::Int8, board::Array{Tuple{Int8,Int8},1})::Int8
    # PROBLEM: should always be the same board!
    print_board(board)
    moves = legal_moves(player, board)
    # printBestMove(player, board, depth = 5)
    print_moves(player, moves)
    len::Int8 = length(moves)
    move = moves[getMove(len)]
    execute_move!(player, move, board)
    if board[13] == (player, 3)
        return player
    else
        turn(one(Int8) - player, board[end:-1:1])
    end
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
    print_board(board)
end

main()
