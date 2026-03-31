SMODS.Atlas {
    key = "TsunamiSleeves",
    path = "TsunamiSleeves.png",
    px = 73,
    py = 95
}

---Hook for Splash Sleeve + Abandoned Deck effect
---or
local tsunbackapply = Back.apply_to_run
function Back:apply_to_run()
    if (get_current_deck_fallback() == "b_abandoned" or get_current_deck_fallback() == "b_sdm_deck_of_stuff") and G.GAME.selected_sleeve == "sleeve_tsun_splash" then
        G.E_MANAGER:add_event(Event({
            func = function()
                for index, value in pairs(G.playing_cards) do
                    if value:get_id() == 2 or value:get_id() == 3 then
                        value:start_dissolve()
                    end
                end
                return true
            end
        }))
    end
    if (get_current_deck_fallback() == "b_sdm_lucky_7" or get_current_deck_fallback() == "b_sdm_deck_of_stuff") and G.GAME.selected_sleeve == "sleeve_tsun_splash" then
        G.E_MANAGER:add_event(Event({
            func = function()
                for index, value in pairs(G.playing_cards) do
                    if value:get_id() == 14 then
                        value:set_ability(G.P_CENTERS.m_lucky)
                    end
                end
                return true
            end
        }))
    end
    return tsunbackapply(self)
end

CardSleeves.Sleeve {
    key = "splash",
    atlas = "TsunamiSleeves",
    pos = { x = 0, y = 0 },
    config = { extra = 2, dollars = 5, extrascored_tally = 0 },
    loc_vars = function(self)
        local key
        ---Vanilla Decks
        if self.get_current_deck_key() == "b_red" then
            key = self.key .. "_alt_red"
        elseif self.get_current_deck_key() == "b_blue" then
            key = self.key .. "_alt_blue"
        elseif self.get_current_deck_key() == "b_yellow" then
            key = self.key .. "_alt_yellow"
        elseif self.get_current_deck_key() == "b_green" then
            key = self.key .. "_alt_green"
        elseif self.get_current_deck_key() == "b_black" then
            key = self.key .. "_alt_black"
        elseif self.get_current_deck_key() == "b_magic" then
            key = self.key .. "_alt_magic"
        elseif self.get_current_deck_key() == "b_nebula" then
            key = self.key .. "_alt_nebula"
        elseif self.get_current_deck_key() == "b_ghost" then
            key = self.key .. "_alt_ghost"
        elseif self.get_current_deck_key() == "b_abandoned" then
            key = self.key .. "_alt_abandoned"
        elseif self.get_current_deck_key() == "b_checkered" then
            key = self.key .. "_alt_checkered"
        elseif self.get_current_deck_key() == "b_zodiac" then
            key = self.key .. "_alt_zodiac"
        elseif self.get_current_deck_key() == "b_painted" then
            key = self.key .. "_alt_painted"
        elseif self.get_current_deck_key() == "b_anaglyph" then
            key = self.key .. "_alt_anaglyph"
        elseif self.get_current_deck_key() == "b_plasma" then
            key = self.key .. "_alt_plasma"
        elseif self.get_current_deck_key() == "b_erratic" then
            key = self.key .. "_alt_erratic"

            ---Tsunami Floatie Deck
        elseif self.get_current_deck_key() == "b_tsun_floatiedeck" then
            key = self.key .. "_alt_floatie"

            ---"SDM_0's Stuff" Decks
        elseif self.get_current_deck_key() == "b_sdm_0_s" then
            key = self.key .. "_alt_sdm_sdm0s"
        elseif self.get_current_deck_key() == "b_sdm_bazaar" then
            key = self.key .. "_alt_sdm_bazaar"
        elseif self.get_current_deck_key() == "b_sdm_sandbox" then
            key = self.key .. "_alt_sdm_sandbox"
        elseif self.get_current_deck_key() == "b_sdm_lucky_7" then
            key = self.key .. "_alt_sdm_lucky7"
        elseif self.get_current_deck_key() == "b_sdm_dna" then
            key = self.key .. "_alt_sdm_dna"
        elseif self.get_current_deck_key() == "b_sdm_hieroglyph" then
            key = self.key .. "_alt_sdm_hiero"
        elseif self.get_current_deck_key() == "b_sdm_xxl" then
            key = self.key .. "_alt_sdm_xxl"
        elseif self.get_current_deck_key() == "b_sdm_hoarder" then
            key = self.key .. "_alt_sdm_hoarder"
        elseif self.get_current_deck_key() == "b_sdm_deck_of_stuff" then
            key = self.key .. "_alt_sdm_stuff"
            ---Sauhonghu Decks (Most likely just Tsaunami Deck)
        elseif self.get_current_deck_key() == "b_skh_tsaunami" then
            key = self.key .. "_alt_skh_tsaunami"
        else
            key = self.key
        end
        return { key = key, vars = { self.config.extra, self.config.dollars, self.config.extrascored_tally } }
    end,
    unlocked = false,
    unlock_condition = { deck = "b_tsun_splashdeck", stake = "stake_blue" },
    apply = function(self)
        G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + self.config.dollars
        G.E_MANAGER:add_event(Event({
            func = function()
                if not (self.get_current_deck_key() == "b_sdm_deck_of_stuff"
                        or self.get_current_deck_key() == "b_sdm_0_s"
                        or self.get_current_deck_key() == "b_sdm_bazaar"
                        or self.get_current_deck_key() == "b_sdm_sandbox"
                        or self.get_current_deck_key() == "b_sdm_lucky_7"
                        or self.get_current_deck_key() == "b_sdm_dna"
                        or self.get_current_deck_key() == "b_sdm_hieroglyph"
                        or self.get_current_deck_key() == "b_sdm_xxl")
                then
                    create_splash("e_negative", true)
                    create_splash("e_negative", true)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_sdm_0_s" then
                    create_splash("e_negative", true)
                    create_splash_fusion(nil, true)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_tsun_floatiedeck" then
                    G.GAME.interest_amount = 2
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_erratic" then
                    create_splash_material(nil, true)
                    create_splash_material(nil, true)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_green" then
                    G.GAME.modifiers.no_interest = false
                    G.GAME.interest_cap = 0
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_tsun_floatiedeck" then
                    SMODS.change_discard_limit(1)
                    SMODS.change_play_limit(1)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_sdm_bazaar" then
                    tsun_create_items(2)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_sdm_lucky_7" then
                    local _card = SMODS.create_card({
                        area = G.jokers,
                        key = "j_tsun_g_ship"
                    })
                    _card.ability.eternal = true
                    _card:add_to_deck()
                    G.jokers:emplace(_card)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_sdm_sandbox" then
                    tsun_create_items(2, "aeon", true)
                    tsun_create_items(1, "voucher", false)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_sdm_hieroglyph" then
                    tsun_create_items(1, "polymorph", false)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_sdm_xxl" then
                    G.GAME.modifiers.money_per_hand = 2
                end
                return true
            end
        }))
    end,
    calculate = function(self, sleeve, context)
        local temphandsize = 0
        if context.selling_card and not context.blueprint and context.card.ability.set == 'Joker' then
            if context.card.config.center.key == "j_splash" then
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_red" then
                    ease_discard(1)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_blue" then
                    ease_hands_played(1)
                end
                if self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_green" then
                    G.GAME.interest_cap = G.GAME.interest_cap + 5
                end
            end
        end
        if context.selling_card and not context.blueprint and context.card.ability.set == 'Joker' then
            if context.card.config.center.mod and context.card.config.center.mod.id == "Tsunami" and (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_sdm_dna") then
                split_fusion(context.card.config.center.key, true, false)
            end
        end
        if
            (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_magic")
            and (#G.jokers.cards <= (G.jokers.config.card_limit - 1))
            and context.using_consumeable
            and context.consumeable.ability.set == "Tarot"
            and not context.consumeable.beginning_end then
            create_splash()
        end
        if
            (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_nebula")
            and (#G.jokers.cards <= (G.jokers.config.card_limit - 1))
            and context.using_consumeable
            and context.consumeable.ability.set == "Planet"
            and not context.consumeable.beginning_end then
            create_splash()
        end
        if
            (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_ghost")
            and #G.jokers.cards <= (G.jokers.config.card_limit - 1)
            and context.using_consumeable
            and context.consumeable.ability.set == "Spectral"
            and not context.consumeable.beginning_end then
            local _edition = poll_edition("bubble", nil, true, true, { "e_foil", "e_holo", "e_polychrome" })
            create_splash(_edition)
        end
        if context.before and (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_painted") then
            for i = 1, #G.hand.cards do
                table.insert(context.scoring_hand, G.hand.cards[i])
            end
        end
        if context.before and next(context.poker_hands['Flush']) and (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_checkered") and #G.jokers.cards <= (G.jokers.config.card_limit - 1) then
            create_splash()
        end
        if context.open_booster and (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_zodiac") then
            if G.GAME.pack_choices and SMODS.OPENED_BOOSTER and (SMODS.OPENED_BOOSTER.config.center.kind == 'Tarot' or SMODS.OPENED_BOOSTER.config.center.kind == 'Planet') then
                G.GAME.pack_choices = G.GAME.pack_choices + 1
            end
        end
        if context.open_booster and (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_sdm_hieroglyph") then
            if G.GAME.pack_choices and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'Spectral' then
                G.GAME.pack_choices = G.GAME.pack_choices + 1
            end
        end
        if context.individual and context.cardarea == G.play and (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_anaglyph") then
            if card_is_splashed(context.other_card) == true then
                self.config.extrascored_tally = self.config.extrascored_tally + 1
            end
        end
        if context.after and self.config.extrascored_tally >= 20 then
            G.E_MANAGER:add_event(Event({
                blockable = true,
                blocking = true,
                func = function()
                    add_tag(Tag("tag_double"))
                    self.config.extrascored_tally = self.config.extrascored_tally - 20
                    return true
                end
            }))
        end
        if context.after and (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_plasma") then
            local numlist = {}
            for index, value in ipairs(context.full_hand) do
                if card_is_splashed(value) then
                    table.insert(numlist, value:get_id())
                end
            end
            local rankmean = tsun_sum_table(numlist) / #numlist
            rankmean = math.floor(rankmean + 0.5)
            for index, value2 in ipairs(context.full_hand) do
                if card_is_splashed(value2) then
                    G.E_MANAGER:add_event(Event({
                        blockable = true,
                        blocking = true,
                        func = function()
                            if not (rankmean > 14 or rankmean < 2) then
                                SMODS.change_base(value2, nil, tostring(rankmean))
                            elseif rankmean == value2:get_id() then
                                ---pass
                            else
                                SMODS.change_base(value2, nil, "7")
                            end
                            return true
                        end
                    }))
                end
            end
            card_eval_status_text(G.deck, 'extra', nil, nil, nil,
                { message = localize('k_balanced'), colour = G.C.DARK_EDITION })
        end
        if context.repetition and context.cardarea == G.play and (self.get_current_deck_key() == "b_sdm_deck_of_stuff" or self.get_current_deck_key() == "b_skh_tsaunami") then
            local fusion_retrig = 0
			for index, value in ipairs(Splashkeytable) do
                if next(SMODS.find_card(value)) then
                    fusion_retrig = fusion_retrig + 1
                end
            end
			return {
				message = localize("k_again_ex"),
				repetitions = fusion_retrig,
			}
		end
    end
}

CardSleeves.Sleeve {
	key = "floatiesleeve",
	pos = { x = 1, y = 0 },
	unlocked = true,
	discovered = true,
	config = { hands = 1, discards = 1, hand_size = 2, joker_slot = 2, extra = { win_ante = 8 } },
	atlas = "TsunamiSleeves",
	loc_vars = function(self)
		return { vars = { self.config.hands, self.config.joker_slot, self.config.extra.win_ante } }
	end,
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.win_ante = G.GAME.win_ante + self.config.extra.win_ante
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.config.joker_slot
                G.jokers.config.card_limit = G.jokers.config.card_limit + self.config.joker_slot
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + self.config.discards
                ease_discard(self.config.discards)
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.config.hands
                ease_hands_played(self.config.hands)
                G.hand:change_size(2)
				return true
			end
		}))
	end
}