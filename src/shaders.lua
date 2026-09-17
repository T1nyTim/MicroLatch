MICROLATCH = MICROLATCH or {}

local PALETTES = {
    bronze = { colours = { HEX("CD5700"), HEX("CBA135"), HEX("DAA06D"), HEX("E8AC41") }, speed = 0.75, width = 0.65, strength = 0.7 },
    pearl = { colours = { HEX("B0B7BE"), HEX("E9D4C3"), HEX("F0DFCC"), HEX("F8F6F0") }, speed = 0.55, width = 0.85, strength = 0.48 },
    platinum = { colours = { HEX("D4D8DA"), HEX("D1E2E8"), HEX("D3E5EF"), HEX("F0F3F5") }, speed = 0.8, width = 0.7, strength = 0.62 },
    silver = { colours = { HEX("E1E1E1"), HEX("E0E3E9"), HEX("E2E7E9"), HEX("E3E9F0") }, speed = 0.9, width = 0.65, strength = 0.65 }
}

local metallic_shader

metallic_shader = SMODS.Shader {
    key = "metallic_seal",
    path = "metallic_seal.fs",
    send_vars = function(sprite)
        local p = sprite._microlatch_metallic_palette
        if not p then return {} end
        return {
            u_time = G.TIMERS.REAL,
            shine_speed = p.speed,
            shine_width = p.width,
            shine_strength = p.strength,
            shine_1 = p.colours[1],
            shine_2 = p.colours[2],
            shine_3 = p.colours[3],
            shine_4 = p.colours[4]
        }
    end
}

local function draw_metallic_seal(self, card, _)
    local sprite = G.shared_seals[self.key]
    if not sprite then return end
    local palette = PALETTES[self.original_key]
    if not palette then return end
    sprite._microlatch_metallic_palette = palette
    sprite.role.draw_major = card
    sprite:draw_shader(metallic_shader.key, nil, nil, nil, card.children.center, nil, nil, nil, nil, true)
end

for _, seal in pairs(SMODS.Seals) do if PALETTES[seal.original_key] then seal.draw = draw_metallic_seal end end
