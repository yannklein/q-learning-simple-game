require_relative 'game'
require_relative 'q_learning_player'
require_relative 'player'
require_relative 'instructions'

# Initialize instances
human = Player.new
robot = QLearningPlayer.new
g = Game.new(human)

# Display intro instructions
instructions

# First human plays
g.player = human
puts "\r#{g.run}"

# Then AI plays
g.player = robot
g.winning_sentence = ''
robot.game = g
result = g.run

# p.print_table
puts result
puts "\nAI's prefered direction per position"
robot.draw_q_table
