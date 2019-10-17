class Game
  attr_accessor :score, :map_size, :player, :winning_sentence, :cheese_x, :pits
  def initialize(player)
    @map_size = [12, 12] # x and y
    @start_position = [3, 3] # x and y
    @cheese_x = [10, 10] # x and y

    @player = player
    @pits = create_pits
    @winning_sentence = ""

    @run = 0
    @score = 0

    reset

    # Clear the console
    puts "\e[H\e[2J"
  end

  def reset
    @player.x = @start_position[0]
    @player.y = @start_position[1]
    @pit_x = [0, 0] # x and y
    @run += 1
    @moves = 0
  end

  def create_pits
    pits = 40.times.map do
      x = (0..(@map_size[0] - 1)).to_a.sample
      y = (0..(@map_size[1] - 1)).to_a.sample
      [x, y] unless (x == @player.x && y == @player.y) || (x == @cheese_x[0] && y == @cheese_x[1])
    end
    pits
  end

  def run
    # Run if the player is an AI
    if @player.type == "robot"
      print "Now the AI"
      3.times do
        sleep(0.5)
        print '.'
      end
      system 'clear'
      # Let the AI train until it wins 100 times
      until @score >= 100
        draw
        # When it wins, reset the game and keep a track
        case gameloop
        when "win"
          @winning_sentence = "\nRun #{@run}: The AI wins in #{@moves} moves!"
          reset
        when "lose"
          reset
        end
        @moves += 1
      end
      # After the training let AI play one more time slowly
      puts @winning_sentence
      puts "\nLet's review the AI best shot [press a key]"
      STDIN.getch
      draw until gameloop(true) == "win"
      reset
    # Run if the player is a Human
    else
      # Play the game until the human reach the cheese
      until @score >= 1
        draw
        reset if gameloop == "lose"
        @moves += 1
      end
      draw
      @winning_sentence += "\nYou win in #{@moves} moves!"
    end
    # Return the results of the game
    @winning_sentence
  end

  def gameloop(slow_motion = false)
    move = @player.get_input(slow_motion)
    if move == :left
      @player.x = @player.x.positive? ? @player.x - 1 : @map_size[0] - 1
    elsif move == :right
      @player.x = @player.x < @map_size[0] - 1 ? @player.x + 1 : 0
    elsif move == :up
      @player.y = @player.y.positive? ? @player.y - 1 : @map_size[1] - 1
    elsif move == :down
      @player.y = @player.y < @map_size[1] - 1 ? @player.y + 1 : 0
    end

    if @player.x == @cheese_x[0] && @player.y == @cheese_x[1]
      @score += 1
      return "win"
    end
    if @pits.include?([@player.x, @player.y])
      @score -= 1
      return "lose"
    end
    :nothing
  end

  def draw
    # Compute map
    map = []
    @map_size[1].times do |y|
      map_line = @map_size[0].times.map do |x|
        if @player.x == x && @player.y == y
          '[P]'
        elsif @cheese_x[0] == x && @cheese_x[1] == y
          '[C]'
        elsif @pits.include?([x, y])
          ' O '
        else
          ' - '
        end
      end
      map << "#{map_line.join}\n"
    end
    map = "\033[#{(2 + (@map_size[0] * @map_size[1]))}A\r#{map.join} Score #{@score} | Run #{@run}                "
    printf("%s", map)
  end
end
