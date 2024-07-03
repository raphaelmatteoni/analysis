# frozen_string_literal: true

require_relative 'data_processor'

def find_team_with_smallest_difference(data)
  data.min_by { |entry| entry[:difference] }
end

def find_data_from_file(file_path)
  data = DataProcessor.process_data(file_path, skip_lines: 2) do |columns|
    {
      team: columns[1],
      goals_for: columns[6].to_i,
      goals_against: columns[8].to_i,
      difference: (columns[6].to_i - columns[8].to_i).abs
    }
  end
  match_info = find_team_with_smallest_difference(data)
  {
    team: match_info[:team],
    goals_for: match_info[:goals_for],
    goals_against: match_info[:goals_against],
    difference: match_info[:difference]
  }
end

file_path = 'soccer.dat'
data = find_data_from_file(file_path)

puts "Team with the smallest goal difference: #{data[:team]} " \
     "(goals_for: #{data[:goals_for]}, goals_against: #{data[:goals_against]}, " \
     "difference: #{data[:difference]}"
