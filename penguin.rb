class Penguin
  attr_reader :x, :y, :radius_y, :visible
  def initialize (window)
    @images_1 = Gosu::Image.load_tiles(window, "penguinspritesheet.png", 65,78, false)
    @images_2 = Gosu::Image.load_tiles(window, "penguinspritesheet2.png", 65,78, false)
    @radius = 40
    @x = rand(window.width - 2 * @radius) + @radius
    @y = rand(window.height - 2 * @radius) + @radius
    @radius_x = 33
    @radius_y = 39
    @velocity_x = 2
    @velocity_y = 2
    @visible = 0
    @image_index_1 = 0
    @image_index_2 = 0
  end
  def move
    @x += @velocity_x
    @y += @velocity_y
    @visible -= 1
    if @x + @radius_x > 800 or @x - @radius_x < 0
      @velocity_x *= -1
    end
    if @y + @radius_y > 600 or @y - @radius_y < 0
      @velocity_y *= -1
    end
    if @visible < -10 and rand < 0.02
      @visible = rand(20..50)
    end
  end
  def draw
    if @visible > 0
      if @velocity_x < 0
        if @image_index_2 < @images_2.count
          @images_2[@image_index_2].draw(@x - @radius_x, @y - @radius_y, 2)
          @image_index_2 += 1
        else
          @image_index_2 = 0
          @images_2[@image_index_2].draw(@x - @radius_x, @y - @radius_y, 2)
        end
      elsif @velocity_x > 0
        if @image_index_1 < @images_1.count
          @images_1[@image_index_1].draw(@x - @radius_x, @y - @radius_y, 2)
          @image_index_1 += 1
        else
          @image_index_1 = 0
          @images_1[@image_index_1].draw(@x - @radius_x, @y - @radius_y, 2)
        end
      end
    end
  end
end