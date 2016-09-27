require 'bundler'
Bundler.require

require 'dxruby'

#初期設定
Window.width = 800
Window.height = 600

require_relative 'src/score'
require_relative 'src/player_base'
require_relative 'src/Player'
require_relative 'src/Bullet'
require_relative 'src/Enemy_mini'
require_relative 'src/Expl'
require_relative 'src/Enemy_bullet'
require_relative 'src/map'
require_relative 'src/map'
require_relative 'src/enemy_move'
require_relative 'scene'
require_relative 'load_scenes'

Scene.set_current_scene(:title)

font = Font.new(15, "MS 明朝")

Score.instance
Window.loop do 
	break if Input.keyPush?(K_ESCAPE)

	Scene.play_scene

	Window.draw_font(0, 0, Window.real_fps.to_s, font)
	Window.draw_font(0, 15, Score.instance.get_all_score.to_s, font)
end