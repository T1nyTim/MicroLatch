local U = MICROLATCH.util

SMODS.Seal {
    key = "commoner",
    atlas = "seal_atlas",
    pos = { x = 4, y = 2 },
    badge_colour = HEX("A66A3F"),
    loc_txt = { name = "Commoner Seal", label = "Commoner Seal", text = { "Gives {C:chips}+30{} Chips if", "scored with no face cards" }},
    calculate = function(_, _, context)
        if context.main_scoring and context.cardarea == G.play and U.all(context.scoring_hand, function(card) return not card:is_face() end) then
            return { chips = 30 }
        end
    end
}
