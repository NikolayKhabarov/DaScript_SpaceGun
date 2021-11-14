require game_params
require scene
require object
require shell

class GuidanceRoket : Shell
    correctionCount: int
    correctionTimeout: float
    def GuidanceRoket(v:float2; p:float2; sd:float)
        velocity = v
        radius = SHELL_RADIUS_DEFAULT
        position = p
        color = COLOR_USER_SHELL
        timeLife = sd
        kv = SHELL_KV_DEFAULT
        correctionCount = GUIDANCE_ROCKET_CORRECTIONS_DEFAULT
        correctionTimeout = 0.f
    def override update(dt:float)
        update_position(dt)
        timeLife -= dt
        if correctionTimeout > 0.f
            correctionTimeout -= dt
        if timeLife < 0.f
            health = -1