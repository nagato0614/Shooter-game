class Score

	#存在するステージ数
	STAGE = 8

	#得点一覧
	ENEMY = 10
	TIME = 0.1

	#スコアを格納する
	attr_accessor :score

	#今プレイしているステージ番号
	attr_accessor :stage

	def initialize
		self.score = []

		#スコアを格納する変数を初期化
		STAGE.times do |i|
			self.score[i] = 0
		end

		self.stage = 0
	end

	#今プレイしているステージを返すメソッド
	#配列用
	#初期化していなければ-1の値を返す
	def now_stage
		return self.stage - 1
	end

	#ステージが変わる場合に使用するメソッド
	def change_stage(s)
		self.stage = s
	end

	#スコアを配列に追加する
	def add_score(s)
		self.score[now_stage] += s
	end

	#引数で得られたオブジェクトに対応する点を得る
	def get_score(obj)
		if obj.is_a?(Enemy_mini)
			self.add_score(ENEMY)
		end
	end

	#時間経過によって得られるスコア
	def get_time_score
		self.add_score(TIME)
	end
end