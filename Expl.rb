class Expl < Sprite
	#弾の画像を格納した配列
	@@images

	#現在表示している画像の番号
	attr_accessor :image_num
	private :image_num=

	#弾が消える時間
	DISAPPERAR_TIME = 8

	#弾が変化する割合
	CHANGE_TIME = 0.2

	def initialize(a, b) 
		super
		self.loadimage
		self.x = a
		self.y = b
	end

	def loadimage
		@@images = Image.load_tiles('Explode.png', 1, 4)
		self.image_num = 0
		self.image = @@images[0]
	end

	def change_image
		self.image_num += CHANGE_TIME
	  self.image = @@images[self.image_num % 4]
	end

	def update
		self.change_image
		if (self.image_num >= DISAPPERAR_TIME)
			self.vanish
		end
	end
end
