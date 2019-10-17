def instructions
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
end
