class Boss < PlayerBase

	#体力
	attr_accessor :hit_point

	BOSS_HIT_POINT_MAX = 100

	SPEED = 0.1

	#小さいたまを発射するタイミング
	MINI = 10

	#レーザーを発タイミング
	LASER = 100


	#弾を発射するタイミングをカウントする
	attr_accessor :shot_cnt

	def initialize(a, b)
		super
		self.image = Image.load('images/boss.png')
		self.image.set_color_key(C_WHITE)
		self.x = a
		self.y = b
		self.z = 100

		self.shot_cnt = 0
		self.hit_point = BOSS_HIT_POINT_MAX
		self.collision = [0, 0, self.image.width, 0, self.image.width / 2, self.image.height]
	end

	def hit(obj)
		if obj.is_a?(Bullet)
			self.hit_point -= 1
			if self.hit_point < 0
				p "vanish"
				self.vanish
			end
		end
	end

	def update
		self.y += SPEED
		self.shot_cnt += 1		
	end

	def shoot
		if self.shot_cnt % MINI == 0
			sita = rand(30.0..150.0)
			return Enemy_Bullet.new(self.x, self.y, self.image.width, self.image.height, sita)
		elsif self.shot_cnt % LASER == 0
			#まだできてない
			return nil
		end
		return nil
	end
end