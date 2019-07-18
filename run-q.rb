require './game.rb'
require './q_learning_player.rb'
require './player.rb'

human = Player.new
robot = QLearningPlayer.new
g = Game.new(human)

# First human plays
g.player = human
puts "\r#{g.run}"
print "Now the AI"
sleep(0.5)
print "."
sleep(0.5)
print "."
sleep(0.5)
puts "."
# Then AI plays
g.player = robot
g.winning_sentence = ''
robot.game = g
result = ''
1000.times do
  result = g.run
  g.reset
end

# p.print_table
puts result
