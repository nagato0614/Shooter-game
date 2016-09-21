#列挙対を扱えないので代わりにモジュールを使う
module Motion
	#動きを列挙体の用に扱う
	NONE = 0 	#敵を出現させない
	WAVE_RIGHT = 1	#波状に動く
	WAVE_LEFT = 2
	LENGTH_WISE = 3	#上から下に動く
	CROSS_WIESE_RIGHT = 4 #右から左に動く
	CROSS_WIESE_LEFT = 5
	ARC = 5  #上端の角を中心とした弧を描きながら動く
end

class Enemy_mini < PlayerBase
include Motion

	#敵機が出現するタイミング
	ENEMY_SPAWN_TIMING = 40

	#waveでの振幅と周期
	AMPLITUDE = 25
	SITA = 100

	#waveでの縦移動のカウント
	attr_accessor :wave_cnt

	#敵機が進むスピード
	attr_accessor :enemy_speed

	#敵機の画像
	@@images

	#現在表示している画像の番号
	attr_accessor :image_num

	#どのように動かすか
	attr_accessor :motion

	attr_accessor :isShot

	def initialize(x, y, motion, speed)
		super
		self.loadimage
		self.isShot = true
		self.x = x
		self.y = y
		self.wave_cnt = 0.0 - y
		self.motion = motion
		self.enemy_speed = speed
		self.visible = true
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
		if self.y >= 100 && self.isShot
			self.isShot = false
			return Enemy_Bullet.new(self.x, self.y, 90.0)
		end
	end

	def update
		p [self.x, self.y.round]
		self.change_image
		case self.motion
		when Motion::WAVE_RIGHT
			self.wave_right
		end

		self.delete
	end

	def hit(obj)
		if obj.is_a?(Player)
			self.vanish
		elsif obj.is_a?(Bullet)
			self.vanish
		end
	end

	def wave_right
		self.x += self.enemy_speed
		if (self.x / self.enemy_speed) % 1 == 0
			self.y += Math.sin(self.wave_cnt / SITA) * AMPLITUDE
			self.wave_cnt += 1
		end
	end

end