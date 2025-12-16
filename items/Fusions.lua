---Just Joker fusions

SMODS.Joker {
	key = "splish_splash",
	rarity = "fusion",
	cost = 16,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "Tsunami",
	pos = { x = 1, y = 12 },
	ability_name = "Splish Splash",
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_splash
		return {}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			local splishcard = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
			splishcard:add_to_deck()
			G.jokers:emplace(splishcard)
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_riff_raff" },
    { name = "j_splash" },
  }, cost = 6, result_joker = "j_tsun_splish_splash" 
}

SMODS.Joker {
	key = "soaked_joker",
	name = "Soaked Joker",
	atlas = "Tsunami",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = { x = 7, y = 0 },
	cost = 16,
	config = { extra = { mult = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) == true then
				return {
					mult = card.ability.extra.mult,
					card = card
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_half" },
    { name = "j_splash" },
  }, cost = 8, result_joker = "j_tsun_soaked_joker" 
}

SMODS.Joker {
	key = 'holy_water',
	atlas = "Tsunami",
	pos = { x = 2, y = 0 },
	cost = 12,
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	config = { mult = 12 },
	remove_from_deck = function(self, card, from_debuff)
		G.hand:unhighlight_all()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands['Pair']) then
			return {
				mult = card.ability.mult
			}
		end
	end,
}
---Logic loop for Holy Water code
local athr = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
	if self.config.type ~= 'shop' and self.config.type ~= 'joker' and self.config.type ~= 'consumeable' and (#SMODS.find_card("j_tsun_holy_water") >= 1 or #SMODS.find_card("j_tsun_gold_holy_water") >= 1) then
		local id = card:get_id()
		local matches = 0
		for i = 1, #self.highlighted do
			if self.highlighted[i]:get_id() == id then
				matches = matches + 1
			end
		end
		if matches == 1 then
			self.highlighted[#self.highlighted + 1] = card
			card:highlight(true)
			if not silent then play_sound('cardSlide1') end
			self:parse_highlighted()
			return
		end
	end
	athr(self, card, silent)
end

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = 'j_splash' },
    { name = 'j_jolly' },
  }, cost = 8, result_joker = 'j_tsun_holy_water' 
}

SMODS.Joker {
	key = "oil_spill",
	name = "Oil Spill",
	atlas = "Tsunami",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = { x = 6, y = 2 },
	cost = 16,
	config = { extra = { min = 0, max = 13 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.min, card.ability.extra.max } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) == true then
				return {
					mult = pseudorandom("balls", card.ability.extra.min, card.ability.extra.max),
					card = card
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_misprint" },
    { name = "j_splash" },
  }, cost = 8, result_joker = "j_tsun_oil_spill" 
}

SMODS.Joker {
	key = "vending_machine",
	rarity = "fusion",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { xmult = 10, fails = 0, odds = 10 } },
	atlas = "Tsunami",
	pos = { x = 4, y = 2 },
	loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
			'tsun_vending_machine')
		return { vars = { card.ability.extra.xmult, card.ability.extra.fails, new_numerator, new_denominator } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) then
				card.ability.extra.fails = card.ability.extra.fails + 1
				if card.ability.extra.fails >= card.ability.extra.xmult or SMODS.pseudorandom_probability(card, 'monseiur', 1, card.ability.extra.odds, 'tsun_vending_machine') then
					card.ability.extra.fails = 0
					return {
						x_mult = card.ability.extra.xmult,
						card = card
					}
				end
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_loyalty_card" },
    { name = "j_splash" },
  }, cost = 7, result_joker = "j_tsun_vending_machine" 
}

SMODS.Joker {
	key = "waterfront_scenery",
	name = "Waterfront Scenery",
	atlas = "Tsunami",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = { x = 2, y = 13 },
    pixel_size = { h = 95 / 1.2 },
	cost = 16,
	config = { extra = { xmult = 2, modifier = 0.5, tally = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult,card.ability.extra.modifier } }
	end,
	calculate = function(self, card, context)
		if context.before then
			card.ability.extra.tally = 0
			for index, value in ipairs(G.play.cards) do
				if card_is_splashed(value) then
					card.ability.extra.tally = card.ability.extra.tally + 1
				end
			end
		end
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            local is_first_face = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    is_first_face = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if is_first_face then
                return {
                    xmult = card.ability.extra.xmult + (card.ability.extra.tally * card.ability.extra.modifier)
                }
            end
        end
    end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_photograph" },
    { name = "j_splash" },
  }, cost = 14, result_joker = "j_tsun_waterfront_scenery" 
}

SMODS.Joker {
	key = "magical_waterfall",
	name = "Magical Waterfall",
	atlas = "Tsunami",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	pos = { x = 2, y = 2 },
	cost = 18,
	config = { extra = { base_mult = 10, increase = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.base_mult, card.ability.extra.increase, card.ability.extra.base_mult / math.max((G.GAME.current_round.discards_left or 1), 1) } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) == true then
				card.ability.extra.base_mult = card.ability.extra.base_mult + card.ability.extra.increase
			end
		end
		if context.joker_main then
			local tempmult = card.ability.extra.base_mult
			if G.GAME.current_round.discards_left ~= 0 then
				tempmult = card.ability.extra.base_mult / G.GAME.current_round.discards_left
				if Tsunami_Config.TsunRounding then
					tempmult = math.floor(tempmult + 0.5)
				end
			end
			return {
				mult = tempmult,
				card = card
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = 'j_splash' },
    { name = 'j_mystic_summit' },
  }, cost = 11, result_joker = 'j_tsun_magical_waterfall' 
}

SMODS.Joker {
	key = "smart_water",
	name = "Smart Water",
	atlas = "Tsunami",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = { x = 0, y = 4 },
	cost = 16,
	config = { extra = { mult = 5, chips = 30, xmult = 1.2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14
				and context.other_card.config.center ~= G.P_CENTERS.c_base
				and not context.other_card.debuff
				and not context.other_card.vampired then
				return {
					mult = card.ability.extra.mult,
					chips = card.ability.extra.chips,
					xmult = card.ability.extra.xmult,
					card = card
				}
			elseif context.other_card:get_id() == 14 and not context.other_card.debuff then
				return {
					mult = card.ability.extra.mult,
					chips = card.ability.extra.chips,
					card = card
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_scholar" },
    { name = "j_splash" },
  }, cost = 11, result_joker = "j_tsun_smart_water" 
}

local rb_resetflag
SMODS.Joker {
	key = "ride_the_sub",
	name = "Ride the Sub",
	atlas = "Tsunami",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = { x = 1, y = 6 },
	cost = 16,
	config = { mult = 0, increase = 2 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.mult, card.ability.increase } }
	end,
	calculate = function(self, card, context)
		if context.before then
			rb_resetflag = false
		end
		if context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) == true then
				card.ability.mult = 0
				rb_resetflag = true
			end
		end
		if context.joker_main and rb_resetflag == false then
			card.ability.mult = card.ability.mult + 2
			return {
				mult = card.ability.mult
			}
		elseif context.joker_main and rb_resetflag == true then
			return {
				card = card,
				message = localize('k_reset')
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_ride_the_bus", carry_stat = "mult" },
    { name = "j_splash" },
  }, cost = 8, result_joker = "j_tsun_ride_the_sub" 
}

SMODS.Joker {
	key = "raft",
	name = "Raft",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 0, y = 11 },
	cost = 16,
	config = { extra = 5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra } }
	end,
	ability_name = "raft",
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
			context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra
			card_eval_status_text(context.other_card, 'extra', nil, nil, nil,
				{ message = localize('k_upgrade_ex'), colour = G.C.CHIPS })

			if card_is_splashed(context.other_card) == true then
				context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
				context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra
				return {
					extra = { message = "Raft!", colour = G.C.CHIPS },
					colour = G.C.CHIPS,
					card = card
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_hiker" },
  }, cost = 10, result_joker = "j_tsun_raft" 
}

SMODS.Joker {
	name = "Beach Ball",
	config = { extra = { odds = 3 } },
	loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'identifier')
		return { vars = { new_numerator, new_denominator } }
	end,
	rarity = "fusion",
	cost = 17,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	key = "beach_ball",
	atlas = "Tsunami",
	pos = { x = 0, y = 5 },
	ability_name = "Beach Ball",
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and SMODS.pseudorandom_probability(card, 'penile', 1, card.ability.extra.odds, 'tsun_beach_ball') then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				local tarotcards = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'tar')
				tarotcards:add_to_deck()
				G.consumeables:emplace(tarotcards)
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_8_ball" },
  }, cost = 8, result_joker = "j_tsun_beach_ball" 
}

SMODS.Joker {
	key = "dihydrogen_monoxide",
	rarity = "fusion",
	cost = 16,
	config = { extra = { mult = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "Tsunami",
	pos = { x = 1, y = 5 },
	ability_name = "Dihydrogen Monoxide",
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and
			(context.other_card:get_id() == 2 or
				context.other_card:get_id() == 3 or
				context.other_card:get_id() == 5 or
				context.other_card:get_id() == 8 or
				context.other_card:get_id() == 14) then
			local fibsequence = 0
			for k, v in ipairs(context.scoring_hand) do
				if (v:get_id() == 2 or
						v:get_id() == 3 or
						v:get_id() == 5 or
						v:get_id() == 8 or
						v:get_id() == 14) then
					fibsequence = fibsequence + 1
				end
			end
			return {
				mult = card.ability.extra.mult * fibsequence,
				card = card
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_fibonacci" },
  }, cost = 13, result_joker = "j_tsun_dihydrogen_monoxide" 
}

SMODS.Joker {
	key = "lunar_tides",
	rarity = "fusion",
	cost = 13,
	config = { extra = { mult = 8, xmult = 1.3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xmult } }
	end,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "Tsunami",
	pos = { x = 2, y = 6 },
	ability_name = "Lunar Tides",
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 12 then
				return {
					mult = card.ability.extra.mult,
					card = card
				}
			end
		end
		if not context.end_of_round and context.individual and context.cardarea == G.hand then
			if context.other_card:get_id() == 12 then
				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED,
						card = card,
					}
				else
					return {
						xmult = card.ability.extra.xmult,
						card = card,
					}
				end
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_shoot_the_moon" },
  }, cost = 13, result_joker = "j_tsun_lunar_tides" 
}

SMODS.Joker {
	key = "watering_can",
	rarity = "fusion",
	cost = 16,
	config = { extra = 1.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra } }
	end,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "Tsunami",
	pos = { x = 0, y = 6 },
	ability_name = "Watering Can",
	calculate = function(self, card, context)
		if context.scoring_hand and context.joker_main then
			local suits = {
				['Hearts'] = 0,
				['Diamonds'] = 0,
				['Spades'] = 0,
				['Clubs'] = 0
			}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name ~= 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
						suits["Hearts"] = suits["Hearts"] + 1
					elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
						suits["Diamonds"] = suits["Diamonds"] + 1
					elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
						suits["Spades"] = suits["Spades"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
						suits["Clubs"] = suits["Clubs"] + 1
					end
				end
			end
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name == 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
						suits["Hearts"] = suits["Hearts"] + 1
					elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
						suits["Diamonds"] = suits["Diamonds"] + 1
					elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
						suits["Spades"] = suits["Spades"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
						suits["Clubs"] = suits["Clubs"] + 1
					end
				end
			end
			local uniques = suits["Hearts"] + suits["Diamonds"] + suits["Clubs"] + suits["Spades"]
			local watermult = 1
			for k = 1, uniques, 1 do
				watermult = watermult * card.ability.extra
			end
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra } },
				Xmult = watermult
			}
		end
	end
}
FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_flower_pot" },
  }, cost = 10, result_joker = "j_tsun_watering_can" 
}


SMODS.Joker {
	key = "rainstorm",
	name = "Rainstorm",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 7, y = 12 },
	cost = 18,
	config = { extra = { nines = 0, moneys = 2, odds = 8 } },
	ability_name = "Rainstorm",
	loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'identifier')
		return { vars = { card.ability.extra.nines, card.ability.extra.moneys, new_numerator, new_denominator } }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.nines = 0
		if G.playing_cards then
			for k, v in pairs(G.playing_cards) do
				if v:get_id() == 9 then card.ability.extra.nines = card.ability.extra.nines + card.ability.extra.moneys end
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		---thanks examplejokers examplemod, saved my life
		local bonus = card.ability.extra.nines
		if bonus > 0 then return bonus end
	end,
	calculate = function(self, card, context)
		if G.playing_cards then
			card.ability.extra.nines = 0
			for k, v in pairs(G.playing_cards) do
				if v:get_id() == 9 then
					card.ability.extra.nines = card.ability.extra.nines + card.ability.extra.moneys
				end
			end
		end
		if context.after then
			for index, card2 in ipairs(context.full_hand) do
				if card_is_splashed(card2) and SMODS.pseudorandom_probability(card, 'super', 1, card.ability.extra.odds, 'tsun_rainstorm') then
					G.E_MANAGER:add_event(Event({
						blockable = true,
						blocking = true,
						func = function()
							SMODS.change_base(card2, nil, "9")
							card2:juice_up()
							return true
						end
					}))
				end
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_cloud_9" },
  }, cost = 9, result_joker = "j_tsun_rainstorm" 
}


SMODS.Joker {
	key = 'banana_tree',
	no_pool_flag = 'gros_michel_extinct',
	config = { extra = { mult = 20, tosplash = 6, splashed = 0 } },
	rarity = "fusion",
	atlas = 'Tsunami',
	pos = { x = 7, y = 6 },
	cost = 18,
	discovered = true,
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.tosplash, card.ability.extra.splashed } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
		if context.before then
			for index, card2 in ipairs(context.full_hand) do
				if card_is_splashed(card2) then
					card.ability.extra.splashed = card.ability.extra.splashed + 1
				end
			end
		end
		if context.after and not context.blueprint then
			if card.ability.extra.splashed >= card.ability.extra.tosplash then
				---Adds Cavendish to the Polymorph pool
				table.insert(Splashkeytable2, "j_cavendish")
				---Removes Gros Michel from the Polymorph pool
				if Splashkeytable2[1] == "j_gros_michel" then
					Splashkeytable2[1] = nil
				end
				---The Part Where The Card Is Destroyed
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This is the part where the card gets destroyed
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								-- Achievement Get: The Part Where The Card Is Destroyed
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				G.GAME.pool_flags.gros_michel_extinct = true
				return {
					message = 'Extinct!'
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_gros_michel" },
  }, cost = 5, result_joker = "j_tsun_banana_tree" 
}

SMODS.Joker {
	key = "banana_plantation",
	rarity = "fusion",
	cost = 30,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { xmult = 3, increase = 0.1, odds = 88888 } },
	atlas = "Tsunami",
	pos = { x = 5, y = 11 },
	loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
			'tsun_plantation')
		return { vars = { card.ability.extra.xmult, card.ability.extra.increase, new_numerator, new_denominator } }
	end,
	calculate = function(self, card, context)
		if context.before then
			for index, card2 in ipairs(context.full_hand) do
				if card_is_splashed(card2) then
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.increase
				end
			end
		end
		if context.joker_main then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
				Xmult = card.ability.extra.xmult,
				card = card,
			}
		end
		if context.end_of_round and context.main_eval and not context.game_over and not context.repetition and not context.blueprint then
			if SMODS.pseudorandom_probability(card, 'get-the-banana-kris', 1, card.ability.extra.odds, 'tsun_plantation') then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = 'Extinct!'
				}
			else
				return {
					message = 'Safe!'
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_cavendish" },
  }, cost = 15, result_joker = "j_tsun_banana_plantation" 
}

SMODS.Joker {
	key = "ice_tray",
	name = "Ice Tray",
	rarity = "fusion",
	cost = 16,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { xmult = 1 } },
	atlas = "Tsunami",
	pos = { x = 2, y = 5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				x_mult = math.max(1, card.ability.extra.xmult * (G.GAME.starting_params.play_limit - #G.play.cards))
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_stencil" },
  }, cost = 13, result_joker = "j_tsun_ice_tray" 
}

SMODS.Joker {
	key = "reflection",
	name = "Reflection",
	rarity = "fusion",
	cost = 18,
	config = { extra = 1.5, clubs = 0, nonclubs = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra } }
	end,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "Tsunami",
	pos = { x = 4, y = 4 },
	ability_name = "Reflection",
	---thanks again Eremel
	calculate = function(self, card, context)
		if context.joker_main then
			-- calculate the number of club/non-club pairs
			local clubs_count = 0
			local non_clubs_count = 0

			for index, card in ipairs(context.full_hand) do
				local reps = 1
				-- check if card is being splashed
				if card_is_splashed(card) then
					reps = reps + 1
				end

				for i = 1, reps do
					if card.ability.center_key == 'm_wild' then
						clubs_count = clubs_count + 1
						non_clubs_count = non_clubs_count + 1
					elseif card:is_suit('Clubs') then
						clubs_count = clubs_count + 1
					else
						non_clubs_count = non_clubs_count + 1
					end
				end
			end
			-- calculate the number of pairs
			local number_of_pairs = math.min(clubs_count, non_clubs_count)
			-- set the xmult appropriately
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra ^ number_of_pairs } },
				Xmult = card.ability.extra ^ number_of_pairs,
				card = card,
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_seeing_double" },
  }, cost = 14, result_joker = "j_tsun_reflection" 
}

SMODS.Joker {
	key = "deepsea_diver",
	name = "Deepsea Diver",
	blueprint_compat = true,
	rarity = "fusion",
	cost = 15,
	pos = { x = 3, y = 5 },
	atlas = "Tsunami",
	config = { extra = { odds = 4, numerator_bonus = 0 } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'vremade_space')
		return { vars = { numerator, denominator } }
	end,
	calculate = function(self, card, context)
		if context.before then
			card.ability.extra.numerator_bonus = 0
			for index, value in ipairs(G.play.cards) do
				if card_is_splashed(value) then
					card.ability.extra.numerator_bonus = card.ability.extra.numerator_bonus + 1
				end
			end
			if SMODS.pseudorandom_probability(card, 'see you space joker', 1 + card.ability.extra.numerator_bonus, card.ability.extra.odds) then
				return {
					level_up = true,
					message = localize('k_level_up_ex')
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_space" },
  }, cost = 8, result_joker = "j_tsun_deepsea_diver" 
}

SMODS.Joker {
	key = "vaporwave",
	config = { extra = { x_mult = 1, x_mult_gain = 0.01 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_gain } }
	end,
	rarity = "fusion",
	cost = 18,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = "Tsunami",
	pos = { x = 5, y = 7 },
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
				xmult = card.ability.extra.x_mult,
				card = card,
			}
		elseif context.skip_blind then
			if not context.blueprint then
				G.E_MANAGER:add_event(Event({
					func = function()
						card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
						card_eval_status_text(card, 'extra', nil, nil, nil, {
							message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
							colour = G.C.RED,
							card = card,
						})
						return true
					end
				}))
			end
		elseif context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) == true then
				card.ability.extra.x_mult_gain = card.ability.extra.x_mult_gain + 0.01
				return {
					extra = { message = "Vaporwave!", colour = G.C.RED },
					colour = G.C.RED,
					card = card
				}
			end
		end
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.x_mult = 1 + G.GAME.skips * 0.25
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_throwback", carry_stat = "xmult" },
  }, cost = 12, result_joker = "j_tsun_vaporwave" 
}


SMODS.Joker {
	key = "webbed_feet",
	name = "Webbed Feet",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	atlas = "Tsunami",
	blueprint_compat = true,
	pos = { x = 3, y = 1 },
	cost = 17,
	config = { extra = 1 },
	ability_name = "webbed_feet",
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and context.other_card:is_face() then
			if card_is_splashed(context.other_card) == true then
				if context.other_card:is_face() then
					return {
						message = localize('k_again_ex'),
						repetitions = card.ability.extra + 1,
						card = card
					}
				else
					return {
						message = localize('k_again_ex'),
						repetitions = card.ability.extra,
						card = card
					}
				end
			elseif context.other_card:is_face() then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra,
					card = card
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_sock_and_buskin" },
  }, cost = 12, result_joker = "j_tsun_webbed_feet" 
}

SMODS.Joker {
	key = "money_laundering",
	name = "Money Laundering",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	---this is commented because i lost the original sprite for credit card and am too lazy to regain it
	---atlas = "Tsunami",
	pos = { x = 5, y = 1 },
	cost = 1,
	config = { extra = 30, dollars = 1 },
	ability_name = "mooney_laundering",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra, card.ability.dollars } }
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and G.GAME.dollars < to_big(0) then
			if card_is_splashed(context.other_card) == true and G.GAME.dollars < to_big(0) and context.other_card then
				return {
					dollars = card.ability.dollars,
					card = card
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_credit_card" },
  }, cost = 1, result_joker = "j_tsun_money_laundering" 
}

SMODS.Joker {
	key = "asset_liquidation",
	name = "Asset Liquidation",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 1, y = 10 },
	cost = -10,
	config = { triggers = 5, triggersmax = 5, storage = 0 },
	ability_name = "mooney_laundering",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.triggers, card.ability.triggersmax } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			ease_hands_played(3)
			ease_discard(-G.GAME.round_resets.discards)
		end
		if context.money_altered and context.amount < 0 and card.ability.triggers > 0 then
			card:juice_up()
			local tempdollar = context.amount / -2
			if Tsunami_Config.TsunRounding then
				tempdollar = math.floor(tempdollar + 0.5)
			else
				tempdollar = math.floor(tempdollar)
			end
			card.ability.triggers = card.ability.triggers - 1
			---storing saved amount
			card.ability.storage = card.ability.storage + tempdollar
			ease_dollars(tempdollar)
		end
		if context.end_of_round and context.beat_boss and context.main_eval then
			card.ability.triggers = 5
			return {
				card = card,
				message = localize('k_reset')
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_burglar" },
  }, cost = 10, result_joker = "j_tsun_asset_liquidation" 
}

SMODS.Joker {
	key = "scuba",
	name = "SCUBA Mask",
	atlas = "Tsunami",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	pos = { x = 0, y = 13 },
	cost = 15,
	config = { extra = { fired = "Korsica", pun_missed = "Flamethrower", next_time = true } },
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local flagged = false
			for index, value in ipairs(G.play.cards) do
				if G.play.cards[1].config.center ~= G.P_CENTERS.c_base and not G.play.cards[1].debuff and value:is_face() == true then
					value:set_ability(G.P_CENTERS[G.play.cards[1].config.center.key])
					flagged = true
				end
			end
			if flagged then
				card_eval_status_text(card, 'extra', nil, nil, nil,
					{ message = localize('k_enhance_tm'), colour = G.C.BLUE })
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_midas_mask" },
    { name = "j_splash" },
  }, cost = 11, result_joker = "j_tsun_scuba" 
}

SMODS.Joker {
	key = "escape_artist",
	name = "Escape Artist",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 8, y = 6 },
	cost = 14,
	config = { chips = 75, handsize = 1 },
	ability_name = "Escape Artist",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.chips, card.ability.handsize } }
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.handsize)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.handsize)
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) then
				return {
					chips = card.ability.chips,
					card = card
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_stuntman" },
  }, cost = 12, result_joker = "j_tsun_escape_artist" 
}

SMODS.Joker {
	key = "soup",
	name = "Soup",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 2, y = 15 },
	cost = 12,
	config = { extra = { x_mult = 2, reduction = 0.06 } },
	ability_name = "soup",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult, card.ability.extra.reduction } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if card_is_splashed(context.other_card) == true then
				card.ability.extra.x_mult = card.ability.extra.x_mult - card.ability.extra.reduction
				if card.ability.extra.x_mult <= 1 then
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					play_sound('tarot1')
					card:start_dissolve()
				end
			end
		end
		if context.joker_main then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
				colour = G.C.RED,
				xmult = card.ability.extra.x_mult,
				card = card,
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_ramen" },
  }, cost = 11, result_joker = "j_tsun_soup" 
}

SMODS.Joker {
	key = "fractured_floodgate",
	name = "Fractured Floodgate",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 9, y = 6 },
	cost = 14,
	config = { extra = 2 },
	ability_name = "Fractured Floodgate",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra } }
	end,
	calculate = function(self, card, context)
		if context.before then
			Firstflag = false
		end
		if context.repetition and context.cardarea == G.play then
			if card_is_splashed(context.other_card) == true and Firstflag == false then
				Firstflag = true
				if (context.other_card == context.scoring_hand[1]) then
					return {
						message = localize('k_again_ex'),
						repetitions = card.ability.extra * 2,
						card = card
					}
				else
					return {
						message = localize('k_again_ex'),
						repetitions = card.ability.extra,
						card = card
					}
				end
			end
		end
		if context.repetition and context.cardarea == G.play and (context.other_card == context.scoring_hand[1]) then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card
			}
		end
		if context.joker_main then
			Firstflag = false
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_hanging_chad" },
  }, cost = 10, result_joker = "j_tsun_fractured_floodgate" 
}


SMODS.Joker {
	key = "youth",
	name = "Fountain of Youth",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 7, y = 15 },
	cost = 19,
	config = { extra = { xmult = 1.5, triggers = 1, plussuit = "Hearts", minussuit = "Spades" } },
	ability_name = "Fountain of Youth",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.triggers, card.ability.extra.plussuit, card.ability.extra.minussuit, colours = { G.C.SUITS[card.ability.extra.plussuit], G.C.SUITS[card.ability.extra.minussuit] } } }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.plussuit, card.ability.extra.minussuit = tsun_randsuit(2)
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if not context.other_card:is_suit(card.ability.extra.minussuit) then
				return {
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
					colour = G.C.RED,
					x_mult = card.ability.extra.xmult,
					card = card,
				}
			end
		end

		if context.end_of_round then
			card.ability.extra.plussuit, card.ability.extra.minussuit = tsun_randsuit(2)
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_ancient" },
  }, cost = 14, result_joker = "j_tsun_youth" 
}

SMODS.Joker {
	name = "Cryomancer",
	rarity = "fusion",
	cost = 18,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	key = "cryomancer",
	atlas = "Tsunami",
	pos = { x = 7, y = 3 },
	ability_name = "Cryomancer",
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_splash
		return {}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					blockable = true,
					blocking = true,
					func = function()
						local tarotcard = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'tar')
						tarotcard:add_to_deck()
						G.consumeables:emplace(tarotcard)
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = localize('k_plus_tarot'), colour = G.C.PURPLE })
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
						return true
					end
				}))
			end
		end
		if context.end_of_round and context.main_eval and G.jokers and G.jokers.cards[#G.jokers.cards].config.center.key == "j_splash" then
			if not G.jokers.cards[#G.jokers.cards].ability.eternal then
				local killsplash = G.jokers.cards[#G.jokers.cards]
				killsplash:start_dissolve()
				G.E_MANAGER:add_event(Event({
					blockable = true,
					blocking = true,
					func = function()
						local tarotcard = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'tar')
						tarotcard:set_edition({ negative = true }, nil)
						tarotcard:add_to_deck()
						G.consumeables:emplace(tarotcard)
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = localize('k_plus_tarot'), colour = G.C.PURPLE })
						return true
					end
				}))
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_cartomancer" },
  }, cost = 15, result_joker = "j_tsun_cryomancer" 
}

SMODS.Joker {
	name = "Toaster",
	rarity = "fusion",
	cost = 18,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	key = "toaster",
	atlas = "Tsunami",
	pos = { x = 5, y = 2 },
	ability_name = "Toaster",
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and
			(context.other_card:get_id() == 2 or
				context.other_card:get_id() == 3 or
				context.other_card:get_id() == 4 or
				context.other_card:get_id() == 5 or
				context.other_card:get_id() == 14) then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card
			}
		end
		if context.after then
			for index, value in ipairs(G.play.cards) do
				if value:get_id() == 6 then
					G.E_MANAGER:add_event(Event({
						blockable = true,
						blocking = true,
						func = function()
							SMODS.change_base(value, nil, "3")
							value:juice_up()
							return true
						end
					}))
				elseif value:get_id() == 7 then
					G.E_MANAGER:add_event(Event({
						blockable = true,
						blocking = true,
						func = function()
							SMODS.change_base(value, nil, "3")
							value:juice_up()
							return true
						end
					}))
				elseif value:get_id() == 8 then
					G.E_MANAGER:add_event(Event({
						blockable = true,
						blocking = true,
						func = function()
							SMODS.change_base(value, nil, "4")
							value:juice_up()
							return true
						end
					}))
				elseif value:get_id() == 9 then
					G.E_MANAGER:add_event(Event({
						blockable = true,
						blocking = true,
						func = function()
							SMODS.change_base(value, nil, "4")
							value:juice_up()
							return true
						end
					}))
				elseif value:get_id() == 10 then
					G.E_MANAGER:add_event(Event({
						blockable = true,
						blocking = true,
						func = function()
							SMODS.change_base(value, nil, "5")
							value:juice_up()
							return true
						end
					}))
				end
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_hack" },
  }, cost = 11, result_joker = "j_tsun_toaster" 
}

SMODS.Joker {
	name = "Surfboard",
	rarity = "fusion",
	cost = 21,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	key = "surfboard",
	atlas = "Tsunami",
	pos = { x = 2, y = 10 },
	config = { extra = { Xmult = 1.3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	ability_name = "Surfboard",
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			if context.other_card:is_suit('Clubs', nil, true) or context.other_card:is_suit('Spades', nil, true) then
				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED,
						card = card,
					}
				else
					return {
						x_mult = card.ability.extra.Xmult,
						card = card
					}
				end
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_blackboard" },
  }, cost = 12, result_joker = "j_tsun_surfboard" 
}

local handsteeltally = 0
SMODS.Joker {
	key = "thermos",
	name = "Thermos",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 7, y = 2 },
	cost = 20,
	config = { extra = { steel_tally = 0, xmult = 1, increase = 0.25, steelmult = 0.2 } },
	ability_name = "Thermos",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		return { vars = { card.ability.extra.xmult, card.ability.extra.increase, card.ability.extra.steelmult } }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.steel_tally = 0
		if G.playing_cards then
			for k, v in pairs(G.playing_cards) do
				if v.config.center == G.P_CENTERS.m_steel then
					card.ability.extra.steel_tally = card.ability.extra.steel_tally + 1
				end
			end
			card.ability.extra.xmult = 1 + (card.ability.extra.steel_tally * card.ability.extra.increase)
		end
	end,
	calculate = function(self, card, context)
		if context.before then
			for k, v in ipairs(G.play.cards) do
				if v.config.center == G.P_CENTERS.m_steel then
					handsteeltally = handsteeltally + 1
				end
			end
		end
		if context.individual and context.cardarea == G.play then
			if card_is_splashed(context.other_card) and context.other_card.config.center == G.P_CENTERS.m_steel then
				return {
					x_mult = 1 + (card.ability.extra.steelmult * handsteeltally),
				}
			end
		end
		if context.joker_main then
			handsteeltally = 0
			return {
				x_mult = card.ability.extra.xmult,
				card = card,
			}
		end
		---Lazy update code outside context checks so it should update during every context.
		card.ability.extra.steel_tally = 0
		for k, v in pairs(G.playing_cards) do
			if v.config.center == G.P_CENTERS.m_steel then
				card.ability.extra.steel_tally = card.ability.extra.steel_tally + 1
			end
		end
		card.ability.extra.xmult = 1 + (card.ability.extra.steel_tally * card.ability.extra.increase)
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_steel_joker" },
  }, cost = 11, result_joker = "j_tsun_thermos" 
}

SMODS.Joker {
	name = "Swimming Trunks",
	key = 'swimming_trunks',
	rarity = "fusion",
	discovered = true,
	atlas = 'Tsunami',
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	pos = { x = 4, y = 15 },
	config = { mult = 0, extra = { mult_gain = 4, percentile = 0.5, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_gain, (card.ability.extra.percentile * 100), card.ability.extra.mult } }
	end,
	---I don't actually know how to do carry stats to extra with fusionjokers, so I'm just manually moving the value to extra here
	add_to_deck = function(self, card, from_debuff)
		if card.ability.extra.mult == 0 and card.ability.mult then
			card.ability.extra.mult = card.ability.mult
			card.ability.mult = 0
		end
	end,
	calculate = function(self, card, context)
		if context.before and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			if next(context.poker_hands['Two Pair']) and #G.play.cards == 5 then
				for index, value in ipairs(G.play.cards) do
					if card_is_splashed(value) then
						local cardrank = 0
						if value:get_id() == 14 then
							cardrank = 11 * card.ability.extra.percentile
						elseif value:get_id() == 13 or value:get_id() == 12 or value:get_id() == 11 then
							cardrank = 10 * card.ability.extra.percentile
						else
							cardrank = value:get_id() * card.ability.extra.percentile
						end
						if Tsunami_Config.TsunRounding then
							cardrank = math.floor(cardrank + 0.5)
						end
						card.ability.extra.mult = card.ability.extra.mult + (cardrank)
					end
				end
			end
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.RED,
				card = card
			}
		end
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
				mult = card.ability.extra.mult
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_trousers", carry_stat = "mult" },
  }, cost = 12, result_joker = "j_tsun_swimming_trunks" 
}

SMODS.Joker {
	name = "Abrasion",
	key = 'abrasion',
	rarity = "fusion",
	discovered = true,
	atlas = 'Tsunami',
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	pos = { x = 9, y = 0 },
	config = { extra = { chip_gain = 25, chips = 0, mult_gain = 3, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { card.ability.extra.chip_gain, card.ability.extra.chips, card.ability.extra.mult_gain, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.before then
			local upgrade = false
			for index, value in ipairs(G.play.cards) do
				if value.ability.name == "Stone Card" then
					card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
					upgrade = true
				end
			end
			if upgrade == true then
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS,
					card = card
				}
			end
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
				card = card
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_stone" },
  }, cost = 10, result_joker = "j_tsun_abrasion" 
}

SMODS.Joker {
	name = "Waterjet Cutter",
	key = 'waterjet',
	rarity = "fusion",
	discovered = true,
	atlas = 'Tsunami',
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	pos = { x = 3, y = 2 },
	---if you know you know
	config = { extra = { LIKE_DEFECTS = true, LIKE_TASTE = true, INSPECTION_LEVEL = "1000000" } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
	end,
	calculate = function(self, card, context)
		if context.before then
			for index, value in ipairs(G.play.cards) do
				value.cut = false
				if value.config.center_key == "m_stone" then
					local enhancement = SMODS.poll_enhancement({ guaranteed = true, type_key = 'waterenhance' })
					while enhancement == "m_stone" do
						enhancement = SMODS.poll_enhancement({ guaranteed = true, type_key = 'waterenhance' })
					end
					value:set_ability(G.P_CENTERS[enhancement], nil, true)
					value:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'waterseal' }), true, false)
					value:juice_up()
					value.cut = true
				end
				if card_is_splashed(value) == true and value.cut ~= true then
					value:set_ability(G.P_CENTERS.m_stone, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							value:juice_up()
							return true
						end
					}))
				end
				value.cut = false
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_marble" },
  }, cost = 12, result_joker = "j_tsun_waterjet" 
}

SMODS.Joker {
	name = "Gambling Ship",
	key = 'g_ship',
	rarity = "fusion",
	discovered = true,
	atlas = 'Tsunami',
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	pos = { x = 5, y = 6 },
	---if you know you know
	config = { chancecount = 2, extra = { GET_TO_USE_THESE = true, quip = "TRY AND DODGE THIS!" } },
	calculate = function(self, card, context)
		if context.before then
			local hit = false
			for index, value in ipairs(G.play.cards) do
				if index > 1 and index < #G.play.cards then
					if hit == false and value:get_id() == 7 and
						G.play.cards[index - 1]:get_id() == 7 and
						G.play.cards[index + 1]:get_id() == 7 then
						hit = true
						if pseudorandom('GAMBLECORE') < 1 / 7 then
							card.ability.chancecount = card.ability.chancecount * 2
							play_sound("tsun_probability_tm", 1, 1)
							return {
								message = localize("k_probability_tm"),
								colour = G.C.GREEN,
							}
						else
							return {
								message = localize("k_nope_ex"),
								colour = G.C.RED
							}
						end
					end
				end
			end
		end
		if context.mod_probability and not context.blueprint then
			return {
				numerator = context.numerator * card.ability.chancecount
			}
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_oops" },
  }, cost = 14, result_joker = "j_tsun_g_ship" 
}

SMODS.Joker {
	name = "Wet Floor Sign",
	key = 'wet_floor_sign',
	rarity = "fusion",
	discovered = true,
	atlas = 'Tsunami',
	cost = 20,
	blueprint_compat = true,
	perishable_compat = true,
	pos = { x = 4, y = 11 },
	config = { suit = "Hearts", dollars = 2 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.suit, card.ability.dollars, colours = { G.C.SUITS[card.ability.suit], } } }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.suit = tsun_randsuit(1)
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.suit = tsun_randsuit(1)
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit(card.ability.suit) then
				return {
					dollars = card.ability.dollars,
					card = context.other_card
				}
			end
		end
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_todo_list" },
  }, cost = 15, result_joker = "j_tsun_wet_floor_sign" 
}

SMODS.Joker {
	key = "hygiene_card",
	name = "hygiene Card",
	rarity = "fusion",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	atlas = "Tsunami",
	pos = { x = 0, y = 7 },
	cost = 18,
	config = { extra = { enhance_tally = 0, xmult = 1, increase = 0.2, xchips = 1.1 } },
	ability_name = "hygiene Card",
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.increase, card.ability.extra.xchips } }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.enhance_tally = 0
		if G.playing_cards then
			for k, v in pairs(G.playing_cards) do
				if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
					card.ability.extra.enhance_tally = card.ability.extra.enhance_tally + 1
				end
			end
			card.ability.extra.xmult = 1 + (card.ability.extra.enhance_tally * card.ability.extra.increase)
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.config.center ~= G.P_CENTERS.c_base and not context.other_card.debuff and not context.other_card.vampired then
				return {
					x_chips = card.ability.extra.xchips
				}
			end
		end
		if context.joker_main then
			return {
				x_mult = card.ability.extra.xmult,
				card = card,
			}
		end
		---Lazy update code outside context checks so it should update during every context.
		card.ability.extra.enhance_tally = 0
		for k, v in pairs(G.playing_cards) do
			if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
				card.ability.extra.enhance_tally = card.ability.extra.enhance_tally + 1
			end
		end
		card.ability.extra.xmult = 1 + (card.ability.extra.enhance_tally * card.ability.extra.increase)
	end
}

FusionJokers.fusions:register_fusion{
  jokers = {
    { name = "j_splash" },
    { name = "j_drivers_license" },
  }, cost = 16, result_joker = "j_tsun_hygiene_card" 
}
