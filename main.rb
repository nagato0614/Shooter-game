require 'dxruby'
require_relative 'scene'
require_relative 'load_scenes'

#初期設定
Window.width = 800
Window.height = 600

Scene.set_current_scene(:title)

Window.loop do 
	break if Input.keyPush?(K_ESCAPE)

	Scene.play_scene
end