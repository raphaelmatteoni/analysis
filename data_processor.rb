# data_processor.rb

module DataProcessor
  def self.read_data(file_path, &block)
    content = File.read(file_path)
    pre_content = content.match(/<pre>(.*?)<\/pre>/m)[1]
    pre_content.each_line.with_index do |line, index|
      yield(line, index) if block_given?
    end
  end

  def self.process_data(file_path, skip_lines:, &block)
    data = []
    read_data(file_path) do |line, index|
      next if index < skip_lines
      columns = line.split
      next if columns[0].start_with?("-----")
      data << block.call(columns) if block_given?
    end
    data
  end
end
