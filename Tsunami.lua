--- STEAMODDED HEADER
--- MOD_NAME: Tsunami
--- MOD_ID: Tsunami
--- MOD_AUTHOR: [Maratby]
--- MOD_DESCRIPTION: FUSES EVERY JOKER WITH SPLASH!!!! Eventually. Except for the ones on the front page.
--- BADGE_COLOUR: 0000FF
--- PRIORITY: 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
--- PREFIX: tsun
----------------------------------------------
------------MOD CODE -------------------------

--- i had to make the priority higher than cryptid to get crossmod fusion to work
--- Checking for loaded mods, for the crossmod fusions
if (SMODS.Mods["Cryptid"] or {}).can_load then
	Is_Cryptid = true
else
	Is_Cryptid = false
end

---This table is sent to the lovely patch in lovely.toml and enables these jokers to use the Splash effect
Splashkeytable = {
	"j_tsun_youth",
	"j_tsun_soaked_joker",
	"j_tsun_dihydrogen_monoxide",
	"j_tsun_raft",
	"j_tsun_ice_tray",
	"j_tsun_watering_can",
	"j_tsun_tsunami_marie",
	"j_tsun_vaporwave",
	"j_tsun_webbed_feet",
	"j_tsun_soup",
	"j_tsun_money_laundering",
	"j_tsun_escape_artist",
	"j_tsun_fractured_floodgate",
	"j_tsun_thermos",
}

--- This table is used by the Polymorph Spectral to choose a random non-Legendary Splash fusion compatible Joker
Splashkeytable2 = {
	"j_half_joker",
	"j_fibonacci",
	"j_hiker",
	"j_stencil",
	"j_flower_pot",
	"j_throwback",
	"j_sock_and_buskin",
	"j_ramen",
	"j_riff_raff",
	"j_stuntman",
	"j_hanging_chad",
	"j_ancient",
	"j_credit_card",
	"j_steel_joker",
}

--The function Fountain of Youth and other jokers call when they need a random suit (or two unique random suits) selected
function randsuit(a)
	suits = {
		"Hearts",
		"Diamonds",
		"Clubs",
		"Spades"
	}
		for i = #suits, 2, -1 do
		  local j = math.random(i)
		  suits[i], suits[j] = suits[j], suits[i]
		end
		if a == 2 then
			return suits[1], suits[2]
		else
			return suits[1]
		end
end


SMODS.Atlas {
	key = "Tsunami",
	path = "TsunamiJokers.png",
	px = 71,
	py = 95,
	}
SMODS.Atlas {
	key = "TsunamiTarot",
	path = "TsunamiTarot.png",
	px = 71,
	py = 95,
	}
SMODS.Atlas {
	key = "TsunamiDecks",
	path = "TsunamiDecks.png",
	px = 71,
	py = 95,
	}

	SMODS.Joker {
		loc_txt = {
			name = "Splish Splash",
			text = {
				"When blind is selected, creates {C:blue}Splash",
				"{C:inactive}(don't need room){}",
				"{s:0.7}{C:inactive}(Riff Raff + Splash){}",
			}},
			rarity = 5,
			cost = 8,
			unlocked = true,
			discovered = true,
			blueprint_compat = true,
			eternal_compat = true,
			perishable_compat = true,
			key = "splish_splash",
			atlas = "Tsunami",
			pos = { x = 1, y = 12 },
		ability_name = "Splish Splash",
		calculate = function(self,card,context)
			if
			context.setting_blind
			then
				local splishcard = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				splishcard:add_to_deck()
				G.jokers:emplace(splishcard)
			end
		end
		}

	FusionJokers.fusions:add_fusion("j_riff_raff", nil, false, "j_splash", nil, false, "j_tsun_splish_splash", 6)

	SMODS.Joker{
		key = "soaked_joker",
		name = "Soaked Joker",
		atlas = "Tsunami",
		rarity = 5,
		unlocked = true,
		discovered = true,
		blueprint_compat = true,
		pos = {x = 7, y = 0},
		cost = 8,
		config = {extra = {mult = 5}},
		loc_txt = {
			name = "Soaked Joker",
			text = {
				"Every {C:attention}played card{} counts in scoring",
				"{C:attention}Extra scored cards {}give{C:attention} +5 Mult",
				"{}when scored",
				"{s:0.7}{C:inactive}(Half Joker + Splash){}",
			}
		},
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra}}
		end,
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play then
				local soakedflag = false
				local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
				for k, v in ipairs(scoring_hand) do
					if context.other_card == scoring_hand[k] then
						soakedflag = true
						end
					end
					if soakedflag == false then
						return {
							mult = card.ability.extra.mult,
							card = card
							}
					else
						local soakedflag = false
			end
		end
	end
	}

	FusionJokers.fusions:add_fusion("j_half", nil, false, "j_splash", nil, false, "j_tsun_soaked_joker", 8)


	SMODS.Joker{
		key = "raft",
		name = "Raft",
		rarity = 5,
		unlocked = true,
		discovered = true,
		blueprint_compat = true,
		atlas = "Tsunami",
		pos = {x = 0, y = 11},
		cost = 8,
		config = {extra = 5},
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra}}
		end,
		ability_name = "raft",
		loc_txt = {
			name = "Raft",
			text = {
				"Every {C:attention}played card counts in scoring",
        		"and permanently gains {C:chips}+#1#{} Chips when scored",
				"This effect applies {C:attention}twice{} on {C:attention}extra played cards",
				"{s:0.7}{C:inactive}(Hiker + Splash){}",
			}
		},
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play then
				local raftflag = false
				context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
				context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra
				card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
				local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
				for k, v in ipairs(scoring_hand) do
					if context.other_card == scoring_hand[k] then
						raftflag = true
						end
					end
					if raftflag == false then
						context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
						context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra
						return {
							extra = {message = "Raft!", colour = G.C.CHIPS},
							colour = G.C.CHIPS,
							card = card
							}
					else
						raftflag = false
			end
		end
	end
}


	FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_hiker", nil, false, "j_tsun_raft", 10)

	SMODS.Joker {
		loc_txt = {
			name = "Dihydrogen Monoxide",
			text = {
				"Every {C:attention}played card {}counts in scoring",
				"Each played {C:attention}Ace{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8{} gives",
				"{C:mult}+#1#{} Mult for each {C:attention}Ace{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8{}",
				"in the scoring hand",
				"{s:0.7}{C:inactive}(Fibonacci + Splash){}",
			}},
			rarity = 5,
			cost = 8,
			config = { extra = { mult = 3 } },
			loc_vars = function(self, info_queue, card)
				return {vars = {card.ability.extra.mult}}
			end,
			unlocked = true,
			discovered = true,
			blueprint_compat = true,
			eternal_compat = true,
			perishable_compat = true,
			key = "dihydrogen_monoxide",
			atlas = "Tsunami",
			pos = { x = 1, y = 5 },
		ability_name = "Dihydrogen Monoxide",
		calculate = function(self,card,context)
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

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_fibonacci", nil, false, "j_tsun_dihydrogen_monoxide", 13)

SMODS.Joker {
	loc_txt = {
		name = "Watering Can",
		text = {
			"Every {C:attention}played card {}counts in scoring",
			"Gives {X:mult,C:white}X#1#{} Mult for each unique",
			"{C:attention}suit {}in {C:attention}played hand",
			"{s:0.7}{C:inactive}(Flower Pot + Splash){}",
		}},
		rarity = 5,
		cost = 8,
		config = { extra = 1.5 },
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra}}
		end,
		unlocked = true,
		discovered = true,
		blueprint_compat = true,
		eternal_compat = true,
		perishable_compat = true,
		key = "watering_can",
		atlas = "Tsunami",
		pos = { x = 0, y = 6 },
	ability_name = "Watering Can",
	calculate = function(self,card,context)
		if context.scoring_hand and context.joker_main then
			local suits = {
				['Hearts'] = 0,
				['Diamonds'] = 0,
				['Spades'] = 0,
				['Clubs'] = 0
			}
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name ~= 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
					elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
					elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
				end
			end
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name == 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
					elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
					elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
					elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
				end
			end
			local uniques = suits["Hearts"] + suits["Diamonds"] + suits["Clubs"] + suits["Spades"]
			local watermult = 1
			for k = 1 , uniques , 1 do
				watermult = watermult * card.ability.extra
			end
				return {
					message = localize{type='variable',key='a_xmult',vars={watermult}},
					Xmult_mod = watermult
				}
			end
		end
	}
FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_flower_pot", nil, false, "j_tsun_watering_can", 10)

SMODS.Joker {
    key = "ice_tray",
    loc_txt = {
        name = "Ice Tray",
        text = {
			"Every {C:attention}played card {}counts in scoring",
            "{C:attention}Extra scored cards {}give {X:mult,C:white}X#1#{} Mult",
            "{s:0.7}{C:inactive}(Joker Stencil + Splash)"
        }
    },
    rarity = 5,
    cost = 9,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {xmult = 1.5}},
    atlas = "Tsunami",
	pos = { x = 2, y = 5 },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
			local iceflag = false
			local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
			for k, v in ipairs(scoring_hand) do
				if context.other_card == scoring_hand[k] then
					iceflag = true
					end
			end
			if iceflag == false then
				return {
					x_mult = card.ability.extra.xmult,
					card = card
				}
			else
				iceflag = false
			end
		end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_stencil", nil, false, "j_tsun_ice_tray", 13)

SMODS.Joker {
    key = "tsunami_marie",
    loc_txt = {
        name = "Marie",
        text = {
            "{C:blue}Splash {C:attention}Fusions{} and {C:blue}Splash {}give {X:mult,C:white}X#1#{} Mult",
            "{s:0.2}{C:inactive}(Also works with Ripple from JokerEvolution!)",
			"{s:0.5}{C:inactive}(Any Vanilla Legendary + Splash)"
        }
    },
    rarity = 5,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    config = {extra = 2},
    atlas = "Tsunami",
	pos = { x = 4, y = 8 },
	soul_pos = { x = 4, y = 9 },
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra}}
    end,
    calculate = function(self, card, context)
		if context.other_joker then
			if ( context.other_joker.config.center.mod and context.other_joker.config.center.mod.id == "Tsunami" and self ~= context.other_joker)
			or ((context.other_joker.config.center.key == "j_splash" or context.other_joker.config.center.key == "j_evo_ripple") and self ~= context.other_joker) then
					G.E_MANAGER:add_event(Event({
						func = function()
							context.other_joker:juice_up(0.5, 0.5)
							return true
						end
					}))
				return {
						message = localize{type='variable',key='a_xmult',vars={card.ability.extra}},
						Xmult_mod = card.ability.extra,
						card = context.other_joker,
				}
			end
		end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_canio", nil, false, "j_tsun_tsunami_marie", 20)
FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_perkeo", nil, false, "j_tsun_tsunami_marie", 20)
FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_triboulet", nil, false, "j_tsun_tsunami_marie", 20)
FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_yorick", nil, false, "j_tsun_tsunami_marie", 20)
FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_chicot", nil, false, "j_tsun_tsunami_marie", 20)

SMODS.Joker {
    key = "vaporwave",
    config = {extra = {x_mult = 1, x_mult_gain = 0.01}},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_gain}}
	end,
    loc_txt = {
        name = "Vaporwave",
        text = {
			"Every {C:attention}played card {}counts in scoring",
			"Gains {X:mult,C:white}X#2#{} Mult when {C:attention}Blind{} is skipped",
			"{C:attention}Increase value{} increases by {X:mult,C:white}X0.01{} for each {C:attention}extra scored card",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{} Mult",
            "{s:0.7}{C:inactive}(Throwback + Splash)"
        }
    },
    rarity = 5,
    cost = 12,
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
				message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}},
				xmult_mod = card.ability.extra.x_mult,
				card = card,
			}
		elseif context.skip_blind then
            if not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
						card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}},
                                colour = G.C.RED,
                            card = card,
						})
							return true
                    end}))
            end
		elseif context.individual and context.cardarea == G.play then
			local vaporflag = false
			local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
			for k, v in ipairs(scoring_hand) do
				if context.other_card == scoring_hand[k] then
					vaporflag = true
					end
				end
				if vaporflag == false then
					card.ability.extra.x_mult_gain = card.ability.extra.x_mult_gain + 0.01
					return {
						extra = {message = "Vaporwave!", colour = G.C.RED},
						colour = G.C.RED,
						card = card
						}
				else
					vaporflag = false
		end
		end
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.x_mult = 1 + G.GAME.skips*0.25
end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_throwback", "xmult", false, "j_tsun_vaporwave", 12)

SMODS.Joker{
	key = "webbed_feet",
	name = "Webbed Feet",
	rarity = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = {x = 3, y = 1},
	cost = 8,
	config = {extra = 1},
	ability_name = "webbed_feet",
	loc_txt = {
		name = "Webbed Feet",
		text = {
			"Every {C:attention}played card{} counts in scoring",
			"Retrigger all {C:attention}face cards{} and {C:attention}extra scored cards",
			"Retrigger {C:attention}extra scored face cards an additional time",
			"{s:0.7}{C:inactive}(Sock And Buskin + Splash){}",
		}
	},
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and context.other_card:is_face() then
			local webbedflag = false
			local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
			for k, v in ipairs(scoring_hand) do
				if context.other_card == scoring_hand[k] then
					webbedflag = true
					end
				end
				if webbedflag == false then
					if context.other_card:is_face() then
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
				elseif context.other_card:is_face() then
					webbedflag = false
						return {
							message = localize('k_again_ex'),
							repetitions = card.ability.extra,
							card = card
						}
				else
					webbedflag = false
				end
			end
		end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_sock_and_buskin", nil, false, "j_tsun_webbed_feet", 12)

SMODS.Joker{
	key = "money_laundering",
	name = "Money Laundering",
	rarity = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = {x = 5, y = 1},
	cost = 1,
	config = {extra = 30, dollars = 1},
	ability_name = "mooney_laundering",
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra, card.ability.dollars}}
	end,
	loc_txt = {
		name = "Money Laundering",
		text = {
			"Every {C:attention}played card{} counts in scoring",
			"You can go up to {C:money}-$#1#{} in debt",
			"While in {C:attention}debt,{} gives {C:money}$#2#{}for each {C:attention}extra card played",
			"{s:0.7}{C:inactive}(Credit Card + Splash){}",
		}
	},
	add_to_deck = function(self, card, from_debuff)
		G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and G.GAME.dollars < 0 then
			local laundryflag = false
			local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
			for k, v in ipairs(scoring_hand) do
				if context.other_card == scoring_hand[k] then
					laundryflag = true
					end
				end
				if laundryflag == false and G.GAME.dollars < 0 and context.other_card then
					return {
						dollars = card.ability.dollars,
						card = card
					}
				else
					laundryflag = false
				end
			end
		end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_credit_card", nil, false, "j_tsun_money_laundering", 1)

SMODS.Joker{
	key = "escape_artist",
	name = "Escape Artist",
	rarity = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = {x = 8, y = 6},
	cost = 9,
	config = {chips = 75, handsize = 1},
	ability_name = "Escape Artist",
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.chips, card.ability.handsize}}
	end,
	loc_txt = {
		name = "Escape Artist",
		text = {
			"Every {C:attention}played card{} counts in scoring",
			"{C:attention}Extra played cards{} give {C:blue}+#1# Chips",
			"{C:attention}-#2# {}hand size",
			"{s:0.7}{C:inactive}(Stuntman + Splash){}",
		}
	},
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.handsize)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.handsize)
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local magicflag = false
			local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
			for k, v in ipairs(scoring_hand) do
				if context.other_card == scoring_hand[k] then
					magicflag = true
					end
				end
				if magicflag == false then
					return {
						chips = card.ability.chips,
						card = card
					}
				else
					magicflag = false
				end
			end
		end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_stuntman", nil, false, "j_tsun_escape_artist", 12)

SMODS.Joker{
	key = "soup",
	name = "Soup",
	rarity = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = {x = 2, y = 15},
	cost = 8,
	config = {extra = {x_mult = 2}},
	ability_name = "soup",
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.x_mult}}
	end,
	loc_txt = {
		name = "Soup",
		text = {
			"Every {C:attention}played card{} counts in scoring",
			"This joker gives {X:mult,C:white}X#1#{} Mult",
			"loses {X:mult,C:white}X0.1{} Mult per {C:attention}extra card scored",
			"{s:0.7}{C:inactive}(Soup + Splash){}",
		}
	},
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local soupflag = false
			local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
			for k, v in ipairs(scoring_hand) do
				if context.other_card == scoring_hand[k] then
					soupflag = true
					end
				end
				if soupflag == false then
					card.ability.extra.x_mult = card.ability.extra.x_mult - 0.10
					if card.ability.extra.x_mult <= 1 then
						G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('tarot1')
                            card:start_dissolve()
					end
				else
					soupflag = false
				end
			end
			if context.joker_main then
				return {
					message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}},
					colour = G.C.RED,
					xmult_mod = card.ability.extra.x_mult,
					card = card,
				}
			end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_ramen", nil, false, "j_tsun_soup", 11)

SMODS.Joker{
	key = "fractured_floodgate",
	name = "Fractured Floodgate",
	rarity = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = {x = 9, y = 6},
	cost = 8,
	config = {extra = 2},
	ability_name = "Fractured Floodgate",
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra}}
	end,
	loc_txt = {
		name = "Fractured Floodgate",
		text = {
			"Every {C:attention}played card{} counts in scoring",
			"Retrigger {C:attention}first{} played card {C:attention}#1#{} times",
			"Retrigger {C:attention}first extra{} played card {C:attention}#1#{} times",
			"{s:0.7}{C:inactive}(Hanging Chad + Splash){}",
		}
	},
	calculate = function(self, card, context)
		if context.before then
			Firstflag = false
		end
		if context.repetition and context.cardarea == G.play then
			local gateflag = false
			local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
			for k, v in ipairs(scoring_hand) do
				if context.other_card == scoring_hand[k] then
					gateflag = true
					end
			end
				if gateflag == false and Firstflag == false then
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
		if context.repetition and context.cardarea == G.play and (context.other_card == context.scoring_hand[1])  then
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

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_hanging_chad", nil, false, "j_tsun_fractured_floodgate", 10)

SMODS.Joker{
	key = "youth",
	name = "Fountain of Youth",
	rarity = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = {x = 7, y = 15},
	cost = 8,
	config = {extra = {xmult = 1.5, triggers = 1, plussuit = "Hearts", minussuit = "Spades"}},
	ability_name = "Fountain of Youth",
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult, card.ability.extra.triggers, card.ability.extra.plussuit, card.ability.extra.minussuit, colours = {G.C.SUITS[card.ability.extra.plussuit], G.C.SUITS[card.ability.extra.minussuit]}}}
	end,
	loc_txt = {
		name = "Fountain of Youth",
		text = {
			"Every {C:attention}played card{} counts in scoring",
			"Played cards give {X:mult,C:white}X#1#{} Mult, except {V:2}#4#",
			"Retrigger {V:1}#3#{} {C:attention}#2# time",
			"{s:0.8}suits change at end of round",
			"{s:0.7}{C:inactive}(Ancient Joker + Splash){}",
		}
	},
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.plussuit, card.ability.extra.minussuit = randsuit(2)
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if not context.other_card:is_suit(card.ability.extra.minussuit) then
				return {
					message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}},
					colour = G.C.RED,
					x_mult = card.ability.extra.xmult,
					card = card,
				}
			end
		end
		if context.repetition and context.cardarea == G.play then
			if context.other_card:is_suit(card.ability.extra.plussuit) then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.triggers,
					card = card
				}
			end
		end
		if context.end_of_round then
			card.ability.extra.plussuit, card.ability.extra.minussuit = randsuit(2)
		end
end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_ancient", nil, false, "j_tsun_youth", 14)

SMODS.Joker{
	key = "thermos",
	name = "Thermos",
	rarity = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	pos = {x = 7, y = 2},
	cost = 9,
	config = {extra = {steel_tally = 0, xmult = 1, increase = 0.25, steelmult = 0.2}},
	ability_name = "Fountain of Youth",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_steel
		return {vars = {card.ability.extra.xmult, card.ability.extra.increase, card.ability.extra.steelmult}}
	end,
	loc_txt = {
		name = "Thermos",
		text = {
			"Every {C:attention}played card{} counts in scoring",
			"This Joker gains {X:mult,C:white} X#2# {} Mult for each",
            "{C:attention}Steel Card{} in your {C:attention}full deck",
			"{s:0.7}{C:inactive}(currently {X:mult,C:white}X#1#{C:inactive} Mult)",
			"{C:attention}Extra played {C:attention}Steel Cards{} give",
			"{X:mult,C:white} X#3# {} Mult for each {C:attention}Steel Card{} in {C:attention}played hand",
			"{s:0.7}{C:inactive}(Steel Joker + Splash){}",
		}
	},
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.steel_tally = 0
		if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v.config.center == G.P_CENTERS.m_steel then card.ability.extra.steel_tally = card.ability.extra.steel_tally+1 end
            end
			card.ability.extra.xmult = 1 + (card.ability.extra.steel_tally * card.ability.extra.increase)
		end
	end,
	calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play then
				Handsteeltally = 0
				local thermosflag = false
				local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
				for k, v in ipairs(G.play.cards) do
					if context.other_card.ability.name == "Steel Card" then
						Handsteeltally = Handsteeltally + 1
					end
				end
			for k, v in ipairs(scoring_hand) do
				if context.other_card == scoring_hand[k] then
					thermosflag = true
			end
					if thermosflag == false and context.other_card.ability.name == "Steel Card" then
						return {
							message = localize{type = 'variable', key = 'a_xmult', vars = {(card.ability.extra.steelmult * Handsteeltally)}},
							colour = G.C.RED,
							x_mult = 1 + (card.ability.extra.steelmult * Handsteeltally),
							card = card,
						}
					else
						thermosflag = false
					end
				end
			end
			if context.joker_main then
				Handsteeltally = 0
				return {
					message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}},
					x_mult = card.ability.extra.xmult,
					card = card,
			}
		end
			if context.playing_card_added or context.remove_playing_cards or context.before_hand then
				card.ability.extra.steel_tally = 0
            	for k, v in pairs(G.playing_cards) do
                	if v.config.center == G.P_CENTERS.m_steel then card.ability.extra.steel_tally = card.ability.extra.steel_tally + 1 end
					card.ability.xmult = 1 + (card.ability.extra.steel_tally * card.ability.extra.increase)
            end
			end
	end
}

FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_steel_joker", nil, false, "j_tsun_thermos", 11)

SMODS.Consumable{
	key = 'aeon',
	set = 'Tarot',
	pos = {x = 0, y = 0},
	atlas = "TsunamiTarot",
	name = "tsunamiaeon",
	discovered = true,
	cost = 5,
	loc_txt = {
		name = "Aeon",
		text = {
			"Creates {C:blue}Splash",
			"{C:inactive}(Must have room)"
		},
	},
	config = {extra = 2},
	can_use = function(self, card)
		return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				if #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers then
					play_sound("timpani")
					local splashtarot = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
					splashtarot:add_to_deck()
					G.jokers:emplace(splashtarot)
					used_consumable:juice_up(0.3, 0.5)
				end
				return true
			end,
		}))
		delay(0.6)
	end,
}

SMODS.Consumable{
	key = 'poly',
	set = 'Spectral',
	pos = {x = 0, y = 1},
	atlas = "TsunamiTarot",
	name = "tsunamipoly",
	discovered = true,
	cost = 8,
	loc_txt = {
		name = "Polymorph",
		text = {
			"Creates {C:blue}Splash{} and one {C:attention}random non-legendary",
			"joker that can {C:attention}fuse{} with {C:blue}Splash",
			"{C:attention}-1 Hand Size",
			"{C:inactive}(Must have room)"
		},
	},
	config = {extra = 2},
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
					local splashspectral = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
					splashspectral:add_to_deck()
					G.jokers:emplace(splashspectral)
					local splashspectral2 = SMODS.create_card({area = G.jokers, key = pseudorandom_element(Splashkeytable2, pseudoseed('splashjoker'))})
					splashspectral2:add_to_deck()
					G.jokers:emplace(splashspectral2)
					used_consumable:juice_up(0.3, 0.5)
					G.hand:change_size(-1)
				end
				return true
			end,
		}))
		delay(0.6)
	end,
}


	SMODS.Back{
		key = "splashdeck",
		pos = {x = 6, y = 10},
		unlocked = true,
		discovered = true,
		config = {dollars = 5},
		atlas = "TsunamiDecks",
		loc_txt = {
			name = "Splash Deck",
			text = {
				"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal",
				"copies of {C:blue}Splash {}and{C:attention} $5",
			}},
		loc_vars = function(self)
			return {vars = {self.config.extra}}
		end,
		apply = function(self)
			G.E_MANAGER:add_event(Event({
				func = function()
					local splashdeckcard = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
					splashdeckcard:add_to_deck()
					splashdeckcard:set_edition({negative = true})
					splashdeckcard:set_eternal(true)
					G.jokers:emplace(splashdeckcard)
					local splashdeckcard2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
					splashdeckcard2:add_to_deck()
					splashdeckcard2:set_edition({negative = true})
					splashdeckcard2:set_eternal(true)
					G.jokers:emplace(splashdeckcard2)
					return true
				end
			}))
		end
	}
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------CROSSMOD FUSIONS----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
---
if Is_Cryptid == true and Cryptid.enabled["Epic Jokers"] then
	SMODS.Joker{
		name = "Still Water",
		key = "still_water",
		pos = { x = 0, y = 16 },
		loc_txt = {
			name = "Still Water",
			text = {
				"{C:edition,E:1}you cannot{} {C:cry_ascendant,E:1}swim...{}",
				"{C:edition,E:1}you do not{} {C:cry_ascendant,E:1}float...{}",
				"{C:dark_edition,E:1}you cannot breathe...{}",
				"{C:inactive}(Must have room){}",
				"{s:0.7}{C:inactive}(Sob + Splash){}",
			},
		},
		rarity = 5,
		cost = 9,
		discovered = true,
		perishable_compat = true,
		atlas = "Tsunami",
		calculate = function(self, card, context)
			if
				context.selling_self
				and #G.jokers.cards + G.GAME.joker_buffer <= G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.discard
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.pre_discard
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.reroll_shop
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.open_booster
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.buying_card
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.skip_blind
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.cardarea == G.jokers
				and context.before
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.using_consumeable
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.selling_card
				and context.card.ability.name ~= "Obelisk"
				and #G.jokers.cards + G.GAME.joker_buffer - (context.card.ability.set == "Joker" and 1 or 0) < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.setting_blind
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
			if
				context.skipping_booster
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
				and not context.retrigger_joker
				and not context.blueprint
			then
				local createjoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
				G.GAME.joker_buffer = G.GAME.joker_buffer + createjoker
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
				card:add_to_deck()
				G.jokers:emplace(card)
				G.GAME.joker_buffer = 0
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Splash!",
						colour = G.C.FILTER,
					}),
				}
			end
		end,
		add_to_deck = function(self, card, from_debuff)
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_splash")
			card:set_edition({
				negative = true,
			})
			card:set_eternal(true)
			card:add_to_deck()
			G.jokers:emplace(card)
			return {
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = "Splash!",
					colour = G.C.DARK_EDITION,
				}),
			}
		end,
	}

	FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_cry_curse", nil, false, "j_tsun_still_water", 12)

end
----------------------------------------------
------------MOD CODE END----------------------