class Map

	#これに全８マップを格納する
	attr_accessor :map

	#背景のy座標
	attr_accessor :background_y

	#どれくらいのスピードで背景を動かすか決める
	SCROLL_SPEED = 1

	def initialize(num=nil)
		if (num != nil)
			self.map = Image.load(("images/map/stage" + num.to_s + ".jpg"))
		end

		#背景の座標を初期化
		self.background_y = -self.map.height + Window.height
	end

	def width
		return map.width
	end

	def height
		return map.height
	end

	def scroll
		self.background_y += SCROLL_SPEED if self.background_y <= -1
	end
end