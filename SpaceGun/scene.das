require daslib/media
require game_params

class Scene
    scale: float
    offset: int2
    pointOfInterest: float2

    def Scene()
        offset = int2(get_screen_width() / 2, get_screen_height() / 2)
        scale = SCREEN_SCALE_DEFAULT

    def draw_circle(position:float2; radius:float; color:uint)
        circle(int((position.x - pointOfInterest.x) * scale) + offset.x, int((position.y - pointOfInterest.y) * scale) + offset.y, int(radius * scale), color)

    def draw_fill_circle(position:float2; radius:float; color:uint)
        fill_circle(int((position.x - pointOfInterest.x) * scale) + offset.x, int((position.y - pointOfInterest.y) * scale) + offset.y, int(radius * scale), color)

    def draw_fill_rect(position:float2; size:float2; color:uint)
        fill_rect(int((position.x - pointOfInterest.x) * scale) + offset.x, int((position.y - pointOfInterest.y) * scale) + offset.y, int(size.x * scale), int(size.y * scale), color)

    def draw_gun_line_mouse(position:float2; color:uint)
        var mouse_pos = int2(get_mouse_position())
        line(int((position.x - pointOfInterest.x) * scale) + offset.x, int((position.y - pointOfInterest.y) * scale) + offset.y, mouse_pos.x, mouse_pos.y, color)

    def draw_gun_line(position:float2; size:float; angle:float; color:uint)
        line(int((position.x - pointOfInterest.x) * scale) + offset.x, int((position.y - pointOfInterest.y) * scale) + offset.y,
            int(((position.x - pointOfInterest.x) + size * cos(angle)) * scale) + offset.x, int(((position.y - pointOfInterest.y) + size * sin(angle)) * scale) + offset.y, color)

var
    scene: Scene?