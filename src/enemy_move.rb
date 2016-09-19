#列挙対を扱えないので代わりにモジュールを使う
module motion
	#動きを列挙体の用に扱う
	WAVE = 1	#波状に動く
	LENGTH_WISE = 2	#上から下に動く
	CROSS_WIESE = 3
	ARC = 4   #上端の角を中心とした弧を描きながら動く
end
class enemy_move
include motion

end