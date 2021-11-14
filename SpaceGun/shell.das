require game_params
require scene
require object

class Shell : Object
    timeLife: float
    kv: float

    def Shell(v:float2; p:float2; sd:float)
        velocity = v
        radius = SHELL_RADIUS_DEFAULT
        position = p
        color = COLOR_USER_SHELL
        timeLife = sd
        kv = SHELL_KV_DEFAULT

    def override draw()
        scene->draw_fill_circle(position, radius, color)

    def override update(dt:float)
        update_position(dt)
        timeLife -= dt
        if timeLife < 0.f
            health = -1