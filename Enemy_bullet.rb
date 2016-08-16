
#弾がプレイヤーを狙って進む
class Enemy_Bullet < Sprite

	#弾が進むスピード
	SPEED = 1

	@@images = Image.load_tiles('enemy_bullet.png', 1, 4)

	attr_accessor :image_num
	attr_accessor :dx
	attr_accessor :dy

	#a, bは発射位置, c, dは発射する方向
	def initialize(a, b, c, d)
		super
		self.image_num = 0
		self.image = @@images[self.image_num]
		self.x, self.y = a, b
		self.dx = (c - a) / (c - a)
		self.dy = (d - b) / (c - a)
	end

	def update
		self.x += -self.dx * SPEED
		self.y += self.dy * SPEED
	end
end