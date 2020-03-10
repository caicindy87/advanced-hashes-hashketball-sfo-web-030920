require 'pry'
def game_hash
  {
    :home => {
      :team_name => 'Brooklyn Nets',
      :colors => ['Black', 'White'],
      :players => [{
        :player_name => 'Alan Anderson',
        :number => 0,
        :shoe => 16,
        :points => 22,
        :rebounds => 12,
        :assists => 12,
        :steals => 3,
        :blocks => 1,
        :slam_dunks => 1
      }, {:player_name => 'Reggie Evans',
        :number => 30,
        :shoe => 14,
        :points => 12,
        :rebounds => 12,
        :assists => 12,
        :steals => 12,
        :blocks => 12,
        :slam_dunks => 7}, 
        {:player_name => 'Brook Lopez',
        :number => 11,
        :shoe => 17,
        :points => 17,
        :rebounds => 19,
        :assists => 10,
        :steals => 3,
        :blocks => 1,
        :slam_dunks =>15}, 
        {:player_name => 'Mason Plumlee',
        :number => 1,
        :shoe => 19,
        :points => 26,
        :rebounds => 11,
        :assists => 6,
        :steals => 3,
        :blocks => 8,
        :slam_dunks => 5}, {
          :player_name => 'Jason Terry',
        :number => 31,
        :shoe => 15,
        :points => 19,
        :rebounds => 2,
        :assists => 2,
        :steals => 4,
        :blocks => 11,
        :slam_dunks => 1}
        ]
    },
    :away => {
      :team_name => 'Charlotte Hornets',
      :colors => ['Turquoise', 'Purple'],
      :players => [{
        :player_name => 'Jeff Adrien',
        :number => 4,
        :shoe => 18,
        :points => 10,
        :rebounds => 1,
        :assists => 1,
        :steals => 2,
        :blocks => 7,
        :slam_dunks => 2}, 
        {:player_name => 'Bismack Biyombo',
        :number => 0,
        :shoe => 16,
        :points => 12,
        :rebounds => 4,
        :assists => 7,
        :steals => 22,
        :blocks => 15,
        :slam_dunks => 10}, 
        {:player_name => 'DeSagna Diop',
        :number => 2,
        :shoe => 14,
        :points => 24,
        :rebounds => 12,
        :assists => 12,
        :steals => 4,
        :blocks => 5,
        :slam_dunks => 5}, 
        {:player_name => 'Ben Gordon',
        :number => 8,
        :shoe => 15,
        :points => 33,
        :rebounds => 3,
        :assists => 2,
        :steals => 1,
        :blocks => 1,
        :slam_dunks => 0}, 
        {:player_name => 'Kemba Walker',
        :number => 33,
        :shoe => 15,
        :points => 6,
        :rebounds => 12,
        :assists => 12,
        :steals => 7,
        :blocks => 5,
        :slam_dunks => 12}
        ]
    }
  }
end

def num_points_scored(name)
  game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute == :players
        data.each do |player|
          if player[:player_name] == name
            return player[:points]
          end
        end
      end
    end
  end
end

def shoe_size(name)
  game_hash.each do |place, team|
    team.each do |attribute, data|
      if attribute == :players
        data.each do |player_stats|
          if player_stats[:player_name] == name
            return player_stats[:shoe]
          end
        end
      end
     end     
  end
end

def team_colors(team_name)
  # returns an array of that team's colors
  game_hash.each do |place, team|
    if team[:team_name] == team_name
      return team[:colors]
    end
  end
end

# Can use either map or each for team_names method, but map gives cleaner code because it already by definition returns a new array

def team_names
  game_hash.map do |place, team|
    team[:team_name]
  end
end

# def team_names
#   # returns an array of team names
#   team_name_array = []
#   game_hash.each do |place, team|
#     team_name_array.push(team[:team_name])
#   end
#     team_name_array
# end

def player_numbers(team_name)
  jersey_nums = []
  game_hash.each do |place, team|
    if team[:team_name] == team_name
      team.each do |attribute, player_info|
        if attribute == :players
          player_info.each do |data|
            jersey_nums << data[:number]
          end
        end
      end
    end
  end
  jersey_nums
end

def player_stats(name)
  # return a NEW hash of player's stats
  new_hash = {}
  game_hash.each do |place, team|
    team.each do |attribute, player|
      if attribute == :players
        player.each do |data|
          if data[:player_name] == name
            #binding.pry
            new_hash = data.delete_if do |key, value|
              key == :player_name
            end
          end
        end
      end
    end
  end
  new_hash
end

def big_shoe_rebounds
  sizes = []
  game_hash.each do |place, team|
    team.each do |attribute, player|
      if attribute == :players
        player.each do |player_data|
          sizes << player_data[:shoe]
        end
        largest_shoe = sizes.max
        player.each do |player_data|
          if player_data[:shoe] == largest_shoe
            return player_data[:rebounds]
          end
        end
      end
    end
  end
end


def most_points_scored
  points = []
  game_hash.each do |place, team|
    game_hash[place].each do |attribute, data|
      if attribute == :players
        data.each do |player_data|
          points << player_data[:points]
        end
      end
    end
  end
  max_points = points.max
  game_hash.each do |place, team|
    game_hash[place].each do |attribute, data|
      if attribute == :players
        data.each do |player_data|
          if player_data[:points] == max_points
            return player_data[:player_name]
          end
        end
      end
    end
  end
end

def winning_team
  total_home = []
  total_away = []
  game_hash[:home].each do |attribute, data|
      if attribute == :players
        data.each do |player_data|
          total_home << player_data[:points]
        end
      end
    end
   game_hash[:away].each do |attribute, data|
    if attribute == :players
      data.each do |player_data|
        total_home << player_data[:points]
      end
    end
  end
  if total_home.sum > total_away.sum
    "Brooklyn Nets"
  else
    "Charlotte Hornets"
  end
end

def player_with_longest_name
  name_lengths = []
  game_hash.each do |place, team|
    game_hash[place].each do |attribute, data|
      if attribute == :players
        data.each do |player_data|
          name_lengths << player_data[:player_name].length
        end
      end
    end
  end
  max_name_length = name_lengths.max
  game_hash.each do |place, team|
    game_hash[place].each do |attribute, data|
      if attribute == :players
        data.each do |player_data|
          if player_data[:player_name].length == max_name_length
            return player_data[:player_name]
          end
        end
      end
    end
  end
end

def long_name_steals_a_ton?
  steals = []
  game_hash.each do |place, team|
    game_hash[place].each do |attribute, data|
      if attribute == :players
        data.each do |player_data|
          steals << player_data[:steals]
        end
      end
    end
  end
  most_steals = steals.max
  game_hash.each do |place, team|
    game_hash[place].each do |attribute, data|
      if attribute == :players
        data.each do |player_data|
          if player_data[:steals] == most_steals
            player_with_most_steals = player_data[:player_name]
            if player_with_longest_name == player_with_most_steals
    return true
  end
          end
        end
      end
    end
  end
end