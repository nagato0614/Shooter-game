require_relative 'scenes/title/director'
require_relative 'scenes/stage1/director'

Scene.add_scene(Title::Director.new, :title)
Scene.add_scene(Stage1::Director.new, :stage1)
Scene.add_scene(Stage2::Director.new, :stage2)
Scene.add_scene(Stage3::Director.new, :stage3)
Scene.add_scene(Stage4::Director.new, :stage4)
Scene.add_scene(Stage5::Director.new, :stage5)
Scene.add_scene(Stage6::Director.new, :stage6)
Scene.add_scene(Stage7::Director.new, :stage7)
Scene.add_scene(Stage8::Director.new, :stage8)
