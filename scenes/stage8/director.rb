require_relative '../../src/Player'
require_relative '../../src/Bullet'
require_relative '../../src/Enemy_mini'
require_relative '../../src/enemy_move'
require_relative '../../src/Expl'
require_relative '../../src/Enemy_bullet'
require_relative '../../src/map'

module Stage8
	class Director

		@@font = Font.new(15, "MS 明朝")

		#このdirectorが扱うステージ
		attr_accessor :stage

		#敵が出現する間隔
		#まだ敵が動く規則を決めていないのでランダム
		ENEMY_SPOWN_TIMMING = 15

		#次のステージに移動できるスコア
		BORDER = 10

		#これに生成するオブジェクトを格納していく
		attr_accessor :object

		#敵機を出現するタイミングを調節する
		attr_accessor :enemy_cnt

		#レンダーターゲットを格納する。これでマップの描写を行う
		attr_accessor :render

		#背景を保管する
		attr_accessor :map

		#敵機を制御するクラス
		attr_accessor :enemy_move

		#ステージの最後まで到達したら数秒カウントして次のステージに移動できるかどうかの判定をする
		attr_accessor :finish_cnt
		FINITSH_TIME = 100

		#ボス出現フラグ
		attr_accessor :boss_flag

		#Bossクラスのインスタンスを格納する変数
		attr_accessor :boss

		def initialize
			self.stage = 8
			self.enemy_cnt = 0

			#ステージ１の背景を読み込む
			self.map = Map.new(self.stage)

			#RenderTargetの生成
			self.render = RenderTarget.new(self.map.width, self.map.height)

			self.object = []
			self.object << Player.new(Window.width / 2, Window.height * 2 / 3)
			self.object.first.target = self.render

			#self.enemy_move = Enemy_move.new(self.stage)

			self.finish_cnt = 0

			Score.instance.change_stage(self.stage)
		
			self.boss_flag = true
			self.boss = nil
		end

		def play
			#時間による得点を追加する
			Score.instance.set_time_score

			#敵機を生成する
			self.spown_enemy


			#ボスが弾を撃つ
			self.boss_shot

			#敵機がたまを　撃つ
			self.enemy_shot

			#自機が弾を発射する
			self.shoot_player

			#ボスを出現させる
			self.spown_boss

			#背景をスクロールさせる
			self.map.scroll

			#背景を描写する
			self.render.draw(0, self.map.background_y, self.map.map)

			#終了判定
			self.finish_count

			Scene.set_current_scene(:end) unless @object.last.is_a?(Player)

			#オブジェクトの描画処理関係
			Sprite.clean(self.object)
			Sprite.update(self.object)
			Sprite.check(self.object, self.object)
			Sprite.draw(self.object)

			if self.boss != nil
				Sprite.update(self.boss)
				Sprite.check(self.object, self.boss)
				Sprite.check(self.boss, self.object)
				Sprite.draw(self.boss)
			end 

			#表示する範囲を設定する
			Window.draw(0, 0, self.render)
		end

		def spown_boss
			if self.map.background_y > -1000000 && self.boss_flag
				@boss = Boss.new
				self.boss_flag = false
			end
		end

		def boss_shot
			if @boss != nil
				buf = @boss.shoot
				self.object.unshift(buf) if buf != nil
			end
		end

		def finish_count
			if self.map.background_y >= 0
				self.finish_cnt += 1
				if self.finish_cnt >= FINITSH_TIME
					self.next_stage
				end
			end
		end

		#次のステージに行けるかどうかを判定する
		def next_stage
			if Score.instance.get_score >= BORDER
				Scene.set_current_scene(:end)
			else
			end
		end

		def enemy_shot
		#敵が弾を発射t
			self.object.each do |obj|
				if obj.is_a?(Array)
					obj.each do |i|
						if i.is_a?(Enemy_mini)
							buf = i.shoot_bullet
							if buf != nil
								buf.target = self.render
								self.object.unshift(buf)
							end
						end
					end
				else
					if obj.is_a?(Enemy_mini)
						buf = i.shoot_bullet
						if buf != nil
							buf.target = self.render
							self.object.unshift(buf)
						end
					end
				end
			end
		end

		#敵を生成
		def spown_enemy
			buf = self.enemy_move.spown_enemy(self.map.background_y)
			if buf != nil
				buf.each do |obj|
					obj.target = self.render
				end
				self.object.unshift(buf)
			end
		end

		#自機が弾を発射する
		def shoot_player
			if self.object.last.is_a?(Player)
				buf = self.object.last.shoot
				if buf.is_a?(Bullet)
					buf.target = self.render
					self.object.unshift(buf)
				end
			end
		end
	end
end