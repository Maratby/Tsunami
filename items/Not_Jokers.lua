---Literally for anything that is not a joker

SMODS.Voucher {
	key = "water_supply",
	cost = 5,
	discovered = true,
	unlocked = true,
	pos = { x = 0, y = 0 },
	atlas = "TsunamiVoucher",
	config = { rarity = 1, extra = { splash = 2 } },
	requires = {},
	loc_vars = function(self, info_queue)
		return { vars = { self.config.extra.splash } }
	end,
	redeem = function(self)
		for i = 1, self.config.extra.splash do
			create_splash("e_negative")
		end
	end
}

SMODS.Voucher {
	key = "water_source",
	cost = 15,
	discovered = true,
	unlocked = true,
	pos = { x = 0, y = 1 },
	atlas = "TsunamiVoucher",
	config = { rarity = 2, extra = { splash = 1 } },
	requires = { "v_tsun_water_supply" },
	loc_vars = function(self, info_queue)
		return { vars = { self.config.extra.splash } }
	end,
	redeem = function(self)
		for i = 1, self.config.extra.splash do
			local splashvoucher = SMODS.create_card({
				area = G.jokers,
				key = pseudorandom_element(Splashvouchertable,
					pseudoseed('splashvoucher'))
			})
			splashvoucher:add_to_deck()
			G.jokers:emplace(splashvoucher)
		end
	end
}

SMODS.Consumable {
	key = 'aeon',
	set = 'Tarot',
	pos = { x = 0, y = 0 },
	atlas = "TsunamiTarot",
	name = "tsunamiaeon",
	discovered = true,
	cost = 2,
	config = { extra = 2 },
	can_use = function(self, card)
		return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
	end,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_splash
		return {}
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				if #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers then
					create_splash()
					if AeonDoubleSplash == true then
						create_splash()
					end
					used_consumable:juice_up(0.3, 0.5)
				end
				return true
			end,
		}))
		delay(0.6)
	end,
}

SMODS.Consumable {
	key = 'poly',
	set = 'Spectral',
	pos = { x = 0, y = 1 },
	atlas = "TsunamiTarot",
	name = "tsunamipoly",
	discovered = true,
	cost = 8,
	config = { extra = { handsize = 1 } },
	loc_vars = function(self, info_queue)
		return { vars = { G.GAME.poly_minus or 1 } }
	end,
	can_use = function(self, card)
		return #G.jokers.cards < (G.jokers.config.card_limit - 1) or card.area == G.jokers
	end,
	can_bulk_use = false,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				if #G.jokers.cards < (G.jokers.config.card_limit - 1) or card.area == G.jokers then
					play_sound("timpani")
					create_splash()
					local splashspectral2 = SMODS.create_card({
						area = G.jokers,
						key = pseudorandom_element(
							Splashkeytable2, pseudoseed('splashjoker'))
					})
					splashspectral2:add_to_deck()
					G.jokers:emplace(splashspectral2)
					used_consumable:juice_up(0.3, 0.5)
					if Tsunami_Config.PolyHandScale == true then
						G.GAME.poly_minus = G.GAME.poly_minus or 1
						G.hand:change_size(-G.GAME.poly_minus)
						G.GAME.poly_minus = G.GAME.poly_minus + 1
						self.config.extra.handsize = G.GAME.poly_minus
					else
						self.config.extra.handsize = 1
						G.hand:change_size(-card.ability.extra.handsize)
					end
				end
				return true
			end,
		}))
		delay(0.6)
	end,
}

SMODS.Back {
	key = "splashdeck",
	pos = { x = 0, y = 0 },
	unlocked = true,
	discovered = true,
	config = { dollars = 5 },
	atlas = "TsunamiDecks",
	loc_vars = function(self)
		return { vars = { self.config.extra } }
	end,
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				create_splash("e_negative", true)
				create_splash("e_negative", true)
				return true
			end
		}))
	end
}

SMODS.Back {
	key = "floatiedeck",
	pos = { x = 1, y = 0 },
	unlocked = true,
	discovered = true,
	config = { hands = 1, discards = 1, hand_size = 2, joker_slot = 2, extra = { win_ante = 8 } },
	atlas = "TsunamiDecks",
	loc_vars = function(self)
		return { vars = { self.config.hands, self.config.joker_slot, self.config.extra.win_ante } }
	end,
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.win_ante = G.GAME.win_ante + self.config.extra.win_ante
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.config.joker_slot
				return true
			end
		}))
	end
}

SMODS.Tag {
	key = "bubble",
	atlas = "TsunamiTag",
	pos = { x = 0, y = 0 },
	name = "Bubble Tag",
	discovered = true,
	min_ante = 0,
	config = {},
	apply = function(self, tag, _context)
		if _context.type == "immediate" then
			tag:yep('+', G.C.BLUE, function()
				return true
			end)
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
			card:add_to_deck()
			card:set_edition(poll_edition("bubble", nil, true, true, { "e_foil", "e_holo", "e_polychrome" }))
			G.jokers:emplace(card)
			tag.triggered = true
			return true
		end
	end
}

tsun_nonjokeritems = {
	"aeon",
	"polymorph",
	"voucher",
	"bubble",
}
---num = number of items to craete. override = specific item to create, leave blank for random, _negative is boolean. "aeon", "polymorph", "voucher","bubble"
function tsun_create_items(num, override, _negative)
	local item
	local items_made = 0
	local attempts = 0
	while items_made < num and attempts < 100 do
		---Attempts is a failsafe to avoid softlocks. Will only try 100 times to make cards, after that it fails.
		---Technically speaking, if you use SDM_0's Deck of Stuff and the Splash Sleeve, and roll "voucher" 100 times,
		---it is possible to activate the failsafe in a real run. Good luck!
		attempts = attempts + 1
		if override == nil then
			item = pseudorandom_element(tsun_nonjokeritems, pseudoseed('STILL YOUR HEART IS BLAZING'))
		else
			item = override
		end
		if item == "aeon" then
			local card = SMODS.create_card({
				area = G.consumeables,
				key = "c_tsun_aeon"
			})
			if _negative then
				card:set_edition({ negative = true }, nil)
			end
			card:add_to_deck()
			G.consumeables:emplace(card)
			items_made = items_made + 1
		elseif item == "polymorph" then
			local card = SMODS.create_card({
				area = G.consumeables,
				key = "c_tsun_poly"
			})
			if _negative then
				card:set_edition({ negative = true }, nil)
			end
			card:add_to_deck()
			G.consumeables:emplace(card)
			items_made = items_made + 1
		elseif item == "voucher" then
			local local_voucher = "no"
			if not G.GAME.used_vouchers.v_tsun_water_supply then
				tsun_redeem_voucher("v_tsun_water_supply", 0.3)
				items_made = items_made + 1
			elseif not G.GAME.used_vouchers.v_tsun_water_source then
				tsun_redeem_voucher("v_tsun_water_source", 0.3)
				items_made = items_made + 1
			else
				---Do nothing
			end
		elseif item == "bubble" then
			add_tag(Tag("tag_tsun_bubble"))
			items_made = items_made + 1
		end
	end
end
