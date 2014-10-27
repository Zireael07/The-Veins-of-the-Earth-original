newTalentType{ passive=true, type="monk/monk", name="monk", description="Monk Feats" }

newTalent{
    name = "Wisdom AC bonus", short_name = "WISDOM_AC_MONK", --image = "talents/lay_on_hands.png",
    type = {"monk/monk", 1},
    mode = 'passive',
    points = 1,
--    is_feat = true,

    info = [[Your AC is increased by your Wisdom bonus.]],
    on_learn = function(self, t)
        --should be limited to being unarmored!!!!
        self.combat_untyped = self.combat_untyped or 0 + self:getWisMod()
    end,
}