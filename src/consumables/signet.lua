SMODS.Consumable {
    key = "signet",
    set = "Spectral",
    atlas = "consumable_atlas",
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    loc_txt = { name = "Signet", text = { "Apply a {C:attention}random Seal{}", "to {C:attention}1{} selected card" }},
    can_use = function(_, _) return G.hand and G.hand.highlighted and #G.hand.highlighted == 1 end,
    use = function(_, _, _, _)
        local target = G.hand.highlighted[1]
        if not target then return end
        local seal = SMODS.poll_seal { guaranteed = true, key = "microlatch_signet", type_key = "microlatch_signet_type" }
        if seal then
            target:set_seal(seal, true, false)
            target:juice_up(0.3, 0.5)
        end
    end
}
