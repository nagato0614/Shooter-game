class Enemy_mini < Sprite

	#敵機の出現するy座標
	Y = -10

	#敵機が出現するタイミング
	ENEMY_SPAWN_TIMING = 40

	#敵機が進むスピード
	ENEMY_SPEED = 3

	#敵機の画像
	@@images

	#現在表示している画像の番号
	attr_accessor :image_num
	private :image_num=

	attr_accessor :isShot

	def initialize
		super
		self.isShot = true
		self.loadimage
		#敵機を画面の中心付近に出現させる
		self.x = rand(WIDTH - 48 / 2)
		self.y = Y
	end

	def loadimage
		#画像の読み込み
		@@images = Image.load_tiles('enemy_mini.png', 1, 3)
		self.image_num = 0
		self.image = @@images[self.image_num]
	end

	#敵機の画像を変更する（アニメーションにする)
	#loadimageを先に実行しないとエラーが出る
	def change_image
			self.image_num += 0.4
			if (self.image_num >= 3)
				self.image_num = 0
			end
			self.image = @@images[self.image_num]
	end

	def update
		self.change_image
		self.y += ENEMY_SPEED
		self.vanish if self.y > HEIGHT
	end
end