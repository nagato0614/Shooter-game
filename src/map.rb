class Map

	#これに全８マップを格納する
	attr_accessor :map

	#背景のy座標
	attr_accessor :background_y

	#どれくらいのスピードで背景を動かすか決める
	SCROLL_SPEED = 1

	def initialize(num=nil)
		self.map = []
		if (num != nil)
			map << Image.load(("images/map/stage" + num.to_s + ".jpg"))
		else
			read_map
		end

		#背景の座標を初期化
		self.background_y = -map.first.height + Window.height
		p [map.first.height, Window.height]
	end

	#背景を一度に読み込む関数
	def read_map
		8.times do |i|
			map << Image.load(("images/map/stage" + (i + 1).to_s + ".jpg"))
		end
	end

	def width
		return map.first.width
	end

	def height
		return map.first.height
	end

	def scroll
		self.background_y += SCROLL_SPEED if self.background_y <= -1
	end
end