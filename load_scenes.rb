require_relative 'scenes/title/director'
require_relative 'scenes/stage1/director'

Scene.add_scene(Title::Director.new, :title)
Scene.add_scene(Stage1::Director.new, :stage1)