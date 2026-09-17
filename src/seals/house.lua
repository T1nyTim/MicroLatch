local U = MICROLATCH.util

SMODS.Seal {
    key = "house",
    atlas = "seal_atlas",
    pos = { x = 9, y = 2 },
    badge_colour = HEX("8A8D92"),
    loc_txt = { name = "House Seal", label = "House Seal", text = { "Earn {C:money}$4{} when scoring", "in a {C:attention}Full House{}" }},
    calculate = function(_, _, context)
        if context.main_scoring and context.cardarea == G.play and U.has_poker_hand(context, "Full House") then return { dollars = 4 } end
    end
}
