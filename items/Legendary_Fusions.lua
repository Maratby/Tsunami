---Legendary Fusions only

SMODS.Joker {
	key = "tsunami_yu",
	rarity = "tsun_leg_fusion",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	no_aeq = true,
	config = { extra = { triggers = 1, count = 0, countmax = 6 } },
	atlas = "Tsunami",
	pos = { x = 3, y = 8 },
	soul_pos = { x = 3, y = 9 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.triggers, card.ability.extra.count, card.ability.extra.countmax } }
	end,
	calculate = function(self, card, context)
		if context.destroying_card then
			if context.destroying_card:is_face() and card_is_splashed(context.destroying_card) then
				card_eval_status_text(card, 'extra', nil, nil, nil,
					{ message = localize('k_yu_cut'), colour = G.C.tsun_pale })
				card.ability.extra.count = card.ability.extra.count + 1
				if card.ability.extra.count >= card.ability.extra.countmax then
					card_eval_status_text(card, 'extra', nil, nil, nil,
						{ message = localize('k_upgrade_ex'), colour = G.C.tsun_pale })
					card.ability.extra.count = card.ability.extra.count - card.ability.extra.countmax
					card.ability.extra.triggers = card.ability.extra.triggers + 1
				end
				return {
					remove = true
				}
			end
		end
		if context.repetition and context.cardarea == G.play then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra.triggers,
				card = card
			}
		end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_caino", nil, false, "j_tsun_tsunami_yu", 20)

SMODS.Joker {
	key = "tsunami_marie",
	rarity = "tsun_leg_fusion",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	no_aeq = true,
	config = { extra = 2 },
	atlas = "Tsunami",
	pos = { x = 4, y = 8 },
	soul_pos = { x = 4, y = 9 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra } }
	end,
	calculate = function(self, card, context)
		if context.other_joker then
			if (context.other_joker.config.center.mod and context.other_joker.config.center.mod.id == "Tsunami")
				or ((context.other_joker.config.center.key == "j_splash" or context.other_joker.config.center.key == "j_evo_ripple")) then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end
				}))
				return {
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra } },
					Xmult_mod = card.ability.extra,
					card = context.other_joker,
				}
			end
		end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_triboulet", nil, false, "j_tsun_tsunami_marie", 20)

SMODS.Joker {
	key = "tsunami_yosuke",
	rarity = "tsun_leg_fusion",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	no_aeq = true,
	config = { extra = { x_mult = 1, count = 0, countmax = 20, gain = 1 } },
	atlas = "Tsunami",
	pos = { x = 5, y = 8 },
	soul_pos = { x = 5, y = 9 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult, card.ability.extra.count, card.ability.extra.countmax, card.ability.extra.gain } }
	end,
	---moving stat to extra
	add_to_deck = function(self, card, from_debuff)
		if card.ability.extra.x_mult == 1 and card.ability.x_mult then
			card.ability.extra.x_mult = card.ability.x_mult
			card.ability.x_mult = nil
		end
	end,
	calculate = function(self, card, context)
		if context.before then
			for index, value in ipairs(G.play.cards) do
				if card_is_splashed(value) == true then
					card.ability.extra.count = card.ability.extra.count +
						(1 * math.max(0, G.GAME.current_round.discards_left))
					if card.ability.extra.count >= card.ability.extra.countmax then
						card_eval_status_text(card, 'extra', nil, nil, nil,
							{ message = localize('k_upgrade_ex'), colour = G.C.ATTENTION })
						card.ability.extra.x_mult = card.ability.extra.x_mult + 1
						card.ability.extra.count = card.ability.extra.count - card.ability.extra.countmax
					end
				end
			end
		end
		if context.joker_main and card.ability.extra.x_mult > 1 then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_yorick", "x_mult", false, "j_tsun_tsunami_yosuke", 20)

SMODS.Joker {
	key = "tsunami_rise",
	rarity = "tsun_leg_fusion",
	cost = 15,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	---Cryptid config things
	immutable = true,
	no_aeq = true,

	config = { extra = {
		last_buff = "None",
		random = "",
		money = 0,
		interval = 1,
		triggers = { Hearts = 0, Spades = 0, Diamonds = 0, Clubs = 0 },
		xmult_toggle = 0
	} },

	atlas = "Tsunami",
	pos = { x = 6, y = 8 },
	soul_pos = { x = 6, y = 9 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.last_buff, card.ability.extra.random } }
	end,
	calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.money
		if bonus > 0 then
			return bonus
		end
	end,
	calculate = function(self, card, context)
		if context.setting_blind and context.blind.boss and not self.getting_sliced and not context.blueprint then
			card.ability.extra.random = ""
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_rise_disable') })
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.blind:disable()
							play_sound('timpani')
							delay(0.4)
							return true
						end
					}))
					return true
				end
			}))

			if G.GAME.blind.config.blind.key == "bl_needle" then
				ease_hands_played(card.ability.extra.interval)
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_hand", vars = { card.ability.extra.interval } }
			elseif

				G.GAME.blind.config.blind.key == "bl_psychic" or
				G.GAME.blind.config.blind.key == "bl_final_bell" then
				G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + card.ability.extra.interval
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_psychic", vars = { card.ability.extra.interval } }
			elseif

				G.GAME.blind.config.blind.key == "bl_manacle" or
				G.GAME.blind.config.blind.key == "bl_fish" or
				G.GAME.blind.config.blind.key == "bl_mark" or
				G.GAME.blind.config.blind.key == "bl_wheel" or
				G.GAME.blind.config.blind.key == "bl_house" then
				G.hand:change_size(card.ability.extra.interval)
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_handsize", vars = { card.ability.extra.interval } }
			elseif

				G.GAME.blind.config.blind.key == "bl_tooth" or
				G.GAME.blind.config.blind.key == "bl_ox" then
				card.ability.extra.money = card.ability.extra.money + card.ability.extra.interval * 5
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_money", vars = { card.ability.extra.interval * 5 } }
			elseif

				G.GAME.blind.config.blind.key == "bl_water" or
				G.GAME.blind.config.blind.key == "bl_serpent" or
				G.GAME.blind.config.blind.key == "bl_hook" then
				ease_discard(card.ability.extra.interval)
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_discard", vars = { card.ability.extra.interval } }
			elseif

				G.GAME.blind.config.blind.key == "bl_final_leaf" or
				G.GAME.blind.config.blind.key == "bl_plant" or
				G.GAME.blind.config.blind.key == "bl_pillar" then
				card.ability.extra.xmult_toggle = card.ability.extra.xmult_toggle + card.ability.extra.interval
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_card_xmult", vars = { card.ability.extra.interval * 1.25 } }
			elseif G.GAME.blind.config.blind.key == "bl_wall" then
				ease_ante(-card.ability.extra.interval)
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_minus_ante", vars = { card.ability.extra.interval } }
			elseif G.GAME.blind.config.blind.key == "bl_final_vessel" then
				ease_ante(-card.ability.extra.interval)
				ease_ante_to_win(-card.ability.extra.interval)
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_minus_ante", vars = { card.ability.extra.interval } }
			elseif
				G.GAME.blind.config.blind.key == "bl_flint" or
				G.GAME.blind.config.blind.key == "bl_mouth" or
				G.GAME.blind.config.blind.key == "bl_eye" or
				G.GAME.blind.config.blind.key == "bl_arm" then
				local _hand, _tally = "High Card", 0
				for k, v in ipairs(G.handlist) do
					if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
						_hand = v
						_tally = G.GAME.hands[v].played
					end
				end
				for i = 1, card.ability.extra.interval do
					card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
						{ message = localize('k_level_up_ex') })
					update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
						{
							handname = localize(_hand, 'poker_hands'),
							chips = G.GAME.hands[_hand].chips,
							mult = G.GAME
								.hands[_hand].mult,
							level = G.GAME.hands[_hand].level
						})
					level_up_hand(context.blueprint_card or card, _hand, nil, 1)
					update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
						{ mult = 0, chips = 0, handname = '', level = '' })
				end
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_pokerhand", vars = { card.ability.extra.interval } }
			elseif
				G.GAME.blind.config.blind.key == "bl_head" then
				card.ability.extra.triggers.Hearts = card.ability.extra.triggers.Hearts + card.ability.extra.interval
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_retrigger_h", vars = { card.ability.extra.interval } }
			elseif
				G.GAME.blind.config.blind.key == "bl_goad" then
				card.ability.extra.triggers.Spades = card.ability.extra.triggers.Spades + card.ability.extra.interval
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_retrigger_s", vars = { card.ability.extra.interval } }
			elseif
				G.GAME.blind.config.blind.key == "bl_window" then
				card.ability.extra.triggers.Diamonds = card.ability.extra.triggers.Diamonds + card.ability.extra
					.interval
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_retrigger_d", vars = { card.ability.extra.interval } }
			elseif
				G.GAME.blind.config.blind.key == "bl_club" then
				card.ability.extra.triggers.Clubs = card.ability.extra.triggers.Clubs + card.ability.extra.interval
				card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_retrigger_c", vars = { card.ability.extra.interval } }
			elseif G.GAME.blind.config.blind.key == "bl_final_heart" then
				card.ability.extra.interval = card.ability.extra.interval * 2
				card.ability.extra.last_buff = localize("k_rise_final_heart")
			elseif G.GAME.blind.config.blind.key == "bl_final_acorn" then
				if #G.jokers.cards > 0 then
					local valid_cards = {}
					for i = 1, #G.jokers.cards do
						if G.jokers.cards[i].ability.name ~= "j_tsun_tsunami_rise" then
							table.insert(valid_cards, G.jokers.cards[i])
						end
					end
					if #valid_cards > 0 then
						G.E_MANAGER:add_event(Event({
							func = function()
								local rand_card = pseudorandom_element(valid_cards, pseudoseed('risette'))
								local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil,
									rand_card.config.center.key, nil)
								new_card:set_edition({ negative = true }, true)
								new_card:add_to_deck()
								G.jokers:emplace(new_card)
								new_card:start_materialize()
								return true
							end
						}))
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
							message = localize('k_plus_joker'),
							colour = G.C.DARK_EDITION,
						})
						card.ability.extra.last_buff = localize("k_rise_final_acorn")
					else
						card.ability.extra.last_buff = localize("k_rise_failed")
					end
				end
			else
				local randeffect = math.random(1, 8)
				if randeffect == 1 then
					ease_hands_played(card.ability.extra.interval)
					card.ability.extra.random = "Random Buff: "
					card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_hand", vars = { card.ability.extra.interval } }
				elseif randeffect == 2 then
					card.ability.extra.random = "Random Buff: "
					G.hand:change_size(card.ability.extra.interval)
					card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_handsize", vars = { card.ability.extra.interval } }
				elseif randeffect == 3 then
					card.ability.extra.random = "Random Buff: "
					ease_discard(card.ability.extra.interval)
					card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_discard", vars = { card.ability.extra.interval } }
				elseif randeffect == 4 then
					card.ability.extra.random = "Random Buff: "
					G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + card.ability.extra.interval
					card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_psychic", vars = { card.ability.extra.interval } }
				elseif randeffect == 5 then
					card.ability.extra.random = "Random Buff: "
					ease_ante(-card.ability.extra.interval)
					card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_minus_ante", vars = { card.ability.extra.interval } }
				elseif randeffect == 6 then
					card.ability.extra.random = "Random Buff: "
					card.ability.extra.money = card.ability.extra.money + (card.ability.extra.interval * 5)
					card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_money", vars = { card.ability.extra.interval * 5 } }
				elseif randeffect == 7 then
					card.ability.extra.random = "Random Buff: "
					card.ability.extra.xmult_toggle = card.ability.extra.xmult_toggle + card.ability.extra.interval
					card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_card_xmult", vars = { card.ability.extra.interval * 1.25 } }
				elseif randeffect == 8 then
					local _hand, _tally = "High Card", 0
					for k, v in ipairs(G.handlist) do
						if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
							_hand = v
							_tally = G.GAME.hands[v].played
						end
					end
					for i = 1, card.ability.extra.interval do
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = localize('k_level_up_ex') })
						update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
							{
								handname = localize(_hand, 'poker_hands'),
								chips = G.GAME.hands[_hand].chips,
								mult = G
									.GAME.hands[_hand].mult,
								level = G.GAME.hands[_hand].level
							})
						level_up_hand(context.blueprint_card or card, _hand, nil, 1)
						update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
							{ mult = 0, chips = 0, handname = '', level = '' })
					end
					card.ability.extra.random = "Random Buff: "
					card.ability.extra.last_buff = localize { type = "variable", key = "k_rise_pokerhand", vars = { card.ability.extra.interval } }
				end
			end
		end
		if context.repetition and context.cardarea == G.play then
			if context.other_card.ability_name == "Wild Card" then
				local triggersum =
					card.ability.extra.triggers.Hearts +
					card.ability.extra.triggers.Spades +
					card.ability.extra.triggers.Diamonds +
					card.ability.extra.triggers.Clubs
				return {
					message = localize('k_again_ex'),
					repetitions = triggersum,
					card = card
				}
			elseif context.other_card:is_suit("Hearts") and card.ability.extra.triggers.Hearts >= 1 then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.triggers.Hearts,
					card = card
				}
			elseif context.other_card:is_suit("Spades") and card.ability.extra.triggers.Spades >= 1 then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.triggers.Spades,
					card = card
				}
			elseif context.other_card:is_suit("Diamonds") and card.ability.extra.triggers.Diamonds >= 1 then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.triggers.Diamonds,
					card = card
				}
			elseif context.other_card:is_suit("Clubs") and card.ability.extra.triggers.Clubs >= 1 then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.triggers.Clubs,
					card = card
				}
			end
		end
		if context.individual and context.cardarea == G.play and card.ability.extra.xmult_toggle >= 1 then
			return {
				x_mult = card.ability.extra.interval * (1.25 * card.ability.extra.xmult_toggle),
				card = card
			}
		end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_chicot", nil, false, "j_tsun_tsunami_rise", 15)

SMODS.Joker {
	name = "Chie",
	key = "tsunami_chie",
	rarity = "tsun_leg_fusion",
	cost = 12,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	no_aeq = true,
	config = { extra = { copies = 2, odds = 3 } },
	atlas = "Tsunami",
	pos = { x = 7, y = 8 },
	soul_pos = { x = 7, y = 9 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
		return { vars = { card.ability.extra.copies, G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.ending_shop then
			---Using the code from Incantation's take_ownership patch for Perkeo if Incantation is loaded
			for i = 1, card.ability.extra.copies do
				if G.consumeables.cards[1] then
					G.E_MANAGER:add_event(Event({
						func = function()
							local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('godshand')),
								nil)
							card:set_edition({ negative = true }, true)
							card.ability.qty = 1
							card:add_to_deck()
							G.consumeables:emplace(card)
							return true
						end
					}))
					card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil,
						{ message = localize('k_duplicated_ex') })
				end
			end
			return { calculated = true }
		end
		if context.end_of_round and not context.game_over and context.cardarea ~= G.hand then
			if pseudorandom('chie') < G.GAME.probabilities.normal / card.ability.extra.odds and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
						local s_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'spec')
						s_card:add_to_deck()
						G.consumeables:emplace(s_card)
						G.GAME.consumeable_buffer = 0
						return true
					end)
				}))
				return {
					message = localize('k_plus_spectral'),
					colour = G.C.SECONDARY_SET.Spectral,
					card = card
				}
			elseif #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
						local t_card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil, 'chie')
						t_card:add_to_deck()
						G.consumeables:emplace(t_card)
						G.GAME.consumeable_buffer = 0
						return true
					end)
				}))
				return {
					message = localize('k_plus_tarot'),
					colour = G.C.SECONDARY_SET.Tarot,
					card = card
				}
			end
		end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_perkeo", nil, false, "j_tsun_tsunami_chie", 20)