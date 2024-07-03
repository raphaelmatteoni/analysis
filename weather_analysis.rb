require_relative 'data_processor'

def find_day_with_smallest_temp_spread(data)
  data.min_by { |entry| entry[:max_temp] - entry[:min_temp] }
end

def find_data_from_file(file_path)
  data = DataProcessor.process_data(file_path, skip_lines: 5) do |columns|
    {
      day: columns[0].to_i,
      max_temp: columns[1].to_i,
      min_temp: columns[2].to_i
    }
  end
  day_info = find_day_with_smallest_temp_spread(data)
  {
    day: day_info[:day],
    max_temp: day_info[:max_temp],
    min_temp: day_info[:min_temp],
    spread: day_info[:max_temp] - day_info[:min_temp]
  }
end

file_path = "w_data.dat"
data = find_data_from_file(file_path)

puts "Day with the smallest temperature spread: #{data[:day]} " \
     "(max: #{data[:max_temp]}, min: #{data[:min_temp]}, " \
     "spread: #{data[:spread]}"
