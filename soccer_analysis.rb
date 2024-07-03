# frozen_string_literal: true

def read_soccer_data(file_path)
  data = []
  content = File.read(file_path)
  pre_content = content.match(/<pre>(.*?)<\/pre>/m)[1]
  pre_content.each_line.with_index do |line, index|
    next if index < 2 || line.start_with?('   ---') || line.strip.empty?

    columns = line.split(/\s+/)

    data << {
      team: columns[2],
      goals_for: columns[7].to_i,
      goals_against: columns[9].to_i,
      difference: (columns[7].to_i - columns[9].to_i).abs
    }
  end
  data
end

def find_team_with_smallest_difference(data)
  data.min_by { |entry| entry[:difference] }
end

def find_data_from_file(file_path)
  data = read_soccer_data("soccer.dat")
  match_info = find_team_with_smallest_difference(data)
  {
    team: match_info[:team],
    goals_for: match_info[:goals_for].to_i,
    goals_against: match_info[:goals_against].to_i,
    difference: (match_info[:goals_for].to_i - match_info[:goals_against].to_i).abs
  }
end

file_path = "soccer.dat"
data = find_data_from_file(file_path)

puts "Team with the smallest goal difference: #{data[:team]} " \
     "(goals_for: #{data[:goals_for]}, goals_against: #{data[:goals_against]}, " \
     "difference: #{data[:difference]}"