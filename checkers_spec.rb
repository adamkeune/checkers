require "./checkers"

RSpec.describe "board" do
  it "should return the starting checkers board" do
    game = Checkers.new

    expect(game.board).to eq([
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "O", " ", "x", " ", "x", " ", "x"],
      ["2", " ", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", " ", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", "o", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", " ", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "X", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", " ", " ", "o", " "],
    ])
    expect(game.move(1, 2, 2, 1)).to eq([
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", "o", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", " ", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ]
    expect(game.jump("x", 4, 3, 6, 5)).to eq([
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
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

  it "should not allow checker to jump own checker" do
    game = Checkers.new

    game.board = [
      [" ", "1", "2", "3", "4", "5", "6", "7", "8"],
      ["1", " ", "x", " ", "x", " ", "x", " ", "x"],
      ["2", "x", " ", "x", " ", "x", " ", "x", " "],
      ["3", " ", "x", " ", " ", " ", "x", " ", "x"],
      ["4", " ", " ", "x", " ", " ", " ", " ", " "],
      ["5", " ", " ", " ", " ", " ", " ", " ", " "],
      ["6", "o", " ", "o", " ", "o", " ", "o", " "],
      ["7", " ", "o", " ", "o", " ", "o", " ", "o"],
      ["8", "o", " ", "o", " ", "o", " ", "o", " "],
    ]
    expect(game.jump("x", 3, 2, 5, 4)).to eq("Invalid jump")
  end

  # it "should allow successive jumps" do
  #   game = Checkers.new

  # end
end
