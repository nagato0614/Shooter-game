module Ending
	class Director

		attr_accessor :image, :render

		def initialize
			@font = Font.new(75, "MS 明朝")
		end

		def play
			Window.draw_font(300, 200, "CLEAR", @font)
		end
		
	end
end