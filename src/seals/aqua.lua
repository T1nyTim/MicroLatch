SMODS.Seal {
    key = "aqua",
    atlas = "seal_atlas",
    pos = { x = 1, y = 0 },
    badge_colour = HEX("7DF9FF"),
    config = { numerator = 1, denominator = 3 },
    loc_txt = {
        name = "Aqua Seal",
        label = "Aqua Seal",
        text = { "{C:green}#1# in #2#{} chance to draw", "{C:attention}+1{} extra card next", "hand when scored" }
    },
    loc_vars = function(self, _, card)
        local trigger = card or self
        local n, d = SMODS.get_probability_vars(trigger, self.config.numerator, self.config.denominator, "microlatch_aqua")
        return { vars = { n, d }}
    end,
    calculate = function(self, card, context)
        if context.main_scoring
            and context.cardarea == G.play
            and SMODS.pseudorandom_probability(card, "microlatch_aqua", self.config.numerator, self.config.denominator, "microlatch_aqua")
        then
            MICROLATCH.util.queue_draws(1)
            return { message = "+1 draw", colour = G.C.BLUE }
        end
    end
    --Clean-up Effect managed by clear_pending_draws
}
