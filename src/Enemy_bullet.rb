include Math
#弾がプレイヤーを狙って進む
class Enemy_Bullet < Sprite

	#弾が進むスピード
	SPEED = 1

	@@images = Image.load_tiles('images/enemy_bullet.png', 1, 4)

	attr_accessor :image_num
	attr_accessor :angle  #発射角.x軸の正方向が0となる。[ラジアン]

	#a, bは発射位置, c, dは発射する方向
	def initialize(a, b, c)
		super
		self.image_num = 0
		self.image = @@images[self.image_num]
		self.x, self.y = a, b
		self.angle = c
	end

	def update
		self.x += SPEED * Math.cos(self.angle)
		self.y += SPEED * Math.sin(self.angle)
	end
end