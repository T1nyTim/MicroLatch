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
    local source_card = nil
    local left = context.full_hand[i - 1]
    if left and U.active(left, "lime") then
        repetitions = repetitions + 1
        source_card = left
    end
    local right = context.full_hand[i + 1]
    if right and U.active(right, "teal") then
        repetitions = repetitions + 1
        source_card = right
    end
    if repetitions > 0 then return { repetitions = repetitions, message = localize("k_again_ex"), message_card = source_card } end
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

local function return_copper_cards(context)
    if not context.stay_flipped or context.from_area ~= G.play or not context.other_card then return end
    local card = context.other_card
    if U.active(card, "copper") and card.ability.seal.scored_this_hand and not card.ability.seal.used_this_round then
        card.ability.seal.used_this_round = true
        card.ability.seal.scored_this_hand = false
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0,
            blockable = false,
            func = function()
                if card.area ~= G.hand then return false end
                card.ability.wheel_flipped = nil
                card.facing = "front"
                card.sprite_facing = "front"
                card.flipping = nil
                return true
            end
        }))
        return { modify = { to_area = G.hand }, prevent_stay_flipped = true, message = "Returned!" }
    end
end

SMODS.current_mod.calculate = function(_, context)
    if context.setting_blind then
        U.clear_pending_draws()
        reset_copper_round_state()
    end
    if context.before then reset_copper_hand_state(context.full_hand) end
    if context.drawing_cards then
        local extra = U.take_pending_draws()
        if extra > 0 then return { cards_to_draw = context.amount + extra } end
    end
    if context.repetition and context.cardarea == G.play then
        local output = neighbour_repetitions(context)
        if output then return output end
    end
    if context.after and context.main_eval then
        local copper_return = return_copper_cards(context)
        if copper_return then return copper_return end
        local saved_context = {
            full_hand = context.full_hand,
            scoring_hand = context.scoring_hand,
            scoring_name = context.scoring_name,
            poker_hands = context.poker_hands
        }
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0,
            func = function()
                create_from_unscored_cards(saved_context)
                return true
            end
        }))
    end
    if context.remove_playing_cards then create_from_destroyed_cards(context) end
    if context.end_of_round and context.main_eval then U.clear_pending_draws() end
end
