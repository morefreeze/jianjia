
-- 默认开启物理和光照

return {

pcmiao = {
    prop = {
        Size = {1.9, 2.595},
        Position = {-13, -9},
        SpriteFrame = {{"Resources/Images/ch/PC01.png", 0}, {"Resources/Images/ch/PC02.png", 1}},
    },
    rchat = {
        {0, {{'PC喵', '喵！来抱抱！'}}},
        {0, {{'PC喵', '打滚……有点困……'}}},
        {0, {{'PC喵', '今天天气好好的呀，来发个呆吧嗯！'}}},
    },
},

pcmiao_hi = {
    prop = {
        Size = {2,8},
        Position = {-13, -15},
        Alpha = 0,
        PhyNewFixture = {101, true},
    },
    nophy = true,
},

uu = {
    prop = {
        Size = {3.80*4/5, 3.125*4/5},
        Position = {26, -13},
        SpriteFrame = {{"Resources/Images/ch/uu01.png", 0}, {"Resources/Images/ch/uu02.png", 1}, {"Resources/Images/ch/uu03.png", 2}},
    },
    rchat = {
        {0, {{'码头钓鱼者 UU', '哎，这里鱼都被我钓光了，怎么我的翅膀就不上钩了呢？'}}},
        {0, {{'码头钓鱼者 UU', '最近村里的猪肉好吃么？都是我从河里钓上来的耶！'}}},
        {0, {{'码头钓鱼者 UU', '哼，经过我的努力，我终于在河里钓上猪了，只要努力我坚信水坑也可以钓回我的翅膀！！'}}},
        {0, {{'码头钓鱼者 UU', '你知道为什么那么多人为one piece疯狂么？我前几年就钓到了，嘘~~~小声点。'}}},
        {0, {{'码头钓鱼者 UU', '你见过传说中的one piece么？如果你能帮我找回双翼，我会把它送给你的。'}}},
    },
},

}
