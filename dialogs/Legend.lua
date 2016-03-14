--Veins of the Earth
--Zireael

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"


module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    Dialog.init(self, "Legend", game.w * 0.5, game.h * 0.5)

    self.text=[[
    The legend applies only to ASCII mode.


     @ player
    Monsters
    a  animal
    b bat / bird
    c
    d dog
    e eye creature
    f faerie creature
    g goblinkin
    h humanoid
    i imp
    j jelly/ooze
    k kobold
    l lycanthrope
    m mimic
    n naga
    o orc
    q quadruped
    r rodent
    s spider
    t trapper
    u hag
    v vermin
    w worm
    x
    y snake-men
    z snake


    A celestial
    B beast
    C construct
    D dragon
    E elemental
    F fungus
    G golem
    H giant
    I
    J djinn/genie
    K elementalkin /weirds
    L lich
    M mephit
    N spectral undead
    O outsider
    P plant
    Q swarm
    R reptile
    S skeleton
    T troll
    U corporeal undead
    V vampire
    W wraith/shadow
    X aberration
    Y hominid /monkey
    Z zombie
    ü - lesser demon
    ū  - greater demon
    ǒ - lesser devil
    ō - greater devil

    Items
    = a belt
    σ a ring
    ♂ an amulet
    ♠ a cloak
    Д greaves
    ω boots
    Ξ bracers
    - a wand
    ? a scroll
    ¡ a potion
    ~ torch
    ℸ girdle
    ₵ helm
    ϴ stone

    $ money
    % food or corpse
    ! drink

    ( light armor
    ] medium armor
    [ heavy armor
    ) shield

    / polearms
    | edged weapon
    \ hafted weapon
    } launcher
    { ammo






]]

    self.c_desc = Textzone.new{width=self.iw, height=self.ih, scrollbar=true, text = self.text}


    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
    }
    self:setupUI(false, true)

    self:setFocus(self.c_desc)
    self.key:addBinds{
        EXIT = function() game:unregisterDialog(self) end,
    }
end
