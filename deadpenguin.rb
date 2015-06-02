class DeadPenguin
  attr_reader :finished
  def initialize (window, x, y)
    @window = window
    @x = x
    @y = y
    @radius = 33
    @images = Gosu::Image.load_tiles(window,"penguindeath.png", 67, 62, false)
    @image_index = 0
    @frame_index = 0
    @finished = false
  end
  def draw
    if @frame_index.to_i%4 == 0
      if @image_index < @images.count 
        @images[@image_index].draw(@x - @radius, @y - @radius, 2)
        @image_index += 1
        @frame_index += 1
      else
        @finished = true
      end
    else
      if @image_index < @images.count 
        @images[@image_index].draw(@x - @radius, @y - @radius, 2)
        @frame_index += 1
      else
        @finished = true
      end
    end
  end
end