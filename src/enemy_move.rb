require 'csv'

class Enemy_move
include Motion

	#敵があ出現する間隔
	INTERVAL = 50
	
	#敵が出現するタイミングを計測する
	attr_accessor :y_pos

	#csvデータを格納する
	attr_accessor :data

	def initialize
		self.y_pos = 0
		self.load_data
	end


	#sagae.csvを読み込むメソッド
	def load_data
		self.data = CSV.read('data/stage1.csv', headers: true)
		self.data.each do |i|
			i.each do |j|
				j[1] = j[1].to_i
			end
		end
	end

	#y座標に応じて敵機を出現させる。
	def spown_enemy(y)
		if -y == self.data[self.y_pos]["y_pos"]
			self.y_pos += 1
			return  self.enemy(self.y_pos)
		end
		return nil
	end

	#spown_enemy敵が出現する場合の処理
	def enemy(y)
		cnt = (self.y_pos - 1)
		buf = []
		if self.data[cnt]["motion"] != 0
			self.data[cnt]["spown_num"].times do |i|
				if self.data[cnt]["spown_pos_x"] <= Window.width
					buf << Enemy_mini.new(self.data[cnt]["spown_pos_x"] - i * INTERVAL,
														self.data[cnt]["spown_pos_y"],
														self.data[cnt]["motion"],
														self.data[cnt]["speed"])
				else
					buf << Enemy_mini.new(self.data[cnt]["spown_pos_x"] + i * INTERVAL,
														self.data[cnt]["spown_pos_y"],
														self.data[cnt]["motion"],
														self.data[cnt]["speed"])
				end
			end
			return buf
		end
		return nil
	end
end