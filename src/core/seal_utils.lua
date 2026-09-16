local M = {}
local MOD_PREFIX = SMODS.current_mod.prefix

function M.active(card, name) return M.has(card, name) and not card.debuff end

function M.add_consumable(set_name, args)
    if not M.consumable_has_room() then return nil end
    args = args or {}
    args.set = set_name
    args.area = G.consumeables
    return SMODS.add_card(args)
end

function M.add_planet_for_hand(hand_name, key_append)
    local planet_key = M.find_planet_for_hand(hand_name)
    if not planet_key then return nil end
    return M.add_consumable("Planet", { key = planet_key, key_append = key_append or "microlatch_cyan" })
end

function M.clear_pending_draws() if G.GAME and G.GAME.microlatch then G.GAME.microlatch.pending_draws = 0 end end

function M.consumable_has_room()
    return G.consumeables and G.consumeables.cards and G.consumeables.config and #G.consumeables.cards < G.consumeables.config.card_limit
end

function M.contains(cards, target) return M.index_of(cards, target) ~= nil end

function M.find_planet_for_hand(hand_name)
    if not hand_name or not G.P_CENTER_POOLS or not G.P_CENTER_POOLS.Planet then return nil end
    for _, center in ipairs(G.P_CENTER_POOLS.Planet) do if center.config and center.config.hand_type == hand_name then return center.key end end
    return nil
end

function M.has(card, name) return card and card.seal == M.key(name) end

function M.index_of(cards, target)
    if not cards or not target then return nil end
    for i, card in ipairs(cards) do if card == target then return i end end
    return nil
end

function M.is_first_scored(card, context) return context.scoring_hand and context.scoring_hand[1] == card end

function M.is_last_scored(card, context) return context.scoring_hand and context.scoring_hand[#context.scoring_hand] == card end

function M.key(name) return MOD_PREFIX .. "_" .. name end

function M.queue_draws(amount)
    local state = M.state()
    state.pending_draws = state.pending_draws + (amount or 0)
end

function M.state()
    G.GAME.microlatch = G.GAME.microlatch or {}
    local state = G.GAME.microlatch
    state.pending_draws = state.pending_draws or 0
    return state
end

function M.take_pending_draws()
    local state = M.state()
    local amount = state.pending_draws or 0
    state.pending_draws = 0
    return amount
end

return M
