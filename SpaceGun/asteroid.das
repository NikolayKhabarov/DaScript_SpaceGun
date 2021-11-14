require game_params
require scene
require object
require shell
require global
require math
require daslib/random

class Asteroid : Shell
    def Asteroid()
        var a = random_float(seed) * PI * 2.0
        var b = ASTEROID_ANGLE_RANDOM_MULT * random_float(seed)
        var v = ASTEROID_VELOCITY_DEFAULT + ASTEROID_VELOCITY_RANDOM_MULT * random_float(seed)
        var p = ASTEROID_POSITION_DEFAULT + ASTEROID_POSITION_RANDOM_MULT * random_float(seed)
        radius = ASTEROID_RADIUS_DEFAULT + ASTEROID_RADIUS_RANDOM_MULT * random_float(seed)
        velocity = float2(v * cos(a + b), v * sin(a + b))
        position = float2(p * cos(a), p * sin(a))
        timeLife = ASTEROID_TIMELIFE_DEFAULT
        kv = ASTEROID_KV_DEFAULT
        color = COLOR_ASTEROID