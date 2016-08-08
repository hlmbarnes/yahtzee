module Yahtzee

  def roll
    @roll_count = 1
    @roll = Array.new(5) {rand(6) + 1}
    @roll
  end

  def choice(roll)
    puts "You rolled a #{roll}. What category would you like to score?"
    category_choice = gets.chomp.downcase
    score_roll(category_choice)
  end

  def score_roll(category_choice)
    if @scorecard[category_choice] ==  0
      case category_choice
        when "aces" then ones
        when "twos" then twos
        when "threes"  then threes
        when "fours" then fours
        when "fives" then fives
        when "sixes" then sixes
        when "3 of a kind" then three_of_a_kind
        when "4 of a kind" then four_of_a_kind
        when "small straight" then small_straight
        when "large straight" then large_straight
        when "full house" then full_house
        when "yahtzee" then yahtzee
        when "chance" then @scorecard["chance"] = @roll.inject(:+)
    else
      puts "Please choose a category to score your roll"
      category_choice = gets.chomp.downcase
      score_roll[category_choice]
    end
  end

# below are the method definitions for the different roll categories for scoring
  def ones
    if @roll.include?(1)
      @scorecard["aces"] = @roll.select {|x| x == 1}.inject(:+)
    else
      @scorecard["aces"] = "scratch"
    end
  end

  def twos
    if @roll.include?(2)
      @scorecard["twos"] = @roll.select {|x| x == 2}.inject(:+)
    else
      @scorecard["twos"] = "scratch"
    end
  end

  def threes
    if @roll.include?(3)
      @scorecard["threes"] = @roll.select {|x| x == 3}.inject(:+)
    else
      @scorecard["threes"] = "scratch"
  end

  def fours
    if @roll.include?(4)
      @scorecard["fours"] = @roll.select {|x| x == 4}.inject(:+)
    else
      @scorecard["fours"] = "scratch"
    end
  end

  def fives
    if @roll.include?(5)
      @scorecard["fives"] = @roll.select {|x| x == 5}.inject(:+)
    else
      @scorecard["fives"] = "scratch"
  end

  def sixes
    if @roll.include?(6)
      @scorecard["sixes"] = @roll.select {|x| x == 6}.inject(:+)
    else
      @scorecard["sixes"] = "scratch"
    end
  end

  def three_of_a_kind
    if @roll.map {|x| @roll.count(x)}.any? {|y| y >=3}
      @scorecard ["three of a kind"] =@roll.inject(:+)
    else
      puts "You do not have three of a kind, please select another category or type 'scratch' to score 0 for this category."
      scratch = gets.chomp
      if scratch == "scratch"
        @scorecard["three of a kind"] = "scratch"
      elsif @scorecard.has_key?(scratch)
        @turn -= 1
        score_roll(scratch)
      else
        three_of_a_kind
      end
    end
  end

  def four_of_a_kind
    if @roll.map {|x| @roll.count(x)}.any? {|y| y >= 4}
      @scorecard["four of a kind"] = @roll.inject(:+)
    else
      puts "You do not have four of a kind, please select another category or type 'scratch' to score 0 for this category."
      scratch = gets.chomp
      if scratch == "scratch"
        @scorecard["four of a kind"] = "scratch"
      elsif @scorecard.has_key? (scratch)
        @turn -=1
        score_roll(scratch)
      else
        four_of_a_kind
      end
    end
  end

  def full_house
    if @roll.map {|x| @roll.count(x)}.any? {|y| y == 2} && @roll.map {|z| @roll.count(z)}.any? {|i| i == 3}}
      @scorecard["full house"] = 25
    else
      puts "You do not have a full house, please select another category or type 'scratch' to score 0 for this category."
      scratch = gets.chomp
      if scratch == "scratch"
        @scorecard["full house"] = "scratch"
      elsif @scorecard.has_key?(scratch)
        @turn -=1
        score_roll(scratch)
      else
        full_house
      end
    end
  end

  def has_straight?(need)
  num = 1
  @roll = @roll.sort.uniq
  @roll.each_with_index do |e, i|
    if i < @roll.length-1 then
    if (@roll[i+1] - @roll[i]) > 1 then
        break if num >= need
        num = 1
    end
    num += 1
    end
  end 
  num >= need
  end

  def sm_straight
    if has_straight?(4)
        @scorecard["small straight"] = 30
    else
        puts "Your do not have a small straight, please select another category or type 'scratch' to score 0 for this category."
        scratch = gets.chomp
        if scratch == "scratch"
            @scorecard["small straight"] = "scratch"
        elsif @scorecard.has_key?(scratch)
            @turn -= 1
            score_roll(scratch)
        else
            small_straight
        end
    end
  end

  def lg_straight
    if has_straight?(5)
        @scorecard["large. straight"] = 40
    else
        puts "You did not roll a large straight! Please select another category or type scratch to score 0 for this section."
        scratch = gets.chomp
        if scratch == "scratch"
            @scorecard["large straight"] = "scratch"
        elsif @scorecard.has_key?(scratch)
            @turn -= 1
            score_roll(scratch)
        else
            large_straight
        end
    end
  end

  def yahtzee
    if @roll.uniq.size == 1
        @scorecard["yahtzee"] = 50
    else
        puts "You did not roll a Yahtzee! Please select another category or type scratch to score 0 for this section."
        scratch = gets.chomp
        if scratch == "scratch"
            @scorecard["yahtzee"] = "scratch"
        elsif @scorecard.has_key?(scratch)
            @turn -= 1
            score_roll(scratch)
        else
            yahtzee
        end
    end
  end



end
