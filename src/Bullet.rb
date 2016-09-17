class Bullet < Sprite

	SPEED = 5

	def initialize(a, b)
		super
		self.image = Image.load('images/bullet.png')
		self.x = a
		self.y = b
	end

	def update
		self.y -= SPEED
		self.vanish if self.y < -5
	end

	def hit(obj)
		if obj.is_a?(Enemy_mini)
			is.vanish
		end
	end
end