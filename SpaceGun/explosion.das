
require game_params
require scene
require object

class Explosion : Object
    timeLife: float
    def Explosion(pos:float2)
        position = pos
        color = COLOR_EXPLOSION
        radius = EXPLOSION_FX_RADIUS
        health = 0
        timeLife = EXPLOSION_FX_TIMELIFE
    def override draw()
        scene->draw_fill_circle(position, radius * timeLife, color)
    def override update(dt:float)
        timeLife -= dt
        if timeLife < 0.f
            health = -1