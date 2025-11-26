---This file exists solely to be loaded after all other code in my mod has run.
---This makes the auto register functional with Gold Fusions and Legendary Fusions.
auto_register(TsunamiAutoRegister)

SMODS.Rarity {
	key = "tsun_gold_legendary",
	default_weight = 0,
	badge_colour =  SMODS.Gradients.tsun_gradient_gold,
	pools = { ["Joker"] = false },
	get_weight = function(self, weight, object_type)
		return weight
	end,
}