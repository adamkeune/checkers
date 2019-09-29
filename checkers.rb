class Checkers
  attr_accessor :board

  def initialize
    @board = [
      [" ", "x", " ", "x", " ", "x", " ", "x"],
      ["x", " ", "x", " ", "x", " ", "x", " "],
      [" ", "x", " ", "x", " ", "x", " ", "x"],
      [" ", " ", " ", " ", " ", " ", " ", " "],
      [" ", " ", " ", " ", " ", " ", " ", " "],
      ["o", " ", "o", " ", "o", " ", "o", " "],
      [" ", "o", " ", "o", " ", "o", " ", "o"],
      ["o", " ", "o", " ", "o", " ", "o", " "],
    ]
  end

  def board
    @board
  end
end
