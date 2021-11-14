require game_params
require scene
require object

class Planet : Object
    atmHeight: float
    atmColor: uint
    GM: float
    heightK: float
    atmExist: bool
    rotationAngle: float
    rotationSpeed: float

    def override absolute_velocity()
        return velocity

    def Planet(gm:float; r:float; atmH:float)
        velocity = float2(0.f,0.f)
        position = float2(0.f,0.f)
        radius = r
        atmHeight = atmH
        GM = gm
        heightK = GRAVITY_HEIGHT_K_DEFAULT
        color = COLOR_PLANET
        atmColor = COLOR_ATM
        atmExist = true
        rotationAngle = 0.f
        rotationSpeed = PLANET_ROTATION_SPEED_DEFAULT

    def draw_atm()
        scene->draw_fill_circle(absolute_position(), radius + atmHeight, atmColor)

    def override update(dt:float)
        update_position(dt)
        rotationAngle += rotationSpeed * dt

    def override draw()
        scene->draw_fill_circle(absolute_position(), radius, color)