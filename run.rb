require './game.rb'
require './q_learning_player.rb'
require './player.rb'

human = Player.new
robot = QLearningPlayer.new
g = Game.new(human)

# First human plays
puts '   _                                           _            '
puts '  / )/ _ _  _ _   _   _/  /   /_  _   _// _   /_| /     _   '
puts ' (__/)(-(-_) (-  (//)(/  /)()((-_) ,  //)(-  (  |/  ((/(/(/ '
puts '________________________________________________________ / '
puts''
puts 'You will play a simple game against an AI'
print "[press a key to continue]\r"
STDIN.getch
puts "You are [P] the player, use the A,W,S,D keys to move through the grid"
print "[press a key to continue]\r"
STDIN.getch
puts 'You need to reach [C] the cheese while avoiding the O holes'
print "[press a key to continue]\r"
STDIN.getch
puts 'You need to score 5 points with as less move as possible to win the game'
print "[press a key to continue]\r"
STDIN.getch
puts 'Reaching [C] gives you 1 point, falling in a O takes you 1 point!'
puts 'Ready?'
print "[press a key to PLAY the game]\r"
STDIN.getch
system 'clear'
g.player = human
puts "\r#{g.run}"
print 'Now the AI'
sleep(0.5)
print '.'
sleep(0.5)
print '.'
sleep(0.5)
puts '.'
# Then AI plays
g.player = robot
g.winning_sentence = ''
robot.game = g
result = ''
500.times do
  result = g.run
  g.reset
end

# p.print_table
puts result
puts ""
puts "AI's prefered direction per position"
robot.draw_q_table
