class Map

	#これに全８マップを格納する
	attr_accessor :map

	def initialize(num=nil)
		self.map = []
		if (num != nil)
			map << Image.load(("images/map/stage" + num.to_s + ".jpg"))
		else
			read_map
		end
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
	
end