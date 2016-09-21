class PlayerBase < Sprite

	#敵が画面外に出たときに消える範囲
	ENEMY_DELETE_RANGE = 500

	#画面外に出たとき消去する関数
	def delete
		if (self.x <= -ENEMY_DELETE_RANGE) || (self.x >= ENEMY_DELETE_RANGE + Window.width) ||
				(self.y <= -ENEMY_DELETE_RANGE) || (self.y >= ENEMY_DELETE_RANGE + Window.height)
			self.vanish
		end				
	end
end