require game_params
require scene
require object
require planet
require math

class Moon : Planet
    semiMajorAxis:float
    siderialPeriod:float
    meanAnomaly:float

    def override absolute_velocity()
        var v = normalize(absolute_position())
        return float2(-v.y, v.x) * (semiMajorAxis * 2.f * PI / siderialPeriod) 

    def Moon(gm:float; sma:float; meanAn:float; p:float; r:float)
        meanAnomaly = meanAn
        siderialPeriod = p
        semiMajorAxis = sma
        radius = r
        atmHeight = 0.f
        color = COLOR_MOON
        position = float2(semiMajorAxis * cos(meanAnomaly), semiMajorAxis * sin(meanAnomaly))
        GM = gm
        heightK = GRAVITY_HEIGHT_K_DEFAULT
        atmExist = false
        rotationAngle = 0.f
        rotationSpeed = MOON_ROTATION_SPEED_DEFAULT

    def override update_position(dt:float)
        meanAnomaly += dt / siderialPeriod
        position = float2(semiMajorAxis * cos(meanAnomaly), semiMajorAxis * sin(meanAnomaly))

    def override draw()
        scene->draw_fill_circle(absolute_position(), radius, color)

    def override draw_atm()
        null

    def override update(dt:float)
        update_position(dt)
        rotationAngle += rotationSpeed * dt