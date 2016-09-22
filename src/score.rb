class Score

	#存在するステージ数
	STAGE = 8

	#スコアを格納する
	attr_accessor :score

	def initialize
		self.score = []

		#スコアを格納する変数を初期化
		STAGE.times do |i|
			self.score[i] = 0
		end

		
	end
end