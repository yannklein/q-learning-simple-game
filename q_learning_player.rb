class QLearningPlayer
  attr_accessor :x, :y, :game, :type

  def initialize
    @type = "robot"
    @x = 0
    @y = 0
    @actions = [:left, :right, :up, :down]
    @first_run = true

    @learning_rate = 0.2
    @discount = 0.9
    @epsilon = 1

    @random = Random.new
  end

  def initialize_q_table
    # Initialize q_table states by actions
    map_amount_of_spot = @game.map_size[0] * @game.map_size[1]
    @q_table = Array.new(map_amount_of_spot){ Array.new(@actions.length) }

    # Initialize to random values
    map_amount_of_spot.times do |s|
      @actions.length.times do |a|
        @q_table[s][a] = @random.rand
      end
    end
  end

  def get_input(slow_motion)
    # Pause to make sure humans can follow along
    sleep 0.5 if slow_motion

    if @first_run
      # If this is first run initialize the Q-table
      initialize_q_table
      @first_run = false
    else
      # If this is not the first run
      # Evaluate what happened on last action and update Q table
      # Calculate reward
      reward = 0 # default is 0
      if @old_score < @game.score
        reward = 1 # reward is 1 if our score increased
      elsif @old_score > @game.score
        reward = -1 # reward is -1 if our score decreased
      end

      # Our new state is equal to the player position
      @outcome_state = @x + @y * @game.map_size[0]
      @q_table[@old_state][@action_taken_index] = @q_table[@old_state][@action_taken_index] + @learning_rate * (reward + @discount * @q_table[@outcome_state].max - @q_table[@old_state][@action_taken_index])
    end

    # Capture current state and score
    @old_score = @game.score
    @old_state = @x + @y * @game.map_size[0]

    # Chose action based on Q value estimates for state
    if @random.rand > @epsilon
      # Select random action
      @action_taken_index = @random.rand(@actions.length).round
    else
      # Select based on Q table
      s = @x + @y * @game.map_size[0]
      @action_taken_index = @q_table[s].each_with_index.max[1]
    end

    # Take (and return!) action
    @actions[@action_taken_index]
  end

  def q_table_rounded
    @q_table.map do |proba_array|
      proba_array.map { |proba| proba.round(2) }
    end
  end

  def draw_q_table
    # Compute map
    map = []
    @game.map_size[1].times do |y|
      # Top of the line
      map_line = @game.map_size[0].times.map do |x|
        table_index = x + (y * @game.map_size[0])

        if @q_table[table_index][0] == @q_table[table_index].max
          direction = '←'
        elsif @q_table[table_index][1] == @q_table[table_index].max
          direction = '→'
        elsif @q_table[table_index][2] == @q_table[table_index].max
          direction = '↑'
        elsif @q_table[table_index][3] == @q_table[table_index].max
          direction = '↓'
        end

        if @game.player.x == x && @game.player.y == y
          "[P#{direction}"
        elsif @game.cheese_x[0] == x && @game.cheese_x[1] == y
          '[C]'
        elsif @game.pits.include?([x, y])
          ' O '
        else
          " #{direction} "
        end
      end
      map << "#{map_line.join}\n"
    end
    map.each do |line|
      puts line
    end
  end
end
