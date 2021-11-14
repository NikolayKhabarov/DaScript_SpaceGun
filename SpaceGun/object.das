require scene
require game_params

class Object
    root: Object?
    health: int
    position: float2
    velocity: float2
    radius: float
    color: uint
    
    def add_damage(i:int)
        health -= i
    
    def get_colision_radius()
        return radius

    def absolute_velocity()
        return velocity

    def Object()
        root = null
        position = float2(0.f,0.f)

    def absolute_position()
        if root != null
            return root->absolute_position() + position
        else
            return position
    def draw()
        scene->draw_fill_circle(absolute_position(), DEFAULT_OBJECT_RADIUS, COLOR_OBJECT_DEFAULT)

    def update_position(dt:float)
        position += velocity * dt

    def update(dt:float)
        update_position(dt)