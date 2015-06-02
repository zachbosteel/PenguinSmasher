require 'gosu'
require_relative 'penguin.rb'
require_relative "deadpenguin"

class PenguinSmasher < Gosu::Window
  PENGUIN_FREQUENCY = 0.005
  def initialize
    super 800,600,false
    self.caption = "Smack the Penguins for the High Score!"
    @penguins = []
    @deadpenguins = []
    @mjollnir_image = Gosu::Image.new(self,"mjollnir.png",false)
    @angle = 0
    @font = Gosu::Font.new(self,"system",30)
    @score = 0
    @playing = true
    @start_time = 0
    @font = Gosu::Font.new(self,"system",30)
  end
  def update
    @angle = 0
    if rand < PENGUIN_FREQUENCY
      @penguins.push Penguin.new(self)
    end
    @penguins.each do |penguin|
      penguin.move
    end
    @time_left = (100 - ((Gosu.milliseconds-@start_time)/1000)).to_s
    if (Gosu.milliseconds - @start_time) > 100000
      @playing = false
    end
  end
  def button_down (id)
    if @playing == true
      if (id == Gosu::MsLeft)
        @penguins.dup.each do |penguin|
          if Gosu.distance(mouse_x,mouse_y,penguin.x,penguin.y)<60 and penguin.visible  >= 0
            @score += 5
            @penguins.delete penguin
            @deadpenguins.push DeadPenguin.new(self, penguin.x, penguin.y)
          end
        end
      else
        if (id == Gosu::KbSpace)
          @playing = true
          @visible = -10
          @start_time = Gosu.milliseconds
          @score = 0
        end
      end
    end
  end
  def draw
    @penguins.each do |penguin|
      penguin.draw
    end
    if button_down?(Gosu::MsLeft)
      @mjollnir_image.draw_rot(mouse_x-10, mouse_y+10, 1, @angle + 45)
    else
      @mjollnir_image.draw_rot(mouse_x-10, mouse_y+10, 1, @angle)
    end
    @deadpenguins.each do |deadpenguin|
      deadpenguin.draw
    end
    @hit = 0
    @font.draw(@score.to_s,700,20,2)
    @font.draw(@time_left,20,20,2)
    if not @playing
      @font.draw("Game Over", 300,300,3)
      @font.draw("Press the Space Bar to Play Again", 175,350,3)
      @visible = 20
    end
  end
end

window = PenguinSmasher.new
window.show
