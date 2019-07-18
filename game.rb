class Game
  attr_accessor :score, :map_size, :player, :winning_sentence
  def initialize player
    @run = 0
    @map_size = [12, 12] # x and y
    @start_position = [3, 3] # x and y
    @player = player
    @advanced = false
    @winning_sentence = ""
    reset
    @pits = create_pits

    # Clear the console
    puts "\e[H\e[2J"
  end

  def reset
    @player.x = @start_position[0]
    @player.y = @start_position[1]
    @cheese_x = [10, 10] # x and y
    @pit_x = [0, 0] # x and y
    @score = 0
    @run += 1
    @moves = 0
  end

  def create_pits
    pits = 10.times.map do
      x = (0..(@map_size[0] - 1)).to_a.sample
      y = (0..(@map_size[1] - 1)).to_a.sample
      [x, y] unless (x == @player.x && y == @player.y) || (x == @cheese_x[0] && y == @cheese_x[1])
    end
    pits
  end

  def run
    while @score < 5 && @score > -5
      draw
      gameloop
      @moves += 1
    end
    # Draw one last time to update the
    draw
    if @score >= 5
      @winning_sentence += "\nRun #{@run}: You win in #{@moves} moves!"
    else
      @winning_sentence += "Game over"
      puts "Game over"
    end
    return @winning_sentence
  end

  def gameloop
    move = @player.get_input
    if move == :left
      @player.x = @player.x > 0 ? @player.x-1 : @map_size[0]-1;
    elsif move == :right
      @player.x = @player.x < @map_size[0]-1 ? @player.x+1 : 0;
    elsif move == :up
      @player.y = @player.y > 0 ? @player.y-1 : @map_size[1]-1;
    elsif move == :down
      @player.y = @player.y < @map_size[1]-1 ? @player.y+1 : 0;
    end

    if @player.x == @cheese_x[0] && @player.y == @cheese_x[1]
      @score += 1
      @player.x = @start_position[0]
      @player.y = @start_position[1]
    end

    if @pits.include?([@player.x, @player.y])
      @score -= 1
      @player.x = @start_position[0]
      @player.y = @start_position[1]
    end
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
    # p map + map
    # gets.chomp
    # Draw to console
    # use printf because we want to update the line rather than print a new one
    # puts "\e[H\e[2J"
    printf("%s", map)
  end
end
