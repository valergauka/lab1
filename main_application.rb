# main_application.rb
require_relative 'parser'
require_relative 'cart'
require_relative 'item'

class MainApplication
  attr_accessor :user_data, :data_storage_path

  def initialize(user_data = {}, data_storage_path = 'data/')
    @user_data = user_data
    @data_storage_path = data_storage_path

    configure_libraries
  end

  def configure_libraries
    require 'json'
    require 'csv'
  end

  def setup_data_storage
    Dir.mkdir(@data_storage_path) unless Dir.exist?(@data_storage_path)
  end

  def run
    headers = { 'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3' }
    courses_parser = Parser.new('https://www.chnu.edu.ua/navchannia/dlia-studentiv/kataloh-kursiv/', headers)
    parsed_data = courses_parser.parse_website

    cart = Cart.new

    parsed_data[:courses].each do |course|
      course_item = Item.new(course[:name], course[:faculty], course[:semester], course[:image_url], course[:width], course[:height])
      cart.add_item(course_item)
    end

   puts "Cart items count: #{cart.items.size}"
    cart.save_to_file(File.join(@data_storage_path, 'cart_data.txt'))
    cart.save_to_json(File.join(@data_storage_path, 'cart_data.json'))
    cart.save_to_csv(File.join(@data_storage_path, 'cart_data.csv'))
  rescue StandardError => e
    puts "Error in MainApplication run: #{e.message}"
    puts e.backtrace
  end
end
