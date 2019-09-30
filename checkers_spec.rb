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

RSpec.describe "move" do
  it "should return game board with specified checker moved" do
    game = Checkers.new

    expect(game.move("x", 3, 8, 4, 7)).to eq([
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

    expect(game.move("x", 3, 8, 4, 9)).to eq("Invalid move")
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
    expect(game.move("x", 4, 3, 5, 4)).to eq("Invalid move")
  end

  it "should only allow checker to move one space" do
    game = Checkers.new

    expect(game.move("x", 3, 8, 5, 6)).to eq("Invalid move")
  end

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
    expect(game.move("x", 4, 3, 6, 5)).to eq([
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
    expect(game.move("x", 3, 2, 5, 4)).to eq("Invalid move")
  end
end
