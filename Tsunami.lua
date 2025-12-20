------------MOD CODE -------------------------

--- i had to make the priority higher than cryptid to get crossmod fusion to work
--- switched to json metadata finally

Tsunami = {}
Tsunami_Mod = SMODS.current_mod
Tsunami_Config = Tsunami_Mod.config

--- Checking for loaded mods, for the crossmod fusions
if next(SMODS.find_mod("Cryptid")) and Tsunami_Config.TsunamiXMod == true then
	Tsun_has_Cryptid = true
else
	Tsun_has_Cryptid = false
end

if next(SMODS.find_mod("MoreFluff")) and Tsunami_Config.TsunamiXMod == true then
	Tsun_has_Morefluff = true
else
	Tsun_has_Morefluff = false
end

---It's a surprise tool that'll help Chie later
---Overflow is a newgen replacement for Incantation - I will support both just in case.
if next(SMODS.find_mod("Incantation")) or Overflow then
	Tsun_has_Incantation = true
else
	Tsun_has_Incantation = false
end

---enter an edition in _edition to set edition, enter true or false in eternal to set eternal
function create_splash(_edition, eternal)
	local _card = SMODS.create_card({
		area = G.jokers,
		key = "j_splash"
	})
	if _edition == "e_negative" or _edition == "negative" then
		_card:set_edition({ negative = true }, nil)
		_card.edition.negative = true
	end
	if eternal then
		_card.ability.eternal = true
	end
	_card:add_to_deck()
	G.jokers:emplace(_card)
	return _card
end

---enter an edition in _edition to set edition, enter true or false in eternal to set eternal
function create_splash_fusion(_edition, eternal)
	local _card = SMODS.create_card({
		area = G.jokers,
		key = pseudorandom_element(
			Splashvouchertable, pseudoseed('randsplashjoker'))
	})
	if _edition then
		_card:set_edition(_edition)
	end
	if eternal then
		_card.ability.eternal = true
	end
	_card:add_to_deck()
	G.jokers:emplace(_card)
	return _card
end

---enter an edition in _edition to set edition, enter true or false in eternal to set eternal
function create_splash_material(_edition, eternal)
	local _card = SMODS.create_card({
		area = G.jokers,
		key = pseudorandom_element(
			Splashkeytable2, pseudoseed('randsplashjoker'))
	})
	if _edition then
		_card:set_edition(_edition)
	end
	if eternal then
		_card.ability.eternal = true
	end
	_card:add_to_deck()
	G.jokers:emplace(_card)
	return _card
end

---thank you dilly the dillster from dillatro
function tsun_top_10(printall)
	local profile = G.PROFILES[G.SETTINGS.profile]
	local usage_data = profile.joker_usage

	-- Create sorted list of all jokers by usage count
	local joker_counts = {}
	for k, v in pairs(usage_data) do
		local count = (type(v) == "table" and v.count) or 0
		table.insert(joker_counts, { key = k, count = count })
	end

	-- Sort by count (highest first)
	table.sort(joker_counts, function(a, b) return a.count > b.count end)

	-- Get top 10
	local top_10 = {}
	for i = 1, math.min(10, #joker_counts) do
		table.insert(top_10, joker_counts[i])
	end
	if printall then
		print("=== TOP 10 JOKERS ===")
		for i, joker_data in ipairs(top_10) do
			print(i .. ". " .. joker_data.key .. " (" .. joker_data.count .. " uses)")
		end
		print("====================")
	end

	-- Check if j_splash is in top 10 AND find its overall position
	local splash_in_top_10 = false
	local splash_position = nil
	local splash_overall_position = nil

	-- Find j_splash's overall position in the full sorted list
	for i, joker_data in ipairs(joker_counts) do
		if joker_data.key == "j_splash" then
			splash_overall_position = i
			break
		end
	end

	-- Check if it's in top 10
	for i, joker_data in ipairs(top_10) do
		if joker_data.key == "j_splash" then
			splash_in_top_10 = true
			splash_position = i
			break
		end
	end
	if printall then
		print("=== J_SPLASH STATUS ===")
		if splash_in_top_10 then
			print("j_splash IS in top 10 at position: " .. splash_position)
			print("Boolean splash_in_top_10 = TRUE")
		else
			if splash_overall_position then
				print("j_splash is NOT in top 10")
				print("j_splash overall position: " .. splash_overall_position .. " out of " .. #joker_counts)
			else
				print("j_splash was never used (not found in usage data)")
			end
			print("Boolean splash_in_top_10 = FALSE")
		end
		print("=======================")
	end
	return splash_in_top_10
end

---function for merging tables, mostly used for Gold Rise. MOVES VALUES FROM TABLE1 TO TABLE2!!!!	
function tsun_table_merge(table1, table2)
	for _, value in ipairs(table1) do
		table.insert(table2, value)
	end
end

function Tsunami.change_card(card_object, new_card_key, transfer_ability, extra)
	local old_ability = 0
	if transfer_ability then
		if extra then
			old_ability = card_object.ability.extra[transfer_ability]
		else
			old_ability = card_object.ability[transfer_ability]
		end
	end
	card_object:set_ability(G.P_CENTERS[new_card_key])
	if transfer_ability then
		if extra then
			card_object.ability.extra[transfer_ability] = old_ability
		else
			card_object.ability[transfer_ability] = old_ability
		end
	end
	card_object:juice_up()
end

---I can't use the CardSleeves method for this outside of a Sleeve. But I need to.
function get_current_deck_fallback()
	if Galdur and Galdur.config.use and Galdur.run_setup.choices.deck then
		return Galdur.run_setup.choices.deck.effect.center.key
	elseif G.GAME.viewed_back and G.GAME.viewed_back.effect then
		return G.GAME.viewed_back.effect.center.key
	elseif G.GAME.selected_back and G.GAME.selected_back.effect then
		return G.GAME.selected_back.effect.center.key
	end
	return "b_red"
end

function tsun_redeem_voucher(local_voucher, _delay)
	local voucher_card = SMODS.create_card({ area = G.play, key = local_voucher })
	voucher_card:start_materialize()
	voucher_card.cost = 0
	G.play:emplace(voucher_card)
	delay(0.3)
	voucher_card:redeem()
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = _delay or 0.8,
		func = function()
			voucher_card:start_dissolve()
			return true
		end
	}))
end

function tsun_sum_table(t)
	local sum = 0
	for index, value in pairs(t) do
		sum = sum + value
	end
	return sum
end

if CardSleeves then
	SMODS.load_file("items/Sleeves.lua")()
end


---Functionality stuff for CardSleeves
SMODS.Joker:take_ownership("splash", {
	discovered = true,
	add_to_deck = function(self, card, from_debuff)
		if CardSleeves and (get_current_deck_fallback() == "b_sdm_deck_of_stuff" or get_current_deck_fallback() == "b_black") and G.GAME.selected_sleeve == "sleeve_tsun_splash" then
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
			---This is... The strangest bug I've ever had.
			---Splash was retriggering every extra scored card, right?
			---So I add a dummy calculate function to stop it.
			---That makes it not retrigger, but now Negative Splashes don't give joker slots???
		end
		if CardSleeves and (get_current_deck_fallback() == "b_sdm_deck_of_stuff" or get_current_deck_fallback() == "b_painted") and G.GAME.selected_sleeve == "sleeve_tsun_splash" then
			SMODS.change_discard_limit(1)
			SMODS.change_play_limit(1)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if CardSleeves and (get_current_deck_fallback() == "b_sdm_deck_of_stuff" or get_current_deck_fallback() == "b_black") and G.GAME.selected_sleeve == "sleeve_tsun_splash" then
			G.jokers.config.card_limit = G.jokers.config.card_limit - 1
		end
		if CardSleeves and (get_current_deck_fallback() == "b_sdm_deck_of_stuff" or get_current_deck_fallback() == "b_painted") and G.GAME.selected_sleeve == "sleeve_tsun_splash" then
			SMODS.change_discard_limit(-1)
			SMODS.change_play_limit(-1)
			G.hand:unhighlight_all()
		end
	end,
	calc_dollar_bonus = function(self, card)
		if CardSleeves and (get_current_deck_fallback() == "b_sdm_deck_of_stuff" or get_current_deck_fallback() == "b_yellow" or get_current_deck_fallback() == "b_sdm_hoarder") and G.GAME.selected_sleeve == "sleeve_tsun_splash" then
			local bonus = 2
			return bonus
		end
	end,
	in_pool = function(self, args)
		return true, { allow_duplicates = true }
	end,

	calculate = function(self, card, context)

	end,
})

---Adds a dummy function that does nothing if Talisman isn't loaded, lets me avoid having Talisman be a dependency
---and avoid crashes if Talisman is loaded
to_big = to_big or function(num)
	return num
end
to_number = to_number or function(num)
	return num
end

---This table is sent to the lovely patch in lovely.toml and enables these jokers to use the Splash effect
Splashkeytable = {
	"j_tsun_youth",
	"j_tsun_soaked_joker",
	"j_tsun_oil_spill",
	"j_tsun_dihydrogen_monoxide",
	"j_tsun_raft",
	"j_tsun_ice_tray",
	"j_tsun_watering_can",
	"j_tsun_vaporwave",
	"j_tsun_webbed_feet",
	"j_tsun_soup",
	"j_tsun_money_laundering",
	"j_tsun_escape_artist",
	"j_tsun_fractured_floodgate",
	"j_tsun_thermos",
	"j_tsun_toaster",
	"j_tsun_puddle",
	"j_tsun_abyssal_tentacles",
	"j_tsun_reflection",
	"j_tsun_surfboard",
	"j_tsun_banana_tree",
	"j_tsun_banana_plantation",
	"j_tsun_holy_water",
	"j_tsun_vending_machine",
	"j_tsun_beach_ball",
	"j_tsun_rainstorm",
	"j_tsun_swimming_trunks",
	"j_tsun_abrasion",
	"j_tsun_waterjet",
	"j_tsun_g_ship",
	"j_tsun_scuba",
	"j_tsun_magical_waterfall",
	"j_tsun_smart_water",
	"j_tsun_hygiene_card",
	"j_tsun_ride_the_sub",
	"j_tsun_wet_floor_sign",
	"j_tsun_deepsea_diver",
	"j_tsun_waterfront_scenery",
	"j_tsun_asset_liquidation",


	"j_tsun_tsunami_yu",
	"j_tsun_tsunami_marie",
	"j_tsun_tsunami_yosuke",
	"j_tsun_tsunami_rise",
	"j_tsun_tsunami_chie",

	"j_tsun_gold_splish_splash",
	"j_tsun_gold_holy_water",
	"j_tsun_gold_reflection",
	"j_tsun_gold_cryomancer",
	"j_tsun_gold_asset_liquidation",

	"j_tsun_gold_tsunami_marie",
	"j_tsun_gold_tsunami_yosuke",
	"j_tsun_gold_tsunami_rise",
	"j_tsun_gold_tsunami_chie",
	"j_tsun_gold_tsunami_yu",
}

---This table is used by the Water SUpply voucher to create a random Splash Fusion Joker
---Gold Fusions and Legendary Fusions excluded
Splashvouchertable = {
	"j_tsun_splish_splash",
	"j_tsun_youth",
	"j_tsun_soaked_joker",
	"j_tsun_oil_spill",
	"j_tsun_dihydrogen_monoxide",
	"j_tsun_raft",
	"j_tsun_ice_tray",
	"j_tsun_watering_can",
	"j_tsun_vaporwave",
	"j_tsun_webbed_feet",
	"j_tsun_soup",
	"j_tsun_money_laundering",
	"j_tsun_escape_artist",
	"j_tsun_fractured_floodgate",
	"j_tsun_thermos",
	"j_tsun_toaster",
	"j_tsun_cryomancer",
	"j_tsun_reflection",
	"j_tsun_surfboard",
	"j_tsun_banana_tree",
	"j_tsun_banana_plantation",
	"j_tsun_holy_water",
	"j_tsun_vending_machine",
	"j_tsun_beach_ball",
	"j_tsun_rainstorm",
	"j_tsun_swimming_trunks",
	"j_tsun_abrasion",
	"j_tsun_waterjet",
	"j_tsun_g_ship",
	"j_tsun_scuba",
	"j_tsun_smart_water",
	"j_tsun_magical_waterfall",
	"j_tsun_hygiene_card",
	"j_tsun_ride_the_sub",
	"j_tsun_wet_floor_sign",
	"j_tsun_deepsea_diver",
	"j_tsun_waterfront_scenery",
	"j_tsun_asset_liquidation",
}

--- This table is used by the Polymorph Spectral to choose a random non-Legendary Splash fusion compatible Joker
--- Other Jokers which create any registered fusion material joker check the Fusionjokers index manually
--- Even though Gold Fusions' materials can fuse with Splash, I excluded it from this list to make the spectral worth something.
Splashkeytable2 = {
	"j_gros_michel",
	"j_half",
	"j_fibonacci",
	"j_misprint",
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
	"j_shoot_the_moon",
	"j_hack",
	"j_seeing_double",
	"j_blackboard",
	"j_jolly",
	"j_loyalty_card",
	"j_8_ball",
	"j_cloud_9",
	"j_trousers",
	"j_stone",
	"j_marble",
	"j_oops",
	"j_midas_mask",
	"j_mystic_summit",
	"j_scholar",
	"j_drivers_license",
	"j_ride_the_bus",
	"j_todo_list",
	"j_space",
	"j_photograph",
	"j_burglar",
}

---List of fusion materials to be excluded from calculation for the Polymorph Spectral
Exclusionlist = {
	"j_splash",
	"j_evo_ripple",
	"j_yorick",
	"j_chicot",
	"j_perkeo",
	"j_triboulet",
	"j_caino",

	"j_tsun_splish_splash",
	"j_tsun_holy_water",
	"j_tsun_reflection",
	"j_tsun_cryomancer",
	"j_tsun_asset_liquidation",

	"j_tsun_tsunami_marie",
	"j_tsun_tsunami_yosuke",
	"j_tsun_tsunami_rise",
	"j_tsun_tsunami_chie",
	"j_tsun_tsunami_yu",
}
Fusionlist = {}

--inserting MoreFluff jokers into lists if you have the mod
if Tsun_has_Morefluff then
	table.insert(Splashkeytable, "j_tsun_waterfall_loop")
	table.insert(Splashkeytable, "j_tsun_style_marieter")

	table.insert(Splashvouchertable, "j_tsun_waterfall_loop")
	table.insert(Splashvouchertable, "j_tsun_style_marieter")

	table.insert(Splashkeytable2, "j_mf_philosophical")
	table.insert(Splashkeytable2, "j_mf_basepaul_card")
end

---Legendary Fusion Rarity
SMODS.Rarity {
	key = "tsun_leg_fusion",
	default_weight = 0,
	badge_colour = G.C.DARK_EDITION,
	pools = { ["Joker"] = false },
	get_weight = function(self, weight, object_type)
		return weight
	end,
}

---Derives from Reverie's function for the same purpose of grabbing all the fusion materials registered, but mine removes duplicates from the Materials list
function Fusionmaterials(materials)
	local materialflag = false
	for _, v in ipairs(FusionJokers.fusions) do
		for _, vv in ipairs(v.jokers) do
			if G.P_CENTERS[vv.name] then
				for _, vvv in ipairs(materials) do
					if vvv == vv.name then
						materialflag = true
					end
				end
				if materialflag == false then
					table.insert(materials, vv.name)
				else
					materialflag = false
				end
			end
		end
		---Removing excluded fusions according to Exclusionlist
		for k, vvvv in ipairs(materials) do
			for k, vvvvv in ipairs(Exclusionlist) do
				if vvvv == vvvvv then
					materials[k] = nil
				end
			end
		end
	end
end

---Function for the Splash Sleeve + SDM_0's Deck DNA effect
---This function should work for any fusion in theory, though.

---Original Key is the key of the joker you are splitting, MUST BE A FUSION JOKER! respect_space is a boolean that makes it ignore joker slots if false. remove_splash makes it not create any Splash when splitting.
function split_fusion(original_key, respect_space, remove_splash)
	local card1 = "j_splash"
	local card2 = "j_splash"
	for index, value in ipairs(FusionJokers.fusions) do
		if value.result_joker == original_key then
			card1 = FusionJokers.fusions[index].jokers[1].name
			card2 = FusionJokers.fusions[index].jokers[2].name
		end
	end
	if card1 == "j_splash" and card2 == "j_splash" then
		return nil
	end
	if not (card1 == "j_splash" and card2 == "j_splash") and (respect_space == false or #G.jokers.cards < G.jokers.config.card_limit) then
		if not (remove_splash == true and card1 == "j_splash") then
			SMODS.add_card({ area = G.jokers, key = card1 })
		end
		if not (remove_splash == true and card2 == "j_splash") then
			SMODS.add_card({ area = G.jokers, key = card2 })
		end
	end
end

---The function that auto-registers Ripple as a Splash Fusion.
---This function is run elsewhere.
---If other extremely Splash-Like Jokers ever exist, I might add them to this list.
TsunamiAutoRegister = {
	"j_evo_ripple",
}
function auto_register(registry)
	for index2, value2 in pairs(registry) do
		for index, value in ipairs(FusionJokers.fusions) do
			local _flag = false
			local recipe = copy_table(value)

			for jokerindex, joker in ipairs(value.jokers) do
				if joker.name == "j_splash" then
					recipe.jokers[jokerindex].name = value2
					_flag = true
				end
			end
			
			if _flag then
				FusionJokers.fusions:register_fusion(recipe)
			end
		end
	end
end

--The function Fountain of Youth and other jokers call when they need a random suit (or two unique random suits if a == 2) selected
---This method should now include modded suits
function tsun_randsuit(a)
	if a == 2 then
		local j = pseudorandom_element(SMODS.Suits, pseudoseed("something"))
		local k = pseudorandom_element(SMODS.Suits, pseudoseed("something"))
		return j.name, k.name
	else
		local j = pseudorandom_element(SMODS.Suits, pseudoseed("something"))
		return j.name
	end
end

---Defining sounds

SMODS.Sound({
	key = "probability_tm",
	path = "lucky.ogg"
})

---Defining each atlas

SMODS.Atlas {
	key = "modicon",
	path = "TsunIcon.png",
	px = 34,
	py = 34,
}
SMODS.Atlas {
	key = "Tsunami",
	path = "TsunamiJokers.png",
	px = 71,
	py = 95,
}
---Separate atlas for Gold Legendary Fusions
SMODS.Atlas {
	key = "TsunamiGoldLegendary",
	path = "gold-legendary.png",
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
	key = "TsunamiEnhancers",
	path = "TsunamiEnhancers.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "TsunamiDecks",
	path = "TsunamiDecks.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "TsunamiVoucher",
	path = "TsunamiVoucher.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "TsunamiTag",
	path = "TsunamiTags.png",
	px = 34,
	py = 34,
}

SMODS.Atlas {
	key = "tsun_achievements",
	path = "Achievements.png",
	px = 66,
	py = 66,
}
---A function for checking if cards were scored by Splash or not. Thanks Eremel
function card_is_splashed(card)
	local _, _, _, scoring_hand, _ = G.FUNCS.get_poker_hand_info(G.play.cards)
	if card.debuff then
		return false
	end
	for _, scored_card in ipairs(scoring_hand) do
		if GMAllExtra == true then
			return true
		end
		if scored_card == card and GMAllExtra == false then
			return false
		end
	end
	return true
end

local canplayref = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
	canplayref(e) ---complete function hook
	if #G.hand.highlighted <= G.GAME.starting_params.play_limit or #SMODS.find_card("j_tsun_holy_water") > 0 or #SMODS.find_card("j_tsun_gold_holy_water") > 0 then
		if #G.hand.highlighted > 5 then
			e.config.colour = G.C.BLUE
			e.config.button = 'play_cards_from_highlighted'
		end
	end
end

---List of Cryptid Stake Keys, allows the sticker_inquisition function to default to Gold if Splash's Stake Sticker is any Cryptid Stake
---I am not doing this for other mods. Cryptid's Stakes are all above Gold (tmk) and the mod is popular enough to add support for it.
Gtsun_Cryptid_Stakelist = {
	"pink",
	"brown",
	"yellow",
	"jade",
	"cyan",
	"gray",
	"crimson",
	"diamond",
	"amber",
	"bronze",
	"quartz",
	"ruby",
	"glass",
	"sapphire",
	"emerald",
	"platinum",
	"verdant",
	"ember",
	"dawn",
	"horizon",
	"blossom",
	"azure",
	"ascendant",

	---Sometimes they have the cry_ prefix so I'm adding both to cover all bases
	"cry_pink",
	"cry_brown",
	"cry_yellow",
	"cry_jade",
	"cry_cyan",
	"cry_gray",
	"cry_crimson",
	"cry_diamond",
	"cry_amber",
	"cry_bronze",
	"cry_quartz",
	"cry_ruby",
	"cry_glass",
	"cry_sapphire",
	"cry_emerald",
	"cry_platinum",
	"cry_verdant",
	"cry_ember",
	"cry_dawn",
	"cry_horizon",
	"cry_blossom",
	"cry_azure",
	"cry_ascendant"
}
---NOBODY EXPECTS THE STICKER INQUISITION
---Returns a sticker rank value which lets me check if the sticker for said center is above a certain stake rather than being equal to a certain stake
function sticker_inquisition(the_center)
	local sticker = get_joker_win_sticker(the_center)
	local rank = 0
	if sticker == "white" then
		rank = 1
	elseif sticker == "red" then
		rank = 2
	elseif sticker == "green" then
		rank = 3
	elseif sticker == "black" then
		rank = 4
	elseif sticker == "blue" then
		rank = 5
	elseif sticker == "purple" then
		rank = 6
	elseif sticker == "orange" then
		rank = 7
	elseif sticker == "gold" then
		rank = 8
	end
	for index, value in ipairs(Gtsun_Cryptid_Stakelist) do
		if sticker == value then
			rank = 8
		end
	end
	return rank
end

---The inverse of the above function, converts stake numbers to keys
function sticker_reverse(_number)
	local rank = "none"
	if _number == 1 then
		rank = "white"
	elseif _number == 2 then
		rank = "red"
	elseif _number == 3 then
		rank = "green"
	elseif _number == 4 then
		rank = "black"
	elseif _number == 5 then
		rank = "blue"
	elseif _number == 6 then
		rank = "purple"
	elseif _number == 7 then
		rank = "orange"
	elseif _number >= 8 then
		rank = "gold"
	end
	return rank
end

SMODS.load_file("items/Fusions.lua")()
SMODS.load_file("items/Not_Jokers.lua")()

if Tsunami_Config.LegendFusions then
	SMODS.load_file("items/Legendary_Fusions.lua")()
	SMODS.load_file("items/Achievements.lua")()
end
if Tsunami_Config.TsunamiXMod then
	SMODS.load_file("items/Crossmod_Fusions.lua")()
end

SMODS.load_file("items/Enhancers.lua")()


---This is defined here because I do not want it to include the Gold Fusions in the materials
Fusionmaterials(Fusionlist)

---Loading this after Fusionmaterials() is called so Gold Fusions don't get counted in materials
if Tsunami_Config.TsunamiLevel2 then
	SMODS.load_file("items/Gold_Fusions.lua")()
end


local tsunlc = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		tsunlc()
	end
	G.ARGS.LOC_COLOURS.tsun_gold1 = HEX("FFD700")
	G.ARGS.LOC_COLOURS.tsun_gold2 = HEX("f6e3c3")
	G.ARGS.LOC_COLOURS.tsun_gold3 = HEX("edd5a9")
	G.ARGS.LOC_COLOURS.tsun_gold4 = HEX("dcbe78")
	G.ARGS.LOC_COLOURS.tsun_gold5 = HEX("d8b162")
	G.ARGS.LOC_COLOURS.tsun_pale = HEX("E1ECF2")

	return tsunlc(_c, _default)
end

SMODS.Gradient {
	key = "tsun_gradient_gold",
	colours = {
		HEX("d8b162"),
		HEX("edd5a9"),
	},
	cycle = 10
}

---Config UI

Tsunami_Mod.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = { align = "m", r = 0.1, padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6 },
		nodes = {
			{ n = G.UIT.R, config = { align = "cl", padding = 0, minh = 0.1 }, nodes = {} },

			{
				n = G.UIT.R,
				config = { align = "cl", padding = 0 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cl", padding = 0.05 },
						nodes = {
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Tsunami_Config, ref_value = "TsunamiXMod" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Cross-Mod Fusions", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},

			{
				n = G.UIT.R,
				config = { align = "cl", padding = 0 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cl", padding = 0.05 },
						nodes = {
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Tsunami_Config, ref_value = "TsunamiLevel2" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Gold Fusions", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},

			{
				n = G.UIT.R,
				config = { align = "cl", padding = 0 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cl", padding = 0.05 },
						nodes = {
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Tsunami_Config, ref_value = "PolyHandScale" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Polymorph scales -Handsize like Ectoplasm", scale = 0.3, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},

			{
				n = G.UIT.R,
				config = { align = "cl", padding = 0 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cl", padding = 0.05 },
						nodes = {
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Tsunami_Config, ref_value = "LegendFusions" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Legendary Fusions", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},

			{
				n = G.UIT.R,
				config = { align = "cl", padding = 0 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cl", padding = 0.05 },
						nodes = {
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Tsunami_Config, ref_value = "TsunRounding" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Round decimal values output from Tsunami Jokers", scale = 0.3, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},

		}
	}
end

---some code was being pedantic about being loaded last so it goes in there now
SMODS.load_file("items/end_of_code.lua")()
----------------------------------------------
------------MOD CODE END----------------------
