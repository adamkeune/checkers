require "./checkers"

RSpec.describe "board" do
  it "should return the starting checkers board" do
    game = Checkers.new

    expect(game.board).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ])
  end
end

RSpec.describe "toggle_player" do
  it "should switch the player symbols between 'x' and 'o'" do
    game = Checkers.new

    expect(game.toggle_player("x")).to eq("o")
    expect(game.toggle_player("o")).to eq("x")
  end
end

RSpec.describe "king" do
  it "should crown a checker that makes it to the opposite side of the board" do
    game = Checkers.new

    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "o", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ]
    expect(game.king).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ])
  end
end

RSpec.describe "move" do
  it "should return game board with specified checker moved" do
    game = Checkers.new

    expect(game.move(3, 8, 4, 7)).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", "x", " ", "x", " ", " "],
      ["4", " ", " ", " ", " ", " ", " ", "x", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ])
  end

  it "should not allow checker to move off board" do
    game = Checkers.new

    expect(game.move(3, 8, 4, 9)).to eq("Invalid move")
  end

  it "should not allow checker to move into an occupied space" do
    game = Checkers.new

    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", "x", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", "o", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ]
    expect(game.move(4, 3, 5, 4)).to eq("Invalid move")
  end

  it "should only allow checker to move one space" do
    game = Checkers.new

    expect(game.move(3, 8, 5, 6)).to eq("Invalid move")
  end

  it "should only allow player to move their own checkers" do
    game = Checkers.new

    expect(game.move(6, 1, 5, 2)).to eq("Invalid move")
  end

  it "should allow crowned checkers to move backwards" do
    game = Checkers.new
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", " ", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "X", " ", "o", " "],
    ]

    expect(game.move(8, 5, 7, 4)).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ])

    game.current_player = "o"
    expect(game.move(1, 2, 2, 1)).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", " ", " ", "x", " ", "x", " ", "x"],
      ["2", "O", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ])
  end

  it "should not allow regular checkers to move backwards" do
    game = Checkers.new

    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", " ", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "X", " ", "o", " "],
    ]

    expect(game.move(4, 3, 3, 2)).to eq("Invalid move")
    expect(game.move(5, 2, 6, 3)).to eq("Invalid move")
  end
end

RSpec.describe "jump" do
  it "should allow checker to jump opponent's checker" do
    game = Checkers.new

    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", "o", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", " ", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ]
    expect(game.jump(4, 3, 6, 5)).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", "x", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ])
  end

  it "should not allow player to jump their own checker" do
    game = Checkers.new

    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ]
    expect(game.jump(3, 2, 5, 4)).to eq("Invalid jump")
  end

  it "should not allow player to jump empty space" do
    game = Checkers.new

    expect(game.jump(3, 8, 5, 6)).to eq("Invalid jump")
  end

  it "should only allow crowned checkers to jump backwards" do
    game = Checkers.new
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ]

    expect(game.jump(7, 4, 5, 6)).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", "X", " ", " "],
      ["6", "o", " ", " ", " ", " ", " ", "o", " "],
      ["7", " ", "o", " ", " ", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ])
  end
end

RSpec.describe "validate_move" do
  it "should return true if first board space exists" do
    game = Checkers.new

    expect(game.validate_move(3, 8, 4, 7)).to eq(true)
  end

  it "should return false if first board space is not occupied by current player's token" do
    game = Checkers.new

    expect(game.validate_move(4, 1, 5, 2)).to eq(false)
    expect(game.validate_move(6, 1, 5, 2)).to eq(false)
  end

  it "should return false if second board space is not empty" do
    game = Checkers.new

    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ]

    expect(game.validate_move(4, 3, 5, 2)).to eq(false)
  end
end

RSpec.describe "validate_king" do
  it "should return true if selected piece is crowned" do
    game = Checkers.new

    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ]

    expect(game.validate_king(7, 4, 6, 3)).to eq(true)
  end
end

RSpec.describe "validate_jump" do
  it "should return true if first board space exists" do
    game = Checkers.new
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", "x", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ]

    expect(game.validate_jump(4, 1, 6, 3)).to eq(true)
  end

  it "should return false if first board space exists but is occupied by opponent's token" do
    game = Checkers.new

    expect(game.validate_jump(6, 1, 4, 3)).to eq(false)
  end

  it "should return false if second board space does not exist" do
    game = Checkers.new

    expect(game.validate_jump(1, 8, 2, 10)).to eq(false)
  end

  it "should return false if second board space is not empty" do
    game = Checkers.new
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ]

    expect(game.validate_jump(4, 3, 6, 1)).to eq(false)
  end

  it "should return false if the jumped space is not occupied by opponent's checker" do
    game = Checkers.new
    game.current_player = "o"
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ]

    expect(game.validate_jump(6, 1, 4, 3)).to eq(false)
  end
end

RSpec.describe "computer_checkers" do
  it "should return an array of board spaces containing computer's checkers" do
    game = Checkers.new

    expect(game.computer_checkers).to eq([
      [6, 1], [6, 3], [6, 5], [6, 7],
      [7, 2], [7, 4], [7, 6], [7, 8],
      [8, 1], [8, 3], [8, 5], [8, 7],
    ])
  end
end

RSpec.describe "computer_moves" do
  it "should return a filtered array of 'o' spaces with moves available" do
    game = Checkers.new
    array_o = game.computer_checkers

    expect(game.computer_moves(array_o)).to eq([
      [6, 1], [6, 3], [6, 5], [6, 7],
    ])
  end

  it "should include crowned checkers that have available backward moves" do
    game = Checkers.new
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", " ", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ]
    array_o = game.computer_checkers

    expect(game.computer_moves(array_o)).to eq([
      [1, 2], [5, 2], [6, 5], [6, 7], [7, 2],
    ])
  end
end

RSpec.describe "computer_jumps" do
  it "should return a filtered array of 'o' spaces with jumps available" do
    game = Checkers.new
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", " ", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", " ", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "O", " ", " ", " ", "x", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", " ", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "X", " ", "o", " "],
    ]
    array_o = game.computer_checkers

    expect(game.computer_jumps(array_o)).to eq([
      [5, 2], [6, 5], [6, 7],
    ])
  end
end

RSpec.describe "computer_turn" do
  it "should take first available jump" do
    game = Checkers.new

    game.current_player = "o"
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", "x", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", "o", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ]

    expect(game.computer_turn).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "o", " ", "x", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ])
  end

  it "should take first available move if no jumps available" do
    game = Checkers.new
    game.current_player = "o"

    expect(game.computer_turn).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", " ", " ", "o", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ])
  end

  it "should allow the computer to move backwards if checker is crowned" do
    game = Checkers.new
    game.current_player = "o"
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", " ", " ", "x", " ", "x", " ", "x"],
      ["2", "O", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", "x", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ]

    expect(game.computer_turn).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", " ", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["4", " ", " ", " ", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ])
  end

  it "should allow the computer to jump backwards if checker is crowned" do
    game = Checkers.new
    game.current_player = "o"
    game.board = [
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", " ", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "X", " ", "o", " "],
    ]

    expect(game.computer_turn).to eq([
      ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", " ", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", " ", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", "O", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", " ", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "X", " ", "o", " "],
    ])
  end
end
