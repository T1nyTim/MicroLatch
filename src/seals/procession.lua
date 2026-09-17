local U = MICROLATCH.util

SMODS.Seal {
    key = "procession",
    atlas = "seal_atlas",
    pos = { x = 5, y = 3 },
    badge_colour = HEX("2F6FDB"),
    loc_txt = {
        name = "Procession Seal",
        label = "Procession Seal",
        text = { "Gives {C:chips}+16{} Chips for every", "sealed card scored before it" }
    },
    calculate = function(_, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local count = U.count(U.previous_scoring_cards(card, context), function(other) return not other.debuff and other.seal ~= nil end)
            if count > 0 then return { chips = count * 16 } end
        end
    end
}
