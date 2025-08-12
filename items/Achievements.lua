---Achievements..!

SMODS.Achievement {
	key = "splash_fan",
	bypass_all_unlocked = true,
	order = 1,
	hidden_name = false,
	hidden_text = false,
	atlas = "tsun_achievements",
	hidden_pos = { x = 6, y = 0 },
	pos = { x = 5, y = 0 },
	unlock_condition = function(self, args)
		if args.type == "tsunami_endround" then
			local unga = tsun_top_10(false)
			return unga
		end
	end
}

SMODS.Achievement {
	key = "invest_team",
	bypass_all_unlocked = true,
	order = 2,
	hidden_name = false,
	hidden_text = true,
	atlas = "tsun_achievements",
	hidden_pos = { x = 6, y = 0 },
	pos = { x = 0, y = 0 },
	unlock_condition = function(self, args)
		if args.type == "tsunami_endround" then
			if G.jokers then
				if #SMODS.find_card("j_tsun_tsunami_yu") >= 1
					and #SMODS.find_card("j_tsun_tsunami_marie") >= 1
					and #SMODS.find_card("j_tsun_tsunami_yosuke") >= 1
					and #SMODS.find_card("j_tsun_tsunami_chie") >= 1
					and #SMODS.find_card("j_tsun_tsunami_rise") >= 1 then
					return true
				end
			end
		end
	end
}

SMODS.Achievement {
	key = "true_ending",
	bypass_all_unlocked = true,
	order = 3,
	hidden_name = false,
	hidden_text = true,
	atlas = "tsun_achievements",
	hidden_pos = { x = 6, y = 0 },
	pos = { x = 1, y = 0 },
	unlock_condition = function(self, args)
		if args.type == "tsunami_endround" then
			local ach_flag = true
			if G.jokers then
				if #SMODS.find_card("j_tsun_tsunami_yu") >= 1 and #SMODS.find_card("j_tsun_tsunami_marie") >= 1 then
					for _, value in ipairs(G.jokers.cards) do
						if value.config.center.rarity ~= 1 and (value.config.center.key ~= "j_tsun_tsunami_yu" and value.config.center.key ~= "j_tsun_tsunami_marie") then
							ach_flag = false
						end
					end
					if ach_flag == true then
						return true
					end
				end
			end
		end
	end
}

SMODS.Achievement {
	key = "min_wage",
	bypass_all_unlocked = true,
	order = 4,
	hidden_name = false,
	hidden_text = true,
	atlas = "tsun_achievements",
	hidden_pos = { x = 6, y = 0 },
	pos = { x = 2, y = 0 },
	unlock_condition = function(self, args)
		if args.type == "tsunami_endshop" then
			if G.jokers then
				if #SMODS.find_card("j_tsun_tsunami_yosuke") >= 1 and to_number(G.GAME.dollars) <= -100 then
					return true
				end
			end
		end
	end
}

SMODS.Achievement {
	key = "solo_performance",
	bypass_all_unlocked = true,
	order = 5,
	hidden_name = false,
	hidden_text = true,
	atlas = "tsun_achievements",
	hidden_pos = { x = 6, y = 0 },
	pos = { x = 3, y = 0 },
	unlock_condition = function(self, args)
		if args.type == "tsunami_endround" then
			if G.jokers then
				if #SMODS.find_card("j_tsun_tsunami_rise") >= 1 and #G.jokers.cards == 1 then
					return true
				end
			end
		end
	end
}



---You looked, you motherfucker. Alright, go on, get outta here.
SMODS.Achievement {
	key = "dragon_trial",
	bypass_all_unlocked = true,
	order = 6,
	hidden_name = false,
	reset_on_startup = true, ---REMEMBER TO REMOVE THIS ON RELEASE!!!
	hidden_text = true,
	atlas = "tsun_achievements",
	hidden_pos = { x = 6, y = 0 },
	pos = { x = 4, y = 0 },
	unlock_condition = function(self, args)
		if args.type == "tsun_dragontrial" then
			local ach_flag = true
			if G.jokers then
				---YOU LOOKED, YOU FOOL! THUNDER CROSS SPLIT ATTACK!
			end
		end
	end
}

Tsun_Fuseflag = false
---actually triggering the achievements
local end_round_ref = end_round
function end_round()
	Tsun_Fuseflag = false
	GY_IExist = false
	check_for_unlock { type = 'tsunami_endround' }
	end_round_ref()
end

local toggle_shop_ref = G.FUNCS.toggle_shop
function G.FUNCS.toggle_shop(e)
	check_for_unlock { type = "tsunami_endshop" }
	toggle_shop_ref(e)
end

local start_run_ref = Game.start_run
function Game:start_run(...)
	local ret = start_run_ref(self, ...)
	GY_IExist = false
	return ret
end

---making achievement #6 more robust
local fuse_card_ref = fuse_card
function fuse_card()
	Tsun_Fuseflag = true
	fuse_card_ref()
	G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1,
                func = function()
                    Tsun_Fuseflag = false
                return true end }))
end
