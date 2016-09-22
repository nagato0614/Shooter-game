#列挙対を扱えないので代わりにモジュールを使う
module Motion
	#動きを列挙体の用に扱う
	NONE = 0 	#敵を出現させない
	WAVE_RIGHT = 1	#波状に→ｋ方向に動く
	WAVE_LEFT = 2		#左方向に動く
	LENGTH_WISE = 3	#上から下に動く
	CROSS_WIESE_RIGHT = 4 #右に向かって動く
	CROSS_WIESE_LEFT = 5	#左に向かって動く
	ARC = 5  #上端の角を中心とした弧を描きながら動く
end

class Enemy_mini < PlayerBase
include Motion

	#敵機が出現するタイミング
	ENEMY_SPAWN_TIMING = 40

	#waveでの振幅と周期
	AMPLITUDE = 50
	SITA = 30

	#waveでの縦移動の基準となる座標
	attr_accessor :wave_y
	attr_accessor :wave_cnt

	#敵機が進むスピード
	attr_accessor :enemy_speed

	#敵機の画像
	@@images

	#現在表示している画像の番号
	attr_accessor :image_num

	#どのように動かすか
	attr_accessor :motion

	#弾を撃つタイミング操作
	attr_accessor :isShot
	attr_accessor :isShot2
	attr_accessor :shot_timming

	def initialize(data, intervalx, intervaly)
		super
		self.loadimage
		self.isShot = false
		self.isShot2 = true
		self.x = data["spown_pos_x"] + intervalx
		self.wave_cnt = 0 - self.x
		self.y = data["spown_pos_y"] + intervaly
		self.wave_y = self.y
		self.motion = data["motion"]
		self.enemy_speed = data["speed"]
		self.visible = true
		self.shot_timming = data["shot_time"]
	end

	def loadimage
		#画像の読み込み
		@@images = Image.load_tiles('images/enemy_mini.png', 1, 3)
		self.image_num = 0
		self.image = @@images[self.image_num]
	end

	#敵機の画像を変更する（アニメーションにする)
	#loadimageを先に実行しないとエラーが出る
	def change_image
			self.image_num += 0.4
			if (self.image_num >= 3)
				self.image_num = 0
			end
			self.image = @@images[self.image_num]
		end

	#弾を発射するメソッド
	def shoot_bullet
		if self.isShot && self.isShot2
			self.isShot = false
			self.isShot2 = false
			return Enemy_Bullet.new(self.x, self.y, self.image.width, self.image.height, 90.0)
		end
	end

	def update
		self.change_image
		case self.motion
		when Motion::WAVE_RIGHT
			self.wave_right
			self.shot_right
		when Motion::WAVE_LEFT
			self.wave_left
			self.shot_left
		when Motion::LENGTH_WISE
			self.length_wise
		when Motion::CROSS_WIESE_RIGHT
			self.cross_wise
			self.shot_right
		when Motion::CROSS_WIESE_LEFT
			self.cross_wise
			self.shot_left
		end

		self.delete
	end

	#右に移動する敵の討つタイミングを調べる
	def shot_right
		if self.x >= self.shot_timming
			self.isShot = true
		end
	end

	#左に移動する敵の討つタイミングを調べる
	def shot_left
		if self.x <= Window.width - shot_timming
			self.isShot = true
		end		
	end

	def hit(obj)
		if obj.is_a?(Player)
			self.vanish 
		elsif obj.is_a?(Bullet)
			Score.instance.set_score(self.class.name)
			self.vanish
		end
	end

	def wave_right
		self.x += self.enemy_speed
		self.y = self.wave_y - Math.cos(self.wave_cnt / SITA) * AMPLITUDE
		self.wave_cnt -= 0.5
	end

	def wave_left
		self.x -= self.enemy_speed
		self.y = self.wave_y - Math.cos(self.wave_cnt / SITA) * AMPLITUDE
		self.wave_cnt += 0.5
	end

	def length_wise
		self.y += self.enemy_speed
	end

	def cross_wise
		if self.motion == Motion::CROSS_WIESE_RIGHT
			self.x += self.enemy_speed
		else
			self.x -= self.enemy_speed
		end
	end
end