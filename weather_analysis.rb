def find_day_with_smallest_temp_spread(file_path)
  smallest_spread = Float::INFINITY
  min_temp_smallest_spread = Float::INFINITY
  max_temp_smallest_spread = Float::INFINITY
  day_with_smallest_spread = nil
  
  File.foreach(file_path).with_index do |line, index|
    next if index <= 5
    columns = line.split
    next unless columns.size >= 3
    
    day = columns[0].to_i
    max_temp = columns[1].to_i
    min_temp = columns[2].to_i
    spread = max_temp - min_temp

    if spread < smallest_spread
      smallest_spread = spread
      min_temp_smallest_spread = min_temp
      max_temp_smallest_spread = max_temp
      day_with_smallest_spread = day
    end
  end
  
  {day: day_with_smallest_spread, max_temp: max_temp_smallest_spread, min_temp: min_temp_smallest_spread, spread: smallest_spread}
end

file_path = 'w_data.dat'
data = find_day_with_smallest_temp_spread(file_path)

puts "Day with the smallest temperature spread: #{data[:day]} (max: #{data[:max_temp]}, min: #{data[:min_temp]}, spread: #{data[:spread]})"
