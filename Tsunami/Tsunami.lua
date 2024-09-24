--- STEAMODDED HEADER
--- MOD_NAME: Tsunami
--- MOD_ID: Tsunami
--- MOD_AUTHOR: [Maratby]
--- MOD_DESCRIPTION: FUSES EVERY JOKER WITH SPLASH!!!! Eventually. Except for the ones on the front page.
--- BADGE_COLOUR: 0000FF
--- PRIORITY: -9999
--- PREFIX: tsun
----------------------------------------------
------------MOD CODE -------------------------

---This table is sent to the lovely patch in lovely.toml and enables these jokers to use the Splash effect
Splashkeytable = {
	"j_tsun_soaked_joker",
	"j_tsun_dihydrogen_monoxide",
	"j_tsun_raft",
	"j_tsun_watering_can",
}

SMODS.Atlas {
	key = "Tsunami",
	path = "TsunamiJokers.png",
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
		rarity = 5,
		unlocked = true,
		discovered = true,
		blueprint_compat = true,
		pos = {x = 7, y = 0},
		cost = 8,
		config = {extra = 5},
		loc_txt = {
			name = "Soaked Joker",
			text = {
				"Every {C:attention}played card",
				"counts in scoring",
				"{C:red}+5{} Mult per {C:attention}extra{}",
			    "scored cards",
				"{s:0.7}{C:inactive}(Half Joker + Splash){}",
			}
		},
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra}}
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				local size = 0
				local hand_size = {
					["Flush Five"] = 5,
					["Flush House"] = 5,
					["Five of a Kind"] = 5,
					["Straight Flush"] = 5,
					["Four of a Kind"] = 4,
					["Full House"] = 5,
					["Flush"] = 5,
					["Straight"] = 5,
					["Three of a Kind"] = 3,
					["Two Pair"] = 4,
					["Pair"] = 2,
					["High Card"] = 1,
				}
				for k, v in pairs(hand_size) do
					if context.scoring_name == k then
						if (k == "Flush Five" or k == "Flush House" or k == "Straight Flush"
						or k == "Flush" or k == "Straight") and next(find_joker('Shorcut')) then
							size = v - 1
						else
							size = v
						end
						break
					end
				end
				if #context.scoring_hand > size then
					return {
						message = localize{type='variable',key='a_mult',vars={(#context.scoring_hand - size) * card.ability.extra}},
						mult_mod = (#context.scoring_hand - size) * card.ability.extra
					}
				end
			end
		end
	}

	SMODS.Joker{
		key = "raft",
		name = "Raft",
		rarity = 5,
		unlocked = true,
		discovered = true,
		blueprint_compat = true,
		pos = {x = 0, y = 11},
		cost = 8,
		config = {extra = 5},
		ability_name = "raft",
		loc_txt = {
			name = "Raft",
			text = {
				"Every {C:attention}played card",
				"counts in scoring and permanently",
        		"gains {C:chips}+5{} Chips when scored",
				"This effect applies {C:attention}twice on {C:attention}extra played cards",
				"{s:0.7}{C:inactive}(Hiker + Splash){}",
			}
		},
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play then
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra
					card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
				end
			if context.individual and context.cardarea == G.play then
				local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
				for k, v in ipairs(scoring_hand) do
					if context.other_card == scoring_hand[k] then
						Splashflag = true
						end
					end
					if Splashflag == false then
						context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
						context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra
						return {
							extra = {message = "Raft!", colour = G.C.CHIPS},
							colour = G.C.CHIPS,
							card = self
							}
					else
						Splashflag = false
			end
		end
	end
}


	FusionJokers.fusions:add_fusion("j_splash", nil, false, "j_hiker", nil, false, "j_tsun_raft", 10)

	SMODS.Joker {
		loc_txt = {
			name = "Dihydrogen Monoxide",
			text = {
				"Every {C:attention}played card {C:black}counts in scoring",
				"Each played {C:attention}Ace{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8{} gives",
				"{C:mult}+3{} Mult for each card",
				"in the scoring hand",
				"{s:0.7}{C:inactive}(Fibonacci + Splash){}",
			}},
			rarity = 5,
			cost = 8,
			config = { extra = { mult = 3 } },
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
			"Every {C:attention}played card {C:black}counts in scoring",
			"Gives {X:mult,C:white} X1.5 {} Mult for each unique",
			"{C:attention}suit {C:black}in {C:attention}played hand",
			"{s:0.7}{C:inactive}(Flower Pot + Splash){}",
		}},
		rarity = 5,
		cost = 8,
		config = { extra = 1.5 },
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
				"copies of {C:blue}Splash {C:black}and{C:attention} $5",
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
----------------------------------------------
------------MOD CODE END----------------------