require game_params
require scene
require object
require planet
require math

class Base : Object
    rootPlanet: Planet?
    positionAngle: float
    velocityAngle: float
    shieldHeight: float
    shieldEnable: bool
    shieldHealth: int
    shieldHealthMax: int
    shieldTimeout: float
    
    def override add_damage(i:int)
        if shieldEnable && shieldHealth > 0
            shieldHealth -= i
        else
            health -= i
    
    def override get_colision_radius()
        if shieldEnable && shieldHealth > 0
            return shieldHeight + radius
        return radius

    def override absolute_velocity()
        if rootPlanet != null
            return rootPlanet->absolute_velocity() + float2(-sin(positionAngle + rootPlanet.rotationAngle),
                cos(positionAngle + rootPlanet.rotationAngle))* (rootPlanet->get_colision_radius() * 2.f * PI * (velocityAngle + rootPlanet.rotationSpeed) / (360.f * DEG_TO_RAD_MULT) ) 
        else
            return velocity

    def Base(a:float; p:Planet?; c:uint; shield:bool)
        positionAngle = a
        color = c
        rootPlanet = p
        radius = BASE_RADIUS_DEFAULT
        health = BASE_HEALTH_DEFAULT
        shieldHeight = BASE_SHIELD_HEIGHT_DEFAULT
        shieldHealth = BASE_SHIELD_HEALTH_DEFAULT
        shieldHealthMax = BASE_SHIELD_HEALTH_MAX_DEFAULT
        shieldTimeout = BASE_SHIELD_TIMEOUT
        velocityAngle = 0.f
        shieldEnable = shield

    def override draw()
        if health <= BASE_HEALTH_DANGER
            scene->draw_circle(absolute_position(), radius, color)
        else
            scene->draw_fill_circle(absolute_position(), radius, color)
        if shieldEnable && shieldHealth > 0
            scene->draw_circle(absolute_position(), radius * 2.f, color)

    def override update(dt:float)
        positionAngle += velocityAngle * dt
        if shieldHealth < shieldHealthMax
            if shieldTimeout > 0.f
                shieldTimeout -= dt
            else
                shieldHealth = shieldHealthMax
                shieldTimeout = BASE_SHIELD_TIMEOUT

    def override absolute_position()
        if rootPlanet != null
            return rootPlanet->absolute_position() + float2(rootPlanet->get_colision_radius() * cos(positionAngle + rootPlanet.rotationAngle),
                rootPlanet->get_colision_radius() * sin(positionAngle + rootPlanet.rotationAngle))
        else
            return position