require_relative '../../src/Player'
require_relative '../../src/Bullet'
require_relative '../../src/Enemy_mini'
require_relative '../../src/Expl'
require_relative '../../src/Enemy_bullet'

module Stage1
	class Director

		ENEMY_SPOWN_TIMMING = 15
		
		#これに生成するオブジェクトを格納していく
		attr_accessor :object

		#敵機を出現するタイミングを調節する
		attr_accessor :enemy_cnt

		def initialize
			self.object = []
			self.enemy_cnt = 0

			object << Player.new(Window.width / 2, Window.height * 2 / 3)
		end

		def play

			#敵機を生成する
			spown_enemy

			#オブジェクトの描画処理関係
			Sprite.update(self.object)
			Sprite.clean(self.object)
			Sprite.draw(self.object)

		end

		#敵機を生成する関数
		def spown_enemy
			if self.enemy_cnt % ENEMY_SPOWN_TIMMING == 0
				self.object << Enemy_mini.new
			end

			self.enemy_cnt += 1
			self.enemy_cnt %= ENEMY_SPOWN_TIMMING
		end
	end
end