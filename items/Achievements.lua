---Achievements..?

SMODS.achievement {
	key = "invest_team",
	bypass_all_unlocked = false,
	order = 1,
	atlas = "tsun_achievements",
	hidden_pos = { x = 0, y = 0 },
	pos = { x = 0, y = 1 },
	unlock_condition = function(self, args)
		if G.jokers and args.tsun_endround_achievements then
			if #SMODS.find_card("j_tsun_tsunami_yu") >= 1
				and #SMODS.find_card("j_tsun_tsunami_marie") >= 1
				and #SMODS.find_card("j_tsun_tsunami_yosuke") >= 1
				and #SMODS.find_card("j_tsun_tsunami_chie") >= 1
				and #SMODS.find_card("j_tsun_tsunami_rise") >= 1 then
				return true
			end
		end
	end
}


