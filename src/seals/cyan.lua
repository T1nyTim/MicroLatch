SMODS.Seal {
    key = "cyan",
    atlas = "seal_atlas",
    pos = { x = 5, y = 0 },
    badge_colour = HEX("00FFFF"),
    loc_txt = {
        name = "Cyan Seal",
        label = "Cyan Seal",
        text = { "Creates the {C:planet}Planet{} card", "for the played hand when", "played but not scored", "{C:inactive}[Must have room]" }
    }
    --Effect managed by create_from_unscored_cards
}
