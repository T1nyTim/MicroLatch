local U = MICROLATCH.util

SMODS.Seal {
    key = "choir",
    atlas = "seal_atlas",
    pos = { x = 3, y = 2 },
    badge_colour = HEX("A04BFF"),
    loc_txt = { name = "Choir Seal", label = "Choir Seal", text = { "Gives {C:chips}+12{} Chips", "for each sealed", "card played" }},
    calculate = function(_, _, context)
        if context.main_scoring and context.cardarea == G.play then
            return { chips = 12 * U.count(context.full_hand, function(card) return card.seal ~= nil end) }
        end
    end
}
