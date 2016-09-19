class Bullet < PlayerBase

	SPEED = 5

	def initialize(a, b)
		super
		self.image = Image.load('images/bullet.png')
		self.image.set_color_key(C_WHITE)
		self.x = a
		self.y = b
	end

	def update
		self.y -= SPEED

		self.delete
	end

	def hit(obj)
		if obj.is_a?(Enemy_mini)
			self.vanish
		end
	end

end