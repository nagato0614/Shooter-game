require 'dxruby'
load 'Player.rb'
load 'Bullet.rb'
load 'Enemy_mini.rb'
load 'Expl.rb'
load 'Enemy_bullet.rb'

#初期設定
WIDTH = 640		#画面の横幅
HEIGHT = 480		#画面の縦幅
ENEMY_SHOT_TIMING = 100			#敵機が弾を撃つタイミング
Window.resize(WIDTH, HEIGHT)	#ウィンドウサイズ設定
Window.windowed = true				#フルスクリーン
font = Font.new(15)						#デバッグ用のフォント設定

#プレイヤー機を設置する
s = Player.new(Window.width / 2, Window.height / 4 * 3)
bullets = []
enemes = []
enemy_expl = []
cnt = 0
enemy_bullets = []

Window.loop do 

	#弾が発射される（タイミングはメソッド内で定義されている)
	bullets << s.shoot

	if (Input.key_push?(K_ESCAPE))
		exit
	end

	cnt += 1
	if ((cnt = cnt % Enemy_mini::ENEMY_SPAWN_TIMING) == 0)
		enemes << Enemy_mini.new
	end

	#自機と敵機のあたり判定
	enemes.each do |e|
		#敵機の発射判定
		if (e.y >= ENEMY_SHOT_TIMING && e.isShot)
			e.isShot = false
			8.times do |i|
				enemy_bullets << Enemy_Bullet.new(e.x, e.y, i * PI / 4.0)
			end
		end

		if (s === e)
			s.isShoot = false
			#s.vanish		#デバッグのために一時的にコメントアウト
		end
	end

	bullets.each do |b|
		enemes.each do |e|
			if (b === e)
				enemy_expl << Expl.new(e.x, e.y)
				e.vanish
				b.vanish
			end
		end
	end

	#update
	s.update
	Sprite.update(bullets)
	Sprite.update(enemes)
	Sprite.update(enemy_expl)
	Sprite.update(enemy_bullets)

	#draw
	Sprite.draw(bullets)
	Sprite.draw(s)
	Sprite.draw(enemes)
	Sprite.draw(enemy_expl)
	Sprite.draw(enemy_bullets)

	#clean
	Sprite.clean(enemy_expl)
	Sprite.clean(bullets)
	Sprite.clean(enemes)
	Sprite.clean(s)
	Sprite.clean(enemy_bullets)
	#debug
	Window.draw_font(0, 0, "fps : " + Window.real_fps.to_s, font)
	Window.draw_font(0, 15, "bullet : " + bullets.size.to_s, font)
	Window.draw_font(0, 30, "enemy : " + enemes.size.to_s, font)
	Window.draw_font(0, 45, "enemy_bullet : " + enemy_bullets.size.to_s, font)
	Window.draw_font(0, 60, "Player_pos : " + s.x.to_s + ", " + s.y.to_s, font)
end