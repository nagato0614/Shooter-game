require 'csv'

class Enemy_move
include Motion

	#敵があ出現する間隔
	INTERVAL = 50
	
	#敵が出現するタイミングを計測する
	attr_accessor :y_pos

	#csvデータを格納する
	attr_accessor :data

	#扱うステージ
	attr_accessor :stage

	def initialize(s)
		self.stage = s
		self.y_pos = 0
		self.load_data
	end


	#sagae.csvを読み込むメソッド
	def load_data
		str = "data/stage" + self.stage.to_s + ".csv"
		p str
		self.data = CSV.read(str, headers: true)
		self.data.each do |i|
			i.each do |j|
				j[1] = j[1].to_i
			end
		end
	end

	#y座標に応じて敵機を出現させる。
	def spown_enemy(y)
		if self.y_pos >= self.data.size
			return nil
		end
		if -y == self.data[self.y_pos]["y_pos"]
			self.y_pos += 1
			buf = []
			case self.data[self.y_pos - 1]["motion"]
			when Motion::WAVE_RIGHT, Motion::WAVE_LEFT
				return self.wave(self.y_pos)
			when Motion::LENGTH_WISE
				return self.length_wise
			when Motion::CROSS_WIESE_RIGHT, Motion::CROSS_WIESE_LEFT
				return self.wave(self.y_pos)
			end
		end
		return nil
	end

	#spown_enemy敵が出現する場合の処理
	def wave(y)
		cnt = (self.y_pos - 1)
		buf = []
	#	if self.data[cnt]["motion"] != 0
			self.data[cnt]["spown_num"].times do |i|
				if self.data[cnt]["spown_pos_x"] <= Window.width / 2
					buf.unshift(Enemy_mini.new(self.data[cnt], -i * INTERVAL, 0))
				else
					buf.unshift(Enemy_mini.new(self.data[cnt], i * INTERVAL, 0))
				end
			end
			return buf
		#end
		#return nil
	end

	def length_wise
		cnt = (self.y_pos - 1)
		buf = []
		self.data[cnt]["spown_num"].times do |i|
					buf.unshift(Enemy_mini.new(self.data[cnt], 0, -i * INTERVAL))
		end
		return buf
	end	
end