local U = MICROLATCH.util

SMODS.Seal {
    key = "kin",
    atlas = "seal_atlas",
    pos = { x = 0, y = 3 },
    badge_colour = HEX("FF4FA3"),
    loc_txt = { name = "Kin Seal", label = "Kin Seal", text = { "Gives {C:chips}+10{} Chips for each", "played card of the same rank" }},
    calculate = function(_, card, context)
        if context.main_scoring and context.cardarea == G.play and card.base then
            return { chips = 10 * U.count(context.full_hand, function(other) return other.base and other.base.value == card.base.value end) }
        end
    end
}
