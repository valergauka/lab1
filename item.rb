
class Item
  attr_accessor :name, :faculty, :semester, :image_url, :width, :height
  
  def initialize(name, faculty, semester, image_url, width, height)
    @name = name
    @faculty = faculty
    @semester = semester
    @image_url = image_url
    @width = width
    @height = height
  end

  def info(&block)
    block.call(self) if block_given?
  end

  def to_s
    "#{name}, #{faculty}, #{semester} #{image_url} in stock"
  end

  def to_h
    { name: name, faculty: faculty, semester: semester, image_url: image_url, width: width, height: height }
  end
end
