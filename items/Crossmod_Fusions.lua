---Crossmod Fusions ONLY

if Tsun_has_Morefluff then
    SMODS.Joker {
        name = "Style Marieter",
        key = "style_marieter",
        rarity = "fusion",
        cost = 16,
        config = { dollars = 1, dollars2 = 10, final = 1 },
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = "Tsunami",
        pos = { x = 0, y = 16 },
        ability_name = "Style Marieter",
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.dollars, card.ability.dollars2 } }
        end,
        calculate = function(self, card, context)
            card.ability.dollars2 = card.ability.dollars * 10
            if context.before then
                if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "marie") then
                    card.ability.final = card.ability.dollars2
                else
                    card.ability.final = card.ability.dollars
                end
            end
            if context.individual and context.cardarea == G.play then
                if card_is_splashed(context.other_card) then
                    return {
                        dollars = card.ability.final
                    }
                end
            end
        end
    }
    FusionJokers.fusions:register_fusion{
      jokers = {
        { name = "j_mf_basepaul_card" },
        { name = "j_splash" },
      }, cost = 12, result_joker = "j_tsun_style_marieter" 
    }

    SMODS.Joker {
        name = "Waterfall Loop",
        key = "waterfall_loop",
        config = { extra = 1 },
        rarity = "fusion",
        cost = 10,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = "Tsunami",
        pos = { x = 1, y = 16 },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra } }
        end,
        add_to_deck = function(self, card, from_debuff)
            G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra
            SMODS.change_discard_limit(card.ability.extra)
            SMODS.change_play_limit(card.ability.extra)
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra
            SMODS.change_discard_limit(-card.ability.extra)
            SMODS.change_play_limit(-card.ability.extra)
            G.hand:unhighlight_all()
        end
    }
    FusionJokers.fusions:register_fusion{
      jokers = {
        { name = "j_mf_philosophical" },
        { name = "j_splash" },
      }, cost = 10, result_joker = "j_tsun_waterfall_loop" 
    }
end

---insert picture of obama giving himself a medal
if Jokebox then
    FusionJokers.fusions:register_fusion{
      jokers = {
        { name = "j_jkbx_marie" },
        { name = "j_splash" },
      }, cost = 10, result_joker = "j_tsun_tsunami_marie" 
    }
end
