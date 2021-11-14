var
    menuOffset: int
    menuPage: int
    mainMenu: bool
    helpMenu: bool
    pauseBeforeMenu: bool
    buyMenu: bool
    menuActive: bool

def init_menu_variables()
    pauseBeforeMenu = false
    helpMenu = false
    buyMenu = false
    mainMenu = false
    menuActive = false
    menuOffset = 0
    menuPage = 0