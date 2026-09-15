local U = MICROLATCH.util

local function create_from_destroyed_cards(context)
    if not context.removed then return end
    for _, removed_card in ipairs(context.removed) do
        if U.active(removed_card, "indigo") then U.add_consumable("Spectral", { key_append = "microlatch_indigo" }) end
    end
end

local function create_from_unscored_cards(context)
    if not context.full_hand or not context.scoring_hand then return end
    for _, played_card in ipairs(context.full_hand) do
        local unscored = not U.contains(context.scoring_hand, played_card)
        if unscored and U.active(played_card, "beige") then U.add_consumable("Tarot", { key_append = "microlatch_beige" }) end
        if unscored and U.active(played_card, "cyan") then U.add_planet_for_hand(context.scoring_name, "microlatch_cyan") end
    end
end

local function neighbour_repetitions(context)
    if not context.full_hand then return nil end
    local target = context.other_card or context.card
    if not target then return nil end
    local i = U.index_of(context.full_hand, target)
    if not i then return nil end
    local repetitions = 0
    local left = context.full_hand[i - 1]
    if left and U.active(left, "limt") then repetitions = repetitions + 1 end
    local right = context.full_hand[i + 1]
    if right and U.active(right, "teal") then repetitions = repetitions + 1 end
    if repetitions > 0 then return { repetitions = repetitions, message = localize("k_again_ex") } end
end

local function reset_copper_hand_state(full_hand)
    if not full_hand then return end
    for _, card in ipairs(full_hand) do
        if U.has(card, "copper") and card.ability and card.ability.seal then card.ability.seal.scored_this_hand = false end
    end
end

local function reset_copper_round_state()
    if not G.playing_cards then return end
    for _, card in ipairs(G.playing_cards) do
        if U.has(card, "copper") and card.ability and card.ability.seal then
            card.ability.seal.used_this_round = false
            card.ability.seal.scored_this_hand = false
        end
    end
end

SMODS.current_mod.calculate = function(_, context)
    if context.setting_blind then
        U.clear_pending_draws()
        reset_copper_round_state()
    end
    if context.before then
        create_from_unscored_cards(context)
        reset_copper_hand_state(context.full_hand)
    end
    if context.drawing_cards then
        local extra = U.take_pending_draws()
        if extra > 0 then return { modify = extra } end
    end
    if context.repetition and context.cardarea == G.play then
        local output = neighbour_repetitions(context)
        if output then return output end
    end
    if context.remove_playing_cards then create_from_destroyed_cards(context) end
    if context.end_of_round and context.main_eval then U.clear_pending_draws() end
end
