require daslib/media
require daslib/random
require game_params
require scene
require object
require planet
require moon
require explosion
require shell
require vtshell
require guidance_rocket
require asteroid
require base
require global
require player
require menu_variables

class GameManager
    player: Player
    timeSpeed: int
    pause: bool
    GuidanceShell: GuidanceRoket?
    activePointOfInterest: int
    asteridTimeout: float
    enemyBaseTimeout: float
    indexPointOfInterest: int
    activePlayerBase: int
    playerAllowShot: bool
    playerShotVector: float2
    playerSelectedWeapon: int
    playerBuyGuidanceRocket: bool
    playerBuyVTShell: bool
    celestial: array<Planet?>
    playerBullets: array<Shell?>
    playerBases: array<Base?>
    enemyBullets: array<Shell?>
    enemyBases: array<Base?>
    explosions: array<Object?>

    def buy_weapon(sel:int)
        if sel == 0
            if !playerBuyGuidanceRocket && (player.godmode || player.money > MONEY_BUY_MOD_GUIDANCE_ROCKET)
                playerBuyGuidanceRocket = true
                player.money -= player.godmode ? 0 : MONEY_BUY_MOD_GUIDANCE_ROCKET
                return true
        elif sel == 1
            if !playerBuyVTShell && (player.godmode || player.money > MONEY_BUY_MOD_SHELL_VT)
                playerBuyVTShell = true
                player.money -= player.godmode ? 0 : MONEY_BUY_MOD_GUIDANCE_ROCKET
                return true
        return false

    def select_active_weapon()
        playerSelectedWeapon++
        if playerSelectedWeapon == 1 && !playerBuyVTShell
            playerSelectedWeapon++
        if playerSelectedWeapon == 2 && !playerBuyGuidanceRocket
            playerSelectedWeapon++
        if playerSelectedWeapon > 2
            playerSelectedWeapon = 0

    def select_active_base()
        if length(playerBases) > 0
            activePlayerBase++
            if activePlayerBase >= length(playerBases)
                activePlayerBase = 0

    def update_scene_point_of_interest()
        if activePointOfInterest == 0 && GuidanceShell != null
            scene.pointOfInterest = GuidanceShell->absolute_position()
        elif activePointOfInterest == 1 && activePlayerBase >= 0 && length(playerBases) > activePlayerBase
            scene.pointOfInterest = playerBases[activePlayerBase]->absolute_position()
        elif activePointOfInterest == 2 && length(celestial) > indexPointOfInterest
            scene.pointOfInterest = celestial[indexPointOfInterest]->absolute_position()

    def switch_point_of_interest()
        if activePointOfInterest < 2 
            activePointOfInterest++
        elif activePointOfInterest == 2
            if length(celestial) - 1 > indexPointOfInterest
                indexPointOfInterest++
            else
                activePointOfInterest++
                indexPointOfInterest = 0
        if activePointOfInterest > 2
            activePointOfInterest = 0
            indexPointOfInterest = 0
            if GuidanceShell == null
                switch_point_of_interest()
            if activePlayerBase < 0
                switch_point_of_interest()
            elif length(playerBases) <= activePlayerBase
                switch_point_of_interest()

    def add_player_bullet(o: Shell?)
        push(playerBullets, o)

    def add_enemy_bullet(o: Shell?)
        push(enemyBullets, o)

    def add_player_base(o: Base?)
        push(playerBases, o)

    def add_enemy_base(o: Base?)
        push(enemyBases, o)

    def allow_position(pos:float2; isplayer:bool)
        for o in enemyBases
            if length(pos - o->absolute_position()) < o->get_colision_radius() + (isplayer ? BASE_ENEMY_MIN_RANGE : BASE_ALLY_MIN_RANGE)
                return false
        for o in playerBases
            if length(pos - o->absolute_position()) < o->get_colision_radius() + (isplayer ? BASE_ALLY_MIN_RANGE : BASE_ENEMY_MIN_RANGE)
                return false
        return true

    def add_random_enemy_base()
        var body = random_int(seed) % length(celestial)
        var angle = random_float(seed) * 7.f
        var pos = celestial[body]->absolute_position() + float2(celestial[body]->get_colision_radius() * cos(angle + celestial[body].rotationAngle),
            celestial[body]->get_colision_radius() * sin(angle + celestial[body].rotationAngle))
        if allow_position(pos, false)
            add_enemy_base(new Base(angle, celestial[body], COLOR_ENEMY_BASE, random_float(seed) > 0.5f))
            return true
        return false

    def add_random_player_base(body:int)
        var angle = random_float(seed) * 7.f
        var pos = celestial[body]->absolute_position() + float2(celestial[body]->get_colision_radius() * cos(angle + celestial[body].rotationAngle),
            celestial[body]->get_colision_radius() * sin(angle + celestial[body].rotationAngle))
        if allow_position(pos, true)
            add_player_base(new Base(angle, celestial[body], COLOR_USER_BASE, false))
            return true
        return false
    
    def check_active_player_base()
        if activePlayerBase < 0
            return false
        if length(playerBases) < activePlayerBase + 1
            activePlayerBase = -1
            return false
        return true

    def repair_base()
        if check_active_player_base()
            if playerBases[activePlayerBase].health < BASE_HEALTH_DEFAULT
                playerBases[activePlayerBase].health = BASE_HEALTH_DEFAULT
                return true
        return false

    def buy_shield()
        if check_active_player_base()
            if !playerBases[activePlayerBase].shieldEnable
                playerBases[activePlayerBase].shieldEnable = true
                return true
        return false

    def buy_base(sel:int)
        if sel == 0
            if player.godmode || player.money > MONEY_BUY_BASE_MOON_SMALL
                if add_random_player_base(2)
                    player.money -= player.godmode ? 0 : MONEY_BUY_BASE_MOON_SMALL
                    return true
        elif sel == 1
            if player.godmode || player.money > MONEY_BUY_BASE_MOON_BIG
                if add_random_player_base(1)
                    player.money -= player.godmode ? 0 : MONEY_BUY_BASE_MOON_BIG
                    return true
        elif sel == 2
            if player.godmode || player.money > MONEY_BUY_BASE_PLANET
                if add_random_player_base(0)
                    player.money -= player.godmode ? 0 : MONEY_BUY_BASE_PLANET
                    return true
        elif sel == 3
            if player.godmode || player.money > MONEY_BUY_SHIELD
                if buy_shield()
                    player.money -= player.godmode ? 0 : MONEY_BUY_SHIELD
        elif sel == 4
            if player.godmode || player.money > MONEY_REPAIR_BASE
                if repair_base()
                    player.money -= player.godmode ? 0 : MONEY_REPAIR_BASE
                    return true
        return false


    def init()
        add_player_base(new Base(0.f, celestial[0], COLOR_USER_BASE, false))
        add_random_enemy_base()
        activePointOfInterest = 2
        indexPointOfInterest = 0
        activePlayerBase = 0
        GuidanceShell = null
        playerSelectedWeapon = 0
        playerBuyGuidanceRocket = false
        playerBuyVTShell = false
        timeSpeed = GAME_SPEED_DEFAULT
        pause = true
        player.gameover = false
        player.win = false
        player.playtime = 0.f
        player.godmode = false
        player.score = 0
        player.money = MONEY_DEFAULT
        player.gunReload = 0.f
        player.gunPower = GUN_POWER_DEFAULT
        player.shellSelfDestruct = SHELL_SELF_DESTRUCT_DEFAULT
        asteridTimeout = GAMEPLAY_ASTEROID_TIMEOUT
        enemyBaseTimeout = GAMEPLAY_ENEMY_BASE_TIMEOUT

    def GameManager()
        push(celestial, new Planet(PLANET_GM_DEFAULT, PLANET_RADIUS_DEFAULT, PLANET_ATM_HEIGHT_DEFAULT))
        push(celestial, new Moon(MOON_MAJOR_GM_DEFAULT, MOON_MAJOR_SEMI_MAJOR_AXIS_DEFAULT,
            MOON_MAJOR_MEAN_ANOMALY_DEFAULT, MOON_MAJOR_SIDERIAL_PERIOD_DEFAULT, MOON_MAJOR_RADIUS_DEFAULT))
        push(celestial, new Moon(MOON_MINOR_GM_DEFAULT, MOON_MINOR_SEMI_MAJOR_AXIS_DEFAULT,
            MOON_MINOR_MEAN_ANOMALY_DEFAULT, MOON_MINOR_SIDERIAL_PERIOD_DEFAULT, MOON_MINOR_RADIUS_DEFAULT))
        init()

    def restart()
        clear(playerBullets)
        clear(playerBases)
        clear(enemyBullets)
        clear(enemyBases)
        clear(explosions)
        init()

    def damage(pos:float2; r:float; d:int; isplayer:bool)
        for o in enemyBases
            if length(pos - o->absolute_position()) < r + o->get_colision_radius()
                o->add_damage(d)
                if isplayer
                    player.score += SCORE_BASE
                    player.money += MONEY_DAMAGE_BASE
        if !player.godmode
            for o in playerBases
                if length(pos - o->absolute_position()) < r + o->get_colision_radius()
                    o->add_damage(d)
        for o in enemyBullets
            if length(pos - o.position) < r + o->get_colision_radius()
                o->add_damage(d)
                if isplayer
                    player.score += SCORE_BULLET
                    player.money += MONEY_DESTROY_SHELL
        for o in playerBullets
            if length(pos - o.position) < r + o->get_colision_radius()
                o->add_damage(d)

    def physics_update(dt:float)
        for m in celestial
            m->update(dt)
        for b in playerBullets
            b->update(dt)
            if length(b.position) > GAMEPLAY_MAP_RADIUS
                b.health = -1
            for m in enemyBullets
                if length(m->absolute_position() - b.position) < m->get_colision_radius() + b->get_colision_radius()
                    b.health = -1
            for m in enemyBases
                if length(m->absolute_position() - b.position) < m->get_colision_radius() + b->get_colision_radius()
                    b.health = -1
            for m in celestial
                if m.atmExist
                    if length(m->absolute_position() - b.position) < m.atmHeight + m->get_colision_radius()
                        b.velocity *= 1.f + ((length(b.velocity) * dt * b.kv)/(1.f - length(b.velocity) * dt * b.kv)
                            * (length(b.position - m->absolute_position()) - m->get_colision_radius()) / m.atmHeight )
                b.velocity -= normalize(b.position - m->absolute_position()) * dt * m.GM / pow(m.heightK * length(b.position - m->absolute_position()), 2.f)
                if length(m->absolute_position() - b.position) < m->get_colision_radius() + b->get_colision_radius()
                    b.health = -1
        for b in enemyBullets
            b->update(dt)
            if length(b.position) > GAMEPLAY_MAP_RADIUS
                b.health = -1
            for m in playerBases
                if length(m->absolute_position() - b.position) < m->get_colision_radius() + b->get_colision_radius()
                    b.health = -1
            for m in celestial
                if m.atmExist
                    if length(m->absolute_position() - b.position) < m.atmHeight + m->get_colision_radius()
                        b.velocity *= 1.f + ((length(b.velocity) * dt * b.kv)/(1.f - length(b.velocity) * dt * b.kv)
                            * (length(b.position - m->absolute_position()) - m->get_colision_radius()) / m.atmHeight )
                b.velocity -= normalize(b.position - m->absolute_position()) * dt * m.GM / pow(m.heightK * length(b.position - m->absolute_position()), 2.f)
                if length(m->absolute_position() - b.position) < m->get_colision_radius() + b->get_colision_radius()
                    b.health = -1

    def gameover()
        if !player.godmode
            if length(playerBases) * GAMEPLAY_WIN_SUPERIORITY < length(enemyBases)
                player.gameover = true
                player.win = false
            if length(playerBases)  > length(enemyBases) * GAMEPLAY_WIN_SUPERIORITY
                player.gameover = true
                player.win = true
            if player.money < GAMEPLAY_MAX_GAMEOVER_CREDIT
                player.gameover = true
                player.win = false
            if player.gameover
                pause = true

    def gameplay_update(dt:float)
        if GuidanceShell != null
            if GuidanceShell.health < 0
                GuidanceShell = null
                switch_point_of_interest()
        gameover()
        player.playtime += dt
        if asteridTimeout < 0.f
            add_enemy_bullet(new Asteroid())
            asteridTimeout = GAMEPLAY_ASTEROID_TIMEOUT
        else
            asteridTimeout -= dt
        if enemyBaseTimeout < 0.f
            if add_random_enemy_base()
                enemyBaseTimeout = GAMEPLAY_ENEMY_BASE_TIMEOUT
        else
            enemyBaseTimeout -= dt
        for b in playerBases
            b->update(dt)
        for b in enemyBases
            b->update(dt)

    def fx_update(dt:float)
        for e in explosions
            e->update(dt)

    def check_dead_objects()
        var idx = length(playerBullets) -1
        while idx >=0
            if playerBullets[idx].health < 0
                damage(playerBullets[idx].position, SHELL_DAMAGE_RADIUS, SHELL_DAMAGE_HITPOWER, true)
                push(explosions, new Explosion(playerBullets[idx].position))
                erase(playerBullets, idx)
            idx--

        idx = length(enemyBullets) -1
        while idx >=0
            if enemyBullets[idx].health < 0
                damage(enemyBullets[idx].position, SHELL_DAMAGE_RADIUS, SHELL_DAMAGE_HITPOWER, false)
                push(explosions, new Explosion(enemyBullets[idx].position))
                erase(enemyBullets, idx)
            idx--

        idx = length(enemyBases) -1
        while idx >=0
            if enemyBases[idx].health < 0
                erase(enemyBases, idx)
            idx--

        idx = length(playerBases) -1
        while idx >=0
            if playerBases[idx].health < 0
                erase(playerBases, idx)
                if activePlayerBase == idx
                    activePlayerBase = -1
            idx--

        idx = length(explosions) -1
        while idx >=0
            if explosions[idx].health < 0
                erase(explosions, idx)
            idx--

    def update(dt:float)
        if player.gunReload > 0.f
            player.gunReload -= dt
        physics_update(dt)
        gameplay_update(dt)
        fx_update(dt)
        check_dead_objects()
        update_scene_point_of_interest()

    def player_is_allow_shot()
        var mouse_pos = get_mouse_position()
        if playerSelectedWeapon == 2 && GuidanceShell != null
            var shoot_pos = GuidanceShell->absolute_position()
            shoot_pos -= scene.pointOfInterest
            shoot_pos *= scene.scale
            shoot_pos += float2(scene.offset)
            playerShotVector = normalize(mouse_pos - shoot_pos)
            line(int(shoot_pos.x), int(shoot_pos.y), int(mouse_pos.x), int(mouse_pos.y), COLOR_USER_BASE)
            return false
        else
            if activePlayerBase < 0
                return false
            if length(playerBases) < activePlayerBase + 1
                activePlayerBase = -1
                return false
            var shoot_pos = playerBases[activePlayerBase]->absolute_position()
            var base_pos = normalize(shoot_pos - playerBases[activePlayerBase].rootPlanet->absolute_position())
            shoot_pos -= scene.pointOfInterest
            shoot_pos *= scene.scale
            shoot_pos += float2(scene.offset)
            playerShotVector = normalize(mouse_pos - shoot_pos)
            if dot(playerShotVector, base_pos) > GUN_ANGLE_COS_DISABLE
                player.gunAngle = acos(dot(playerShotVector, base_pos)) * RAD_TO_DEG_MULT
                if !menuActive
                    line(int(shoot_pos.x), int(shoot_pos.y), int(mouse_pos.x), int(mouse_pos.y), COLOR_USER_BASE)
                return true
        return false

    def guidance_correction()
        if GuidanceShell != null
            if GuidanceShell.correctionTimeout <= 0.f && GuidanceShell.correctionCount > 0
                GuidanceShell.correctionCount--
                GuidanceShell.correctionTimeout = GUIDANCE_ROCKET_CORRECTION_TIMEOUT
                GuidanceShell.velocity += GUIDANCE_ROCKET_CORRECTION_VELOCITY * playerShotVector

    def player_shot()
        if playerSelectedWeapon == 0
            add_player_bullet(new Shell(playerShotVector * GUN_POWER_MULT * player.gunPower + playerBases[activePlayerBase]->absolute_velocity(),
                playerBases[activePlayerBase]->absolute_position() + playerShotVector * playerBases[activePlayerBase].radius, player.shellSelfDestruct))
            player.money -= player.godmode ? 0 : MONEY_SHELL_BASIC
        if playerSelectedWeapon == 1
            add_player_bullet(new VTShell(playerShotVector * GUN_POWER_MULT * player.gunPower + playerBases[activePlayerBase]->absolute_velocity(),
                playerBases[activePlayerBase]->absolute_position() + playerShotVector * playerBases[activePlayerBase].radius, player.shellSelfDestruct))
            player.money -= player.godmode ? 0 : MONEY_SHELL_VT
        if playerSelectedWeapon == 2
            if GuidanceShell == null
                GuidanceShell = new GuidanceRoket(playerShotVector * GUN_POWER_MULT * player.gunPower + playerBases[activePlayerBase]->absolute_velocity(),
                    playerBases[activePlayerBase]->absolute_position() + playerShotVector * playerBases[activePlayerBase].radius, player.shellSelfDestruct)
                add_player_bullet(GuidanceShell)
                player.money -= player.godmode ? 0 : MONEY_GUIDANCE_ROCKET
                activePointOfInterest = 0

    def draw()
        for o in celestial
            o->draw_atm()
        playerAllowShot = player_is_allow_shot()
        for o in enemyBullets
            o->draw()
        for o in playerBullets
            o->draw()
        for o in enemyBases
            o->draw()
        for o in playerBases
            o->draw()
        for o in explosions
            o->draw()
        for o in celestial
            o->draw()

var 
    gameManager: GameManager? = null