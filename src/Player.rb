#プレイヤーを定義する
class Player < Sprite

	#このフレームごとに弾を発射する
	SHOOT_FLAME = 10

	#弾が発射される位置をプレイヤー機の中心にする
	MOVE_CENTER = 7

	#自機画像のサイズ
	PLAYER_WIDTH = 35
	PLAYER_HEIGHT = 31

	#弾を発射するか判定する
	@@isShoot = true

	#プレイヤーの発射タイミングを測る
	attr_accessor :cnt

	#十字キーを押したときに進む割合（
	@@dx = 2
	@@dy = 2

	def initialize(a = 0, b = 0)
		super
		self.loadimage
		self.x = a - PLAYER_WIDTH / 2
		self.y = b - PLAYER_HEIGHT / 2
		self.cnt = 0
	end

	def loadimage
		baseimage = Image.load('images/Player0102.png')
		self.image = baseimage.slice(0, 0, PLAYER_WIDTH, PLAYER_HEIGHT)
	end

	def update
		self.x += Input.x * @@dx
		self.y += Input.y * @@dy
	end

	#SHOOT_FLAMEの数だけフレームが変わったら弾を発射する
	def shoot
		@cnt += 1
		if ((self.cnt = self.cnt % SHOOT_FLAME) == 0 && @@isShoot)
			return Bullet.new(self.x + MOVE_CENTER, self.y)
		else 
			return nil
		end
	end

	def isShoot=(value)
		@@isShoot = value
	end

	#自機が動けるかどうかを判定す
	def isMove

	end

	def hit(obj)
		if obj.is_a?(Enemy_Bullet) || obj.is_a?(Enemy_mini)
			self.vanish
		end
	end
end