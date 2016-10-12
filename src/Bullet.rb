class Bullet < PlayerBase

	SPEED = 5

	#a, bはプレイヤーの座標,px, pyはプレイヤーの画像サイズ
	def initialize(a, b, px, py)
		super
		self.image = Image.load('images/bullet.png')
		self.image.set_color_key(C_WHITE)
		self.x = a + (px / 2) - self.image.width / 2
		self.y = b
	end

	def update
		self.y -= SPEED

		self.delete
	end

	def hit(obj)
		if obj.is_a?(Enemy_mini)
			self.vanish
		elsif obj.is_a?(Boss)
			self.vanish
		end
	end
end