require_relative 'item_container'

class Cart
  include ItemContainer

  attr_accessor :items

  def initialize
    @items = []
  end

  def save_to_file(filename)
    begin
      file_path = File.join(Dir.pwd, filename)
      puts "Saving cart data to: #{file_path}"

      File.open(filename, 'w') do |file|
        items.each { |item| file.puts item.to_h }
      end
      puts "Cart information saved to #{filename}"
    rescue StandardError => e
      puts "Error saving to file #{filename}: #{e.message}"
      puts e.backtrace
    end
  end

  def save_to_json(filename)
    require 'json'
    json_data = items.map(&:to_h).to_json
    File.write(filename, json_data)
    puts "Cart information saved to #{filename}"
  end

  def save_to_csv(filename)
    require 'csv'
    CSV.open(filename, 'w') do |csv|
      csv << %w[курси]
      items.each { |item| csv << item.to_h.values }
    end
    puts "Cart information saved to #{filename}"
  end
end
