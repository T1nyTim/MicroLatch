local U = MICROLATCH.util

local function selected_left_right()
    if not (G.hand and G.hand.highlighted and #G.hand.highlighted == 2) then return nil, nil end
    local a, b = G.hand.highlighted[1], G.hand.highlighted[2]
    local ia, ib = U.index_of(G.hand.cards, a), U.index_of(G.hand.cards, b)
    if not ia or not ib then return nil, nil end
    if ia < ib then return a, b end
    return b, a
end

SMODS.Consumable {
    key = "transference",
    set = "Tarot",
    atlas = "consumable_atlas",
    pos = { x = 3, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = false,
    loc_txt = { name = "Transference", text = { "Select {C:attention}2 cards{}, move", "the left card's Seal", "onto the right card" }},
    can_use = function(_, _)
        local left, right = selected_left_right()
        return left ~= nil and right ~= nil and left.seal ~= nil
    end,
    use = function(_, _, _, _)
        local left, right = selected_left_right()
        if not left or not right or not left.seal then return end
        local seal = left.seal
        left:set_seal(nil, true, false)
        right:set_seal(seal, true, false)
        left:juice_up(0.3, 0.5)
        right:juice_up(0.3, 0.5)
    end
}
