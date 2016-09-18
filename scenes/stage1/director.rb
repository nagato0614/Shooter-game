require_relative '../../src/Player'
require_relative '../../src/Bullet'
require_relative '../../src/Enemy_mini'
require_relative '../../src/Expl'
require_relative '../../src/Enemy_bullet'

module Stage1
	class Director

		#これに生成するオブジェクトを格納していく
		attr_accessor :object

		def initialize
			self.object = []

			object << Player.new(Window.width / 2, Window.height * 2 / 3)
			p [Window.width / 2, Window.height * 2 / 3]
		end

		def play

			#オブジェクトの描画処理関係
			Sprite.update(self.object)
			Sprite.clean(self.object)
			Sprite.draw(self.object)

		end
	end
end