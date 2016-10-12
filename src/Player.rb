#プレイヤーを定義する
class Player < Sprite

	#このフレームごとに弾を発射する
	SHOOT_FLAME = 10

	#自機画像のサイズ
	PLAYER_WIDTH = 35
	PLAYER_HEIGHT = 31

	#弾を発射するか判定する
	@@isShoot = true

	#プレイヤーの発射タイミングを測る
	attr_accessor :cnt

	#十字キーを押したときに進む割合（
	@@dx = 4
	@@dy = 4

	def initialize(a = 0, b = 0)
		super
		self.loadimage
		self.x = a - PLAYER_WIDTH / 2
		self.y = b - PLAYER_HEIGHT / 2
		self.cnt = 0
		self.z = 3
	end

	def loadimage
		baseimage = Image.load('images/Player0102.png')
		self.image = baseimage.slice(0, 0, PLAYER_WIDTH, PLAYER_HEIGHT)
	end

	def update
		self.move
	end

	def move
		dx, dy = 0, 0
		
		#左右移動に関して
		dx = -@@dx if Input.key_down?(K_LEFT) && (self.x >= @@dx)
		dx = @@dx if Input.key_down?(K_RIGHT) && (self.x + self.image.width <= Window.width - @@dx)

		#上下移動に関して
		dy = -@@dy if Input.key_down?(K_UP) && (self.y >= @@dy)
		dy = @@dy if Input.key_down?(K_DOWN) && (self.y + self.image.height <= Window.height - @@dy)

		self.x += dx
		self.y += dy
	end

	#SHOOT_FLAMEの数だけフレームが変わったら弾を発射する
	def shoot
		@cnt += 1
		if ((self.cnt = self.cnt % SHOOT_FLAME) == 0 && @@isShoot)
			return Bullet.new(self.x, self.y, self.image.width, self.image.height)
		end
	end
	
	def isShoot=(value)
		@@isShoot = value
	end

	#自機が動けるかどうかを判定す
	def is_Move?
	end

	def hit(obj)
		p obj
		if obj.is_a?(Enemy_Bullet) || obj.is_a?(Enemy_mini)
			@@isShoot = false
			self.vanish
		end
	end
end