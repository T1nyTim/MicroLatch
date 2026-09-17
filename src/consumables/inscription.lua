G.FUNCS.ml_inscription_choice = function(e)
    local state = G.GAME and G.GAME.microlatch and G.GAME.microlatch.inscription
    local seal = e and e.config and e.config.ref_table and e.config.ref_table.seal
    if state and state.target and seal then
        state.target:set_seal(seal, true, false)
        state.target:juice_up(0.3, 0.5)
    end
    if G.GAME and G.GAME.microlatch then G.GAME.microlatch.inscription = nil end
    if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
end

G.FUNCS.ml_inscription_wait = function() end

local function seal_colour(key) return (G.P_SEALS and G.P_SEALS[key] and G.P_SEALS[key].badge_colour) or G.C.PURPLE end

local function seal_name(key) return localize({ type ="name_text", set = "Other", key = key }) end

local function open_choice_overlay(choices)
    local buttons = {}
    for _, seal in ipairs(choices) do
        buttons[#buttons + 1] = UIBox_button({
            label = { seal_name(seal) },
            button = "ml_inscription_choice",
            ref_table = { seal = seal },
            colour = seal_colour(seal),
            minw = 4.5,
            minh = 0.8,
            scale = 0.45,
            focus_args = { snap_to = true, nav = "wide" }
        })
    end
    G.FUNCS.overlay_menu({
        definition = create_UIBox_generic_options({
            back_func = "ml_inscription_wait",
            back_label = "Choose a Seal",
            no_pip = true,
            contents = {
                {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0.1 },
                    nodes = {{ n = G.UIT.T, config = { text = "Choose a Seal", scale = 0.55, colour = G.C.UI.TEXT_LIGHT, shadow = true }}}
                },
                { n = G.UIT.R, config = { align = "cm", padding = 0.1}, nodes = buttons }
            }
        })
    })
end

local function poll_choices()
    local choices, seen = {}, {}
    local tries = 0
    while #choices < 3 and tries < 30 do
        tries = tries + 1
        local seal = SMODS.pool_seal { guaranted = true, key = "microlatch_inscription_" .. tries, type_key = "microlatch_inscription_type" }
        if seal and not seen[seal] then
            seen[seal] = true
            choices[#choices + 1] = seal
        end
    end
    while #choices < 3 and choices[1] do choices[#choices + 1] = choices[1] end
    return choices
end

SMODS.Consumable {
    key = "inscription",
    set = "Spectral",
    atlas = "consumable_atlas",
    pos = { x = 2, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    loc_txt = {
        name = "Inscription",
        text = { "Choose {C:attention}1 in 3{} randomly", "offered Seals and apply", "it to {C:attention}1 selected card{}" }
    },
    can_use = function(_, _) return G.hand and G.hand.highlighted and #G.hand.highlighted == 1 end,
    use = function(_, _, _, _)
        local target = G.hand.highlighted[1]
        if not target then return end
        local choices = poll_choices()
        if #choices == 0 then return end
        local state = MICROLATCH.util.state()
        state.inscription = { target = target, choices = choices }
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.15,
            func = function()
                open_choice_overlay(choices)
                return true
            end
        }))
    end
}
