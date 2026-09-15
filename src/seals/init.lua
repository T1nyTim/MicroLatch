local seal_files = {
    "amber",
    "aqua",
    "beige",
    "bronze",
    "copper",
    "cyan",
    "green",
    "grey",
    "indigo",
    "ivory",
    "lavender",
    "lime",
    "maroon",
    "orange",
    "pearl",
    "platinum",
    "rose",
    "silver",
    "teal",
    "white"
}

for _, name in ipairs(seal_files) do assert(SMODS.load_file("src/seals/" .. name .. ".lua"))() end
