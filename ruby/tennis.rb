# frozen_string_literal: true

class TennisGame1
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end

  def won_point(playerName)
    if playerName == 'player1'
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    result = ''
    tempScore = 0
    if @p1points == @p2points
      result = {
        0 => 'Love-All',
        1 => 'Fifteen-All',
        2 => 'Thirty-All'
      }.fetch(@p1points, 'Deuce')
    elsif (@p1points >= 4) || (@p2points >= 4)
      minusResult = @p1points - @p2points
      result = if minusResult == 1
                 'Advantage player1'
               elsif minusResult == -1
                 'Advantage player2'
               elsif minusResult >= 2
                 'Win for player1'
               else
                 'Win for player2'
               end
    else
      (1...3).each do |i|
        if i == 1
          tempScore = @p1points
        else
          result += '-'
          tempScore = @p2points
        end
        result += {
          0 => 'Love',
          1 => 'Fifteen',
          2 => 'Thirty',
          3 => 'Forty'
        }[tempScore]
      end
    end
    result
  end
end

class TennisGame2
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end

  def won_point(playerName)
    if playerName == @player1Name
      p1Score
    else
      p2Score
    end
  end

  def score
    result = ''
    if (@p1points == @p2points) && (@p1points < 3)
      result = 'Love' if @p1points == 0
      result = 'Fifteen' if @p1points == 1
      result = 'Thirty' if @p1points == 2
      result += '-All'
    end
    result = 'Deuce' if (@p1points == @p2points) && (@p1points > 2)

    p1res = ''
    p2res = ''
    if (@p1points > 0) && (@p2points == 0)
      p1res = 'Fifteen' if @p1points == 1
      p1res = 'Thirty' if @p1points == 2
      p1res = 'Forty' if @p1points == 3
      p2res = 'Love'
      result = p1res + '-' + p2res
    end
    if (@p2points > 0) && (@p1points == 0)
      p2res = 'Fifteen' if @p2points == 1
      p2res = 'Thirty' if @p2points == 2
      p2res = 'Forty' if @p2points == 3

      p1res = 'Love'
      result = p1res + '-' + p2res
    end

    if (@p1points > @p2points) && (@p1points < 4)
      p1res = 'Thirty' if @p1points == 2
      p1res = 'Forty' if @p1points == 3
      p2res = 'Fifteen' if @p2points == 1
      p2res = 'Thirty' if @p2points == 2
      result = p1res + '-' + p2res
    end
    if (@p2points > @p1points) && (@p2points < 4)
      p2res = 'Thirty' if @p2points == 2
      p2res = 'Forty' if @p2points == 3
      p1res = 'Fifteen' if @p1points == 1
      p1res = 'Thirty' if @p1points == 2
      result = p1res + '-' + p2res
    end
    if (@p1points > @p2points) && (@p2points >= 3)
      result = 'Advantage ' + @player1Name
    end
    if (@p2points > @p1points) && (@p1points >= 3)
      result = 'Advantage ' + @player2Name
    end
    if (@p1points >= 4) && (@p2points >= 0) && ((@p1points - @p2points) >= 2)
      result = 'Win for ' + @player1Name
    end
    if (@p2points >= 4) && (@p1points >= 0) && ((@p2points - @p1points) >= 2)
      result = 'Win for ' + @player2Name
    end
    result
  end

  def setp1Score(number)
    (0..number).each do |_i|
      p1Score
    end
  end

  def setp2Score(number)
    (0..number).each do |_i|
      p2Score
    end
  end

  def p1Score
    @p1points += 1
  end

  def p2Score
    @p2points += 1
  end
end

class TennisGame3
  POINTS_TO_SCORE = %w[Love Fifteen Thirty Forty].freeze

  def initialize(player_one_name, player_two_name)
    @player_one_name = player_one_name
    @player_two_name = player_two_name
    @player_one_points = 0
    @player_two_points = 0
  end

  def won_point(player_name)
    if player_name == @player_one_name
      @player_one_points += 1
    else
      @player_two_points += 1
    end
  end

  def score
    if both_player_points_less_than_four? && sum_of_both_player_points_less_than_six?
      if @player_one_points == @player_two_points
        "#{POINTS_TO_SCORE[@player_one_points]}-All"
      else
        "#{POINTS_TO_SCORE[@player_one_points]}-#{POINTS_TO_SCORE[@player_two_points]}"
      end
    elsif deuce?
      'Deuce'
    elsif advantage?
      "Advantage #{leading_player}"
    else
      "Win for #{leading_player}"
    end
  end

  private

  def both_player_points_less_than_four?
    @player_one_points < 4 && @player_two_points < 4
  end

  def sum_of_both_player_points_less_than_six?
    @player_one_points + @player_two_points < 6
  end

  def deuce?
    @player_one_points == @player_two_points
  end

  def advantage?
    (@player_one_points - @player_two_points).abs == 1
  end

  def leading_player
    @player_one_points > @player_two_points ? @player_one_name : @player_two_name
  end
end
