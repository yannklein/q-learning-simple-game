require 'io/console'

class Player
  attr_accessor :x, :y, :type

  def initialize
    @type = "human"
    @x = 0
    @y = 0
  end

  def get_input(_slow_motion)
    input = STDIN.getch
    if input == 'a'
      return :left
    elsif input == 'd'
      return :right
    elsif input == 'w'
      return :up
    elsif input == 's'
      return :down
    elsif input == 'q'
      exit
    end

    return :nothing
  end
end
