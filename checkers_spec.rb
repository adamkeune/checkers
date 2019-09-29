require "./checkers"

RSpec.describe "board" do
  it "should return the starting checkers board" do
    game = Checkers.new

    expect(game.board).to eq([
      [" ", "x", " ", "x", " ", "x", " ", "x"],
      ["x", " ", "x", " ", "x", " ", "x", " "],
      [" ", "x", " ", "x", " ", "x", " ", "x"],
      [" ", " ", " ", " ", " ", " ", " ", " "],
      [" ", " ", " ", " ", " ", " ", " ", " "],
      ["o", " ", "o", " ", "o", " ", "o", " "],
      [" ", "o", " ", "o", " ", "o", " ", "o"],
      ["o", " ", "o", " ", "o", " ", "o", " "],
    ])
  end
end

RSpec.describe "find_piece" do
  it "should return the specified game piece" do
    game = Checkers.new

    expect(game.find_piece("x", 12)).to eq(game.board[2][7])
  end
end

# RSpec.describe "move" do
#   it "should return game board with specified checker moved" do
#     game = Checkers.new

#     expect(game.move("x")).to eq([
#       [" ", "x", " ", "x", " ", "x", " ", "x"],
#       ["x", " ", "x", " ", "x", " ", "x", " "],
#       [" ", "x", " ", "x", " ", "x", " ", " "],
#       [" ", " ", " ", " ", " ", " ", "x", " "],
#       [" ", " ", " ", " ", " ", " ", " ", " "],
#       ["o", " ", "o", " ", "o", " ", "o", " "],
#       [" ", "o", " ", "o", " ", "o", " ", "o"],
#       ["o", " ", "o", " ", "o", " ", "o", " "],
#     ])
#   end
# end
