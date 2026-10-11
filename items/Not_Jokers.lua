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
		return (G.jokers.highlighted ~= nil and #G.jokers.highlighted > 0 and Tsunami.count_splash(G.jokers.highlighted)) or ((get_current_deck_fallback() == "b_fuseforce_minusdeck" or get_current_deck_fallback() == "b_sdm_deck_of_stuff") and #G.jokers.highlighted == 0)
	end,
	can_bulk_use = false,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local numhighlight = Tsunami.count_highlight()
		local selected = "j_splash"
		Tsunami.poly_achievement_check = numhighlight
		for index, value in ipairs(G.jokers.highlighted) do
			---remove stickers before destroying, i'm looking at you Cryptid Absolute
			Tsunami.Stickerclear(value)
			SMODS.destroy_cards(value)
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				if (get_current_deck_fallback() == "b_fuseforce_minusdeck" or get_current_deck_fallback() == "b_sdm_deck_of_stuff") and numhighlight == 0 and G.GAME.minus_splash_sleeve_active == true then
					SMODS.add_card({
						key = "j_splash",
						edition = "e_negative",
					})
					return true
				end
				local abort_tally = 0
				local finished_flag = false
				local edition_flag = false
				local negative_flag = false
				if numhighlight >= 20 and Tsunami_Config.TsunamiLevel2 and Tsunami_Config.LegendFusions then
					while finished_flag == false do
						selected = pseudorandom_element(Tsunami.splash_materials, "RE-TUNED")
						if selected.rarity == "tsun_leg_fusion" then
							finished_flag = true
						end
					end
				elseif numhighlight >= 15 and Tsunami_Config.LegendFusions then
					while finished_flag == false do
						selected = pseudorandom_element(Tsunami.splash_materials, "WAITING")
						if selected.rarity == 4 then
							finished_flag = true
							if numhighlight >= 18 then
								negative_flag = true
							elseif numhighlight >= 16 then
								edition_flag = true
							end
						end
					end
				elseif numhighlight >= 10 and Tsunami_Config.TsunamiLevel2 then
					while finished_flag == false do
						selected = pseudorandom_element(Tsunami.splash_materials, "FAMILIAR")
						if selected.rarity == "fusion" or selected.rarity == "fuse_fusion" then
							finished_flag = true
							if numhighlight >= 13 then
								negative_flag = true
							elseif numhighlight >= 11 then
								edition_flag = true
							end
						end
					end
				elseif numhighlight >= 5 then
					while finished_flag == false do
						selected = pseudorandom_element(Tsunami.splash_materials, "DIALTONE")
						if selected.rarity == 3 then
							finished_flag = true
							if numhighlight >= 8 then
								negative_flag = true
							elseif numhighlight >= 6 then
								edition_flag = true
							end
						end
					end
				elseif numhighlight >= 3 then
					print("3 or more")
					while finished_flag == false do
						selected = pseudorandom_element(Tsunami.splash_materials, "MEMORIZED")
						if selected.rarity == 2 then
							finished_flag = true
							if numhighlight >= 4 then
								edition_flag = true
							end
						end
					end
				else
					print("less than 3")
					while finished_flag == false do
						selected = pseudorandom_element(Tsunami.splash_materials, "YEAH YEAH YEAH YEAH YEAH YEAH YEAH")
						if selected.rarity == 1 then
							finished_flag = true
							if numhighlight >= 2 then
								print("2")
								edition_flag = true
							end
						end
					end
				end
				if negative_flag == true then
					local LONER = SMODS.add_card({
						key_append = "tsun_polynorph",
						key = selected.key,
					})
					LONER:set_edition("e_negative", true)
				elseif edition_flag == true then
					local SLEEPING_IN = SMODS.add_card({
						key_append = "tsun_polynorph",
						key = selected.key,
					})
					---tell me if you read this
					SLEEPING_IN:set_edition(poll_edition("NO SIGNAL", nil, true, true,
						{ "e_foil", "e_holo", "e_polychrome" }))
				else
					SMODS.add_card({
						key_append = "tsun_polynorph",
						key = selected.key,
					})
				end
				check_for_unlock { type = "tsunami_polymorph" }
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
