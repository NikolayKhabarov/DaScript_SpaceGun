require game_params
require scene
require object
require shell

class VTShell : Shell
    timeOut: float
    proximityFuseRadius: float
    def VTShell(v:float2; p:float2; sd:float)
        velocity = v
        proximityFuseRadius = SHELL_RADIUS_DEFAULT
        radius = SHELL_RADIUS_DEFAULT
        position = p
        color = COLOR_USER_SHELL
        timeLife = sd
        kv = SHELL_KV_DEFAULT
        timeOut = SHELL_TIMEOUT_VT_DEFAULT

    def override get_colision_radius()
        return proximityFuseRadius

    def override update(dt:float)
        update_position(dt)
        timeLife -= dt
        if timeOut < 0.f
            proximityFuseRadius = SHELL_PROXIMITY_FUSE_RADIUS_DEFAULT
        else
            timeOut -= dt
        if timeLife < 0.f
            health = -1

    def override draw()
        scene->draw_fill_circle(position, radius, color)