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
