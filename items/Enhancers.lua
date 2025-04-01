--- Enhancement Gaming

SMODS.Enhancement({
    name = "Waterproof",
    key = "waterproof",
    badge_colour = HEX("CC0000"),
    config = { extra = 1.5 },
    weight = 3,
    atlas = "TsunamiEnhancers",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_splash
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			if card_is_splashed(card) then
				return {
					x_chips = card.ability.extra
				}
			end
		end
    end,
})

SMODS.Consumable {
    set = "Tarot",
    name = "Flood",
    key = "flood",
    pos = { x = 1, y = 0 },
    config = { mod_conv = "m_tsun_waterproof", max_highlighted = 2 },
    atlas = "TsunamiTarot",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_tsun_waterproof
        return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
    end,
}