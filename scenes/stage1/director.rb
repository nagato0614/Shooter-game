require_relative '../../src/Player'
require_relative '../../src/Bullet'
require_relative '../../src/Enemy_mini'
require_relative '../../src/Expl'
require_relative '../../src/Enemy_bullet'

module Stage1
	class Director

		ENEMY_SPOWN_TIMMING = 15

		#マップサイズ（仮）マップクラスを作成する時のこの値をつかう
		MAP_HEIGHT = 1800
		MAP_WIDTH = 800

		#これに生成するオブジェクトを格納していく
		attr_accessor :object

		#敵機を出現するタイミングを調節する
		attr_accessor :enemy_cnt

		#レンダーターゲットを格納する。これでマップの描写を行う
		attr_accessor :render

		def initialize
			self.object = []
			self.enemy_cnt = 0

			#RenderTargetの生成
			self.render = RenderTarget.new(MAP_WIDTH, MAP_HEIGHT)

			self.object << Player.new(Window.width / 2, Window.height * 2 / 3)
			self.object[0].target = self.render
		end

		def play

			#敵機を生成する
			spown_enemy

			#敵が弾を発射する
			shoot

			#オブジェクトの描画処理関係
			Sprite.update(self.object)
			Sprite.check(self.object, self.object)
			Sprite.clean(self.object)
			Sprite.draw(self.object)

			Window.draw(0, 0, self.render)
		end

		#敵が弾を発射する
		def shoot
			self.object.each do |obj|
				if obj.is_a?(Enemy_mini)
					self.object << obj.shoot_bullet
					self.object.last.each do |bul|
						bul.target = self.render
					end
				end
			end
		end

		#敵機を生成する関数
		def spown_enemy
			if self.enemy_cnt % ENEMY_SPOWN_TIMMING == 0
				self.object << Enemy_mini.new
				self.object.last.target = self.render
			end

			self.enemy_cnt += 1
			self.enemy_cnt %= ENEMY_SPOWN_TIMMING
		end
	end
end