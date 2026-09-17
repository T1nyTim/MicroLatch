local U = MICROLATCH.util

SMODS.Consumable {
    key = "seal_press",
    set = "Spectral",
    atlas = "consumable_atlas",
    pos = { x = 1, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    loc_txt = { name = "Seal Press", text = { "Apply a {C:attention}random Seal{} up to", "{C:attention}3 random cards{} in hand" }},
    can_use = function(_, _) return G.hand and G.hand.cards and #G.hand.cards > 0 end,
    use = function(_, _, _, _)
        local pool = {}
        for _, card in ipairs(G.hand.cards) do pool[#pool + 1] = card end
        for i = 1, math.min(3, #pool) do
            local target = pseudorandom_element(pool, pseudoseed("microlatch_seal_press_card_" .. i))
            if target then
                table.remove(pool, U.index_of(pool, target))
                local seal = SMODS.pool_seal { guaranted = true, key = "microlatch_seal_press_" .. i, type_key = "microlatch_seal_press_type" }
                if seal then
                    target:set_seal(seal, true, false)
                    target:juice_up(0.3, 0.5)
                end
            end
        end
    end
}
