MICROLATCH = MICROLATCH or {}

SMODS.Atlas {
    key = "seal_atlas",
    path = "seals.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "consumable_atlas",
    path = "consumables.png",
    px = 71,
    py = 95
}

MICROLATCH.util = assert(SMODS.load_file("src/core/seal_utils.lua"))()
assert(SMODS.load_file("src/seals/init.lua"))()
assert(SMODS.load_file("src/shaders.lua"))()
assert(SMODS.load_file("src/consumables/signet.lua"))()
assert(SMODS.load_file("src/core/seal_runtime.lua"))()
