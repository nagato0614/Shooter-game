class Bullet < Sprite

	SPEED = 5

	def initialize(a, b)
		super
		self.image = Image.load('bullet.png')
		self.x = a
		self.y = b
	end

	def update
		self.y -= SPEED
		self.vanish if self.y < -5
	end
end