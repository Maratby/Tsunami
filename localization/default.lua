return {
	["misc"] = {
		["dictionary"] = {
			["k_probability_tm"] = "Lucky!",
			["k_enhance_tm"] = "Enhanced!",
			["k_change_tm"] = "Change!",

			["k_tsun_leg_fusion"] = "Legendary Fusion",
			["k_tsun_gold_fusion"] = "Gold Fusion",

			["k_mariesave"] = "Saved By Gold Marie",
			["k_yu_cut"] = "Cut!",

			["k_rise_disable"] = "Got your back!",
			["k_rise_random"] = "Random Buff: ",
			["k_rise_failed"] = "Failed to give a Buff, or Buff had no valid targets",
			["k_rise_final_heart"] = "Double all future buffs from this card",
			["k_rise_final_acorn"] = "Creates a Negative copy of a random owned Joker (Rise excluded)",
		},
		["v_dictionary"] = {
			["k_rise_hand"] = "+#1# Hand",
			["k_rise_handsize"] = "+#1# Hand Size",
			["k_rise_discard"] = "+#1# Discard",
			["k_rise_money"] = "Earn $#1# at end of round",
			["k_rise_minus_ante"] = "-#1# Ante",
			["k_rise_pokerhand"] = "Level Up most played poker hand #1# time(s)",
			["k_rise_psychic"] = "+#1# Card Selection Limit",
			["k_rise_retrigger_h"] = "Retrigger Hearts #1# additional time",
			["k_rise_retrigger_s"] = "Retrigger Spades #1# additional time",
			["k_rise_retrigger_d"] = "Retrigger Diamonds #1# additional time",
			["k_rise_retrigger_c"] = "Retrigger Clubs #1# additional time",

			["k_rise_minus_vessel"] = "-#1# Ante, -#1# Ante to Win",
			["k_rise_card_xmult"] = "Played cards give X#1# Mult",
		},
	},
	["descriptions"] = {
		["Back"] = {
			["b_tsun_splashdeck"] = {
				["name"] = "Splash Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal",
					'copies of {C:blue,T:j_splash}Splash {}and{C:attention} $5',
				},
			},
			["b_tsun_floatiedeck"] = {
				["name"] = "Floatie Deck",
				["text"] = {
					"{C:blue}+#1# Hand{},",
					"{C:red}+#1# Discard{},",
					"{C:attention}+#2# Hand Size{},",
					"{C:attention}+#2# Consumable Slots",
					"{C:dark_edition}+#2# Joker Slots",
					"{C:attention}+#3# Ante to Win",
				},
			},
		},
		["Sleeve"] = {
			["sleeve_tsun_splash"] = {
				["name"] = "Splash Sleeve",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal",
					'copies of {C:blue,T:j_splash}Splash {}and{C:attention} $5',
				},
			},
			["sleeve_tsun_splash_alt_red"] = {
				["name"] = "Splash Sleeve | Red Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Sell {C:blue}Splash{} during a {C:attention}Blind to gain {C:attention}1{} temporary {C:red}Discard",
				},
			},
			["sleeve_tsun_splash_alt_blue"] = {
				["name"] = "Splash Sleeve | Blue Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Sell {C:blue}Splash{} during a {C:attention}Blind to gain {C:attention}1{} temporary {C:blue}Hand",
				},
			},
			["sleeve_tsun_splash_alt_yellow"] = {
				["name"] = "Splash Sleeve | Yellow Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"{C:blue}Splash{} earns {C:money}$2{} at end of round",
				},
			},
			["sleeve_tsun_splash_alt_green"] = {
				["name"] = "Splash Sleeve | Green Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"and {C:attention}0{} Interest Cap",
					"Sell {C:blue}Splash{} to increase {C:attention}Interest Cap{} by {C:attention}1",
				},
			},
			["sleeve_tsun_splash_alt_black"] = {
				["name"] = "Splash Sleeve | Black Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"{C:blue}Splash{} gives {C:dark_edition}+1 Joker Slot{}",
				},
			},
			["sleeve_tsun_splash_alt_magic"] = {
				["name"] = "Splash Sleeve | Magic Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Creates {C:blue}Splash{} when a {C:Tarot}Tarot Card{} is used",
					"{C:inactive}(must have room)",
				},
			},
			["sleeve_tsun_splash_alt_nebula"] = {
				["name"] = "Splash Sleeve | Nebula Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Creates {C:blue}Splash{} when a {C:planet}Planet Card{} is used",
					"{C:inactive}(must have room)",
				},
			},
			["sleeve_tsun_splash_alt_ghost"] = {
				["name"] = "Splash Sleeve | Ghost Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Creates a {C:dark_edition}Foil{}, {C:dark_edition}Holographic{} or {C:dark_edition}Polychrome{}",
					"{C:blue,T:j_splash}Splash{} when a {C:spectral}Spectral Card{} is used",
					"{C:inactive}(must have room)",
				},
			},
			["sleeve_tsun_splash_alt_abandoned"] = {
				["name"] = "Splash Sleeve | Abandoned Deck",
				["text"] = {
					"Start run with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue}Splash",
                    "and no {C:attention}2s{} or {C:attention}3s{} in your deck",
				},
			},
			["sleeve_tsun_splash_alt_checkered"] = {
				["name"] = "Splash Sleeve | Checkered Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Creates {C:blue}Splash{} when a {C:attention}Flush{} is played",
					"{C:inactive}(must have room)",
				},
			},
			["sleeve_tsun_splash_alt_zodiac"] = {
				["name"] = "Splash Sleeve | Zodiac Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"You can take {C:attention}1 additional card{}",
					"from {C:purple}Tarot{} and {C:planet}Planet{} Packs",
				},
			},
			["sleeve_tsun_splash_alt_painted"] = {
				["name"] = "Splash Sleeve | Painted Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Every card {C:attention}held in hand {}counts in scoring",
				},
			},
			["sleeve_tsun_splash_alt_anaglyph"] = {
				["name"] = "Splash Sleeve | Anaglyph Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Creates a {C:attention}Double Tag{} every {C:attention}20 Extra Scored Cards{}",
					"{C:inactive}(#3#/20)",
				},
			},
			["sleeve_tsun_splash_alt_plasma"] = {
				["name"] = "Splash Sleeve | Plasma Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Don't Know Yet (Plasma)",
				},
			},
			["sleeve_tsun_splash_alt_erratic"] = {
				["name"] = "Splash Sleeve | Erratic Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"and 2 random {C:attention}Jokers{} with {C:blue}Splash {C:yellow}Fusions",
				},
			},
			["sleeve_tsun_splash_alt_floatie"] = {
				["name"] = "Splash Sleeve | Floatie Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"{C:attention}+1{} Card Selection Limit",
					"{C:money}+$1{} interest per {C:money}$5{} you have when round ends",
				},
			},
			["sleeve_tsun_splash_alt_sdm_sdm0s"] = {
				["name"] = "Splash Sleeve | SDM_0's Deck",
				["text"] = {
					"Start with 1 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"and 1 random {C:attention}Eternal {C:blue}Splash {C:yellow}Fusion",
				},
			},
			["sleeve_tsun_splash_alt_sdm_bazaar"] = {
				["name"] = "Splash Sleeve | Bazaar Deck",
				["text"] = {
					"Start with 2 random {C:attention}Non-Joker{} {C:blue}Tsunami{} items",
					"{C:inactive}(Voucher, Tag, Consumable, etc)"
				},
			},
			["sleeve_tsun_splash_alt_sdm_sandbox"] = {
				["name"] = "Splash Sleeve | Sandbox Deck",
				["text"] = {
					"Start with {C:blue,T:v_tsun_water_supply}Water Supply{} voucher",
					"and two {C:dark_edition}Negative{} {C:purple,T:c_tsun_aeon}Aeon",
				},
			},
			["sleeve_tsun_splash_alt_sdm_lucky7"] = {
				["name"] = "Splash Sleeve | Lucky 7 Deck",
				["text"] = {
					"Start with {C:attention}Eternal{} {C:money,T:j_tsun_g_ship}Gambling Ship",
					"Every starting {C:attention}Ace{} is a {C:attention,T:m_lucky}Lucky Card",
				},
			},
			["sleeve_tsun_splash_alt_sdm_hiero"] = {
				["name"] = "Splash Sleeve | Hieroglyph Deck",
				["text"] = {
					"You can choose {C:attention}1{} additional card",
					"from {C:spectral}Spectral{} Packs",
                    "Start with {C:spectral,T:c_polymorph}Polymorph{}",
				},
			},
			["sleeve_tsun_splash_alt_sdm_dna"] = {
				["name"] = "Splash Sleeve | DNA Deck",
				["text"] = {
					"When a {C:blue,T:j_splash}Splash {C:yellow}Fusion{} is {C:attention}sold,",
					"Create its {C:yellow}Fusion Materials{}",
					"{C:inactive}(must have room)",
				},
			},
			["sleeve_tsun_splash_alt_sdm_xxl"] = {
				["name"] = "Splash Sleeve | XXL Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"Earn {C:money}+$1{} per {C:attention}remaining{} {C:blue}Hand{} when round ends",
				},
			},
			["sleeve_tsun_splash_alt_sdm_hoarder"] = {
				["name"] = "Splash Sleeve | Hoarder Deck",
				["text"] = {
					"Start with 2 {C:dark_edition}Negative{} {C:attention}Eternal {C:blue,T:j_splash}Splash",
					"{C:blue}Splash{} earns {C:money}$2{} at end of round",
				},
			},
			["sleeve_tsun_splash_alt_sdm_stuff"] = {
				["name"] = "Splash Sleeve | Deck of Stuff",
				["text"] = {
					"{C:dark_edition}Combines{} every {C:blue}Splash Sleeve{} effect",
					"{C:inactive}(This deck start is chaotic...)"
				},
			},
			["sleeve_tsun_floatie"] = {
				["name"] = "Floatie Sleeve",
				["text"] = {
					"{C:blue}+#1# Hand{},",
					"{C:red}+#1# Discard{},",
					"{C:attention}+#2# Hand Size{},",
					"{C:attention}+#2# Consumable Slots",
					"{C:dark_edition}+#2# Joker Slots",
					"{C:attention}+#3# Ante to Win",
				},
			},
		},
		["Other"] = {
			["goldmarie_blackstake"] = {
				["name"] = "Black Stake",
				["text"] = {
					"All {C:blue}Splash{} become {C:dark_edition}Negative",
					"at end of round",
					"This joker becomes {C:dark_edition}Negative{}",
					"and {C:attention}Eternal{} when fused",
				},
			},
			["goldmarie_purplestake"] = {
				["name"] = "Purple Stake",
				["text"] = {
					"Played {C:attention}Aces{} and {C:attention}8s{} give {X:mult,C:white}X1.5{} Mult",
					"for each {C:blue}Splash {C:yellow}Fusion{} or {C:blue}Splash",
					"{C:inactive+}{s:0.7}(multiplicative)",
				},
			},
			["goldmarie_whitestake"] = {
				["name"] = "White Stake",
				["text"] = {
					"The {C:attention}Aeon {C:purple}Tarot Card",
					"Creates 1 additional {C:blue}Splash{}",
				},
			},
			["goldmarie_redstake"] = {
				["name"] = "Red Stake",
				["text"] = {
					"{C:attention}Retrigger{} all played",
					"{C:attention}Aces{} and {C:attention}8s{}",
				},
			},
			["goldmarie_goldstake"] = {
				["name"] = "Gold Stake",
				["text"] = {
					"{C:attention}Retrigger{} all played cards",
					"{C:attention}2{} times for each {C:blue}Splash{} or",
					"{C:blue}Splash{} {C:yellow}Fusion{} held",
					"{s:0.7}Counts Splash Evolution from JokerEvolution",
				},
			},
			["goldmarie_orangestake"] = {
				["name"] = "Orange Stake",
				["text"] = {
					"Creates a {C:dark_edition}Negative {C:Tarot}Aeon{}",
					"at end of round",
				},
			},
			["goldmarie_bluestake"] = {
				["name"] = "Blue Stake",
				["text"] = {
					"If you have {C:blue}Splash, {C:red}Prevents",
					"{C:red}Death{} if score is",
					"at least {C:attention}25% of Chips{}",
					"then {C:red}destroys{} all {C:blue}Splash",
					"{C:attention}{s:0.7}Eternal {C:blue}{s:0.7}Splash{}{s:0.7} lose {C:attention}{s:0.7}Eternal{} {s:0.7}instead",
				},
			},
			["goldmarie_greenstake"] = {
				["name"] = "Green Stake",
				["text"] = {
					"Doubles all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}2 in 3{C:inactive})"
				},
			},
		},
		["Joker"] = {
			["j_tsun_vaporwave"] = {
				["name"] = "Vaporwave",
				["text"] = {
					"Every {C:attention}played card {}counts in scoring",
					"Gains {X:mult,C:white}X#2#{} Mult when {C:attention}Blind{} is skipped",
					"{C:attention}Increase value{} increases by {X:mult,C:white}X0.01{} for each {C:attention}extra scored card",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{} Mult",
					"{s:0.7}{C:inactive}(Throwback + Splash)",
				},
			},
			["j_tsun_watering_can"] = {
				["name"] = "Watering Can",
				["text"] = {
					"Every {C:attention}played card {}counts in scoring",
					"Gives {X:mult,C:white}X#1#{} Mult for each unique",
					"{C:attention}suit {}in {C:attention}played hand",
					"{s:0.7}{C:inactive}(Flower Pot + Splash){}",
				},
			},
			["j_tsun_lunar_tides"] = {
				["name"] = "Lunar Tides",
				["text"] = {
					"Every {C:attention}played card {}counts in scoring",
					"Each played {C:attention}Queen{} gives {C:red}+#1#{} Mult",
					"{C:attention}Queens{} held in hand give {X:mult,C:white}X#2#{} Mult",
					"{s:0.7}{C:inactive}(Shoot The Moon + Splash){}",
				},
			},
			["j_tsun_ice_tray"] = {
				["name"] = "Ice Tray",
				["text"] = {
					"Every {C:attention}played card {}counts in scoring",
					"{C:attention}Extra scored cards {}give {X:mult,C:white}X#1#{} Mult",
					"{s:0.7}{C:inactive}(Joker Stencil + Splash)",
				},
			},
			["j_tsun_banana_tree"] = {
				["name"] = "Banana Tree",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"This joker gives {C:red}+#1#{} Mult",
					"Destroyed after {C:attention}#2#{C:inactive}[#3#] {C:attention}Extra Scored Cards{} are played",
					"{s:0.7}{C:inactive}(Gros Michel + Splash){}",
				},
			},
			["j_tsun_rainstorm"] = {
				["name"] = "Rainstorm",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Gives {C:money}$#2#{} for each {C:attention}9{} in your {C:attention}full deck",
					"{C:inactive}(currently {C:money}$#1#)",
					"{C:attention}Extra played {C:attention}Cards{} have a",
					"{C:green}#3# in #4#{} chance to {C:attention}become a 9",
					"{s:0.7}{C:inactive}(Cloud 9 + Splash){}",
				},
			},
			["j_tsun_soup"] = {
				["name"] = "Soup",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"This joker gives {X:mult,C:white}X#1#{} Mult",
					"loses {X:mult,C:white}X#2#{} Mult per {C:attention}extra card scored",
					"{s:0.7}{C:inactive}(Ramen + Splash){}",
				},
			},
			["j_tsun_banana_plantation"] = {
				["name"] = "Banana Plantation",
				["text"] = {
					"Every {C:attention}played card {}counts in scoring",
					"This joker gives {X:mult,C:white}X#1#{} Mult",
					"Gains {X:mult,C:white}X#2#{} Mult per {C:attention}Extra scored card{} played",
					"{C:green}#3# in #4#{} chance this card is destroyed at end of round",
					"{s:0.7}{C:inactive}(Cavendish + Splash)",
				},
			},
			["j_tsun_gold_tsunami_marie"] = {
				["name"] = "{C:tsun_gold1}M{C:tsun_gold2}a{C:tsun_gold3}r{C:tsun_gold4}i{C:tsun_gold5}e",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:blue}Splash {C:attention}Fusions{} and {C:blue}Splash {}give {X:mult,C:white}X#1#{} Mult",
					"{C:tsun_gold4}Grants additional effects",
					"{C:tsun_gold4}based on {C:blue}Splash's{}{C:tsun_gold4} Stake Sticker",
					"{C:blue}Splash's {C:tsun_gold4}Stake Sticker: {C:attention}#2# {C:inactive}(#3#/8)",
					"{C:inactive}{s:0.7}(Applies previous Stake effects)",
					"{s:0.5}{C:inactive}(Marie Gold Fusion)",
				},
			},
			["j_tsun_reflection"] = {
				["name"] = "Reflection",
				["text"] = {
					"Every {C:attention}played card {}counts in scoring",
					"Gives {X:mult,C:white}X#1#{} Mult for each instance of a {C:blue}Clubs{} Suit",
					"and a {C:attention}Non-Clubs{} suit in {C:attention}played hand",
					"{C:attention}Extra scored cards{} count as {C:attention}2 cards{} for this effect",
					"{s:0.7}{C:inactive}(Seeing Double + Splash){}",
				},
			},
			["j_tsun_escape_artist"] = {
				["name"] = "Escape Artist",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:attention}Extra played cards{} give {C:blue}+#1# Chips",
					"{C:attention}-#2# {}hand size",
					"{s:0.7}{C:inactive}(Stuntman + Splash){}",
				},
			},
			["j_tsun_raft"] = {
				["name"] = "Raft",
				["text"] = {
					"Every {C:attention}played card counts in scoring",
					"and permanently gains {C:chips}+#1#{} Chips when scored",
					"This effect applies {C:attention}twice{} on {C:attention}extra played cards",
					"{s:0.7}{C:inactive}(Hiker + Splash){}",
				},
			},
			["j_tsun_soaked_joker"] = {
				["name"] = "Soaked Joker",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:attention}Extra scored cards {}give {C:red}+#1#{} Mult",
					"{}when scored",
					"{s:0.7}{C:inactive}(Half Joker + Splash){}",
				},
			},
			["j_tsun_oil_spill"] = {
				["name"] = "Oil Spill",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:attention}Extra scored cards {}give between",
					"{C:red}+#1#{} and {C:red}+#2#{} Mult at random when scored",
					"{s:0.7}{C:inactive}(Misprint + Splash){}",
				},
			},
			["j_tsun_money_laundering"] = {
				["name"] = "Money Laundering",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"You can go up to {C:money}-$#1#{} in debt",
					"While in {C:attention}debt,{} gives {C:money}$#2#{} for each {C:attention}extra card played",
					"{s:0.7}{C:inactive}(Credit Card + Splash){}",
				},
			},
			["j_tsun_beach_ball"] = {
				["name"] = "Beach Ball",
				["text"] = {
					"Every {C:attention}played card counts in scoring",
					"{C:green}#1# in #2#{} chance to create a {C:purple}Tarot{} card",
					"for each {C:attention}Extra Scored Card{} in played hand",
					"{C:inactive}(must have room)",
					"{s:0.7}{C:inactive}(8 Ball + Splash){}",
				},
			},
			["j_tsun_youth"] = {
				["name"] = "Fountain of Youth",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Played cards give {X:mult,C:white}X#1#{} Mult, except {V:2}#4#",
					"Retrigger {V:1}#3#{} {C:attention}#2# time",
					"{s:0.8}suits change at end of round",
					"{s:0.7}{C:inactive}(Ancient Joker + Splash){}",
				},
			},
			["j_tsun_magical_waterfall"] = {
				["name"] = "Magical Waterfall",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:red}+#1#{} Mult. This joker gains {C:red}~#2#{} Mult for each {C:attention}Extra scored card",
					"If you have more than {C:attention}1{} {C:red}Discard,",
					"{C:red}Mult{} output is {C:attention}Divided{} by {C:attention}remaining {C:red}Discards",
					"{C:inactive}(Currently {C:red}+#3#{C:inactive} Mult)",
					"{s:0.7}{C:inactive}(Mystic Summit + Splash){}",
				},
			},
			["j_tsun_dihydrogen_monoxide"] = {
				["name"] = "Dihydrogen Monoxide",
				["text"] = {
					"Every {C:attention}played card {}counts in scoring",
					"Each played {C:attention}Ace{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8{} gives",
					"{C:red}+#1#{} Mult for each {C:attention}Ace{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8{}",
					"in the scoring hand",
					"{s:0.7}{C:inactive}(Fibonacci + Splash){}",
				},
			},
			["j_tsun_webbed_feet"] = {
				["name"] = "Webbed Feet",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Retrigger all {C:attention}face cards{} and {C:attention}extra scored cards",
					"Retrigger {C:attention}extra scored face cards an additional time",
					"{s:0.7}{C:inactive}(Sock And Buskin + Splash){}",
				},
			},
			["j_tsun_gold_reflection"] = {
				["name"] =
				"{C:tsun_gold1}R{C:tsun_gold2}e{C:tsun_gold3}f{C:tsun_gold4}l{C:tsun_gold5}e{C:tsun_gold4}c{C:tsun_gold3}t{C:tsun_gold2}i{C:tsun_gold5}o{C:tsun_gold4}n",
				["text"] = {
					"Every {C:attention}played card {}counts in {C:tsun_gold}scoring",
					"Gives {X:mult,C:white}X#1#{} Mult for each instance of a {C:blue}Clubs{} Suit",
					"and a {C:attention}Non-Clubs{} suit in {C:attention}played hand",
					"{C:attention}Extra scored cards{} count as {C:attention}2 cards{} for this effect",
					"{C:tsun_gold4}Retriggers count the card again for this effect",
					"{s:0.7}{C:inactive}(Reflection Gold Fusion){}",
				},
			},
			["j_tsun_surfboard"] = {
				["name"] = "Surfboard",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:blue}Clubs{} and {C:purple}Spades{C:attention} held in hand{} give {X:mult,C:white}X#1#{} Mult",
					"{s:0.7}{C:inactive}(Blackboard + Splash){}",
				},
			},
			["j_tsun_toaster"] = {
				["name"] = "Toaster",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:attention}Retrigger{} each played {C:attention}Ace{}, {C:attention}2{}, {C:attention}3{}, {C:attention}4{} or {C:attention}5",
					"Each {C:attention}played {C:attention}6{}, {C:attention}7{}, {C:attention}8{}, {C:attention}9{} or {C:attention}10",
					"has its rank {C:attention}halved {C:inactive}(rounded down)",
					"{s:0.7}{C:inactive}(Hack + Splash){}",
				},
			},
			["j_tsun_cryomancer"] = {
				["name"] = "Cryomancer",
				["text"] = {
					"When blind is selected, creates a {C:attention}random Joker",
					"with a registered {C:blue}Splash {C:attention}Fusion",
					"and 1 random {C:attention}Tarot Card",
					"If {C:attention}Joker Slots{} are full, creates up",
					"to {C:attention}2 Tarot Cards{} instead",
					"{C:inactive}(must have room for all effects){}",
					"{s:0.7}{C:inactive}(Cartomancer + Splash){}",
				},
			},
			["j_tsun_thermos"] = {
				["name"] = "Thermos",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"This Joker gains {X:mult,C:white} X#2# {} Mult for each",
					"{C:attention}Steel Card{} in your {C:attention}full deck",
					"{s:0.7}{C:inactive}(currently {X:mult,C:white}X#1#{C:inactive} Mult)",
					"{C:attention}Extra played {C:attention}Steel Cards{} give",
					"{X:mult,C:white} X#3# {} Mult for each {C:attention}Steel Card{} in {C:attention}played hand",
					"{s:0.7}{C:inactive}(Steel Joker + Splash){}",
				},
			},
			["j_tsun_fractured_floodgate"] = {
				["name"] = "Fractured Floodgate",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Retrigger {C:attention}first{} played card {C:attention}#1#{} times",
					"Retrigger {C:attention}first extra{} played card {C:attention}#1#{} times",
					"{s:0.7}{C:inactive}(Hanging Chad + Splash){}",
				},
			},
			["j_tsun_scuba"] = {
				["name"] = "SCUBA Mask",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Played {C:attention}Face Cards{} copy the {C:attention}Enhancement{} of",
					"the {C:attention}first{} played card",
					"{s:0.7}{C:inactive}(Midas Mask + Splash){}",
				},
			},
			["j_tsun_tsunami_yu"] = {
				["name"] = "Yu",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:attention}Extra scored Face Cards{} are {C:red}destroyed",
					"{C:attention}Retrigger all played cards{} once for {C:attention}every #3#{C:inactive} [#2#]{C:attention} cards{} {C:red}destroyed",
					"{C:inactive}Currently #1# Retriggers",
					"{s:0.7}{C:inactive}(Canio + Splash)",
				},
			},
			["j_tsun_tsunami_marie"] = {
				["name"] = "Marie",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:blue}Splash {C:attention}Fusions{} and {C:blue}Splash {}give {X:mult,C:white}X#1#{} Mult",
					"{s:0.7}{C:inactive}(Triboulet + Splash)",
				},
			},
			["j_tsun_tsunami_yosuke"] = {
				["name"] = "Yosuke",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:attention}Gains {X:mult,C:white}X#4#{C:mult} Mult{} for every {C:attention}#3#{C:inactive} [#2#]{C:attention} Extra played cards",
					"{C:attention}Multiply{} counted {C:attention}Extra played cards{} by {C:red}remaining Discards",
					"{C:inactive}Currently {X:mult,C:white}X#1#{C:inactive} Mult",
					"{s:0.7}{C:inactive}(Yorick + Splash)",
				},
			},
			["j_tsun_tsunami_rise"] = {
				["name"] = "Rise",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Disables effect of every {C:attention}Boss Blind",
					"Grants {C:dark_edition}permanent buffs{} when disabling a {C:attention}Boss Blind",
					"Last Buff: {C:dark_edition}#2##1#",
					"{s:0.7}{C:inactive}Modded Blinds give random buffs from other blinds",
					"{s:0.7}{C:inactive}(Chicot + Splash)",
				},
			},
			["j_tsun_tsunami_chie"] = {
				["name"] = "Chie",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Creates {C:dark_edition}Negative{} copies of",
					"{C:attention}#1#{} random {C:attention}consumable{} cards",
					"in your possession when you leave the shop",
					"{C:green}#2# in #3#{} chance to create a {C:attention}random {C:blue}Spectral Card{}",
					"at end of round, otherwise create a random {C:purple}Tarot Card{}",
					"{C:inactive}(must have room)",
					"{s:0.7}{C:inactive}(Perkeo + Splash)",
				},
			},
			["j_tsun_splish_splash"] = {
				["name"] = "Splish Splash",
				["text"] = {
					"When blind is selected, creates {C:blue}Splash",
					"{C:inactive}(don't need room){}",
					"{s:0.7}{C:inactive}(Riff Raff + Splash){}",
				},
			},
			["j_tsun_g_ship"] = {
				["name"] = "Gambling Ship",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Doubles all {C:attention}listed {C:green,E:1,S:1.1}probabilities",
					"{s:0.7}{C:inactive}Current Probabilities: {C:green}#1# in X",
					"If {C:attention}Played Hand{} contains three {C:attention}7s {}in a row,",
					"{C:green}1 in 7 {}chance to {C:attention}permanently{} double all {C:attention}listed {C:green,E:1,S:1.1}probabilities",
					"{s:0.7}{C:inactive}(This effect's probability cannot be changed){}",
					"{s:0.7}{C:inactive}(Oops! All 6s + Splash){}",
				},
			},
			["j_tsun_gold_splish_splash"] = {
				["name"] =
				"{C:tsun_gold1}S{C:tsun_gold2}p{C:tsun_gold3}l{C:tsun_gold4}i{C:tsun_gold5}s{C:tsun_gold4}h {C:tsun_gold3}S{C:tsun_gold2}p{C:tsun_gold1}l{C:tsun_gold5}a{C:tsun_gold3}s{C:tsun_gold4}h{",
				["text"] = {
					"When blind is selected, creates a {C:dark_edition}Negative{} {C:blue}Splash",
					"{s:0.7}{C:inactive}(Splish Splash Gold Fusion)",
				},
			},
			["j_tsun_vending_machine"] = {
				["name"] = "Vending Machine",
				["text"] = {
					"Every {C:attention}played card {}counts in scoring",
					"{C:green}#3# in #4#{} chance for each {C:attention}Extra scored card",
					"to give {X:mult,C:white}X#1#{} Mult",
					"{C:attention}Guaranteed{} trigger after {C:attention}#1#{} {C:inactive}[#2#]{} failed rolls",
					"{s:0.7}{C:inactive}(Loyalty Card + Splash)",
				},
			},
			["j_tsun_holy_water"] = {
				["name"] = "Holy Water",
				["text"] = {
					"All {C:attention}played{} cards are {C:attention}scored{}",
					"Additional cards can be {C:attention}selected{} to form {C:attention}pairs",
					"{s:0.7}{C:inactive}Special order for Cryptid",
					"{s:0.7}{C:inactive}(Jolly Joker + Splash){}",
				},
			},
			["j_tsun_still_water"] = {
				["name"] = "Still Water",
				["text"] = {
					"{C:edition,E:1}you cannot{} {C:cry_ascendant,E:1}swim...{}",
					"{C:edition,E:1}you will not{} {C:cry_ascendant,E:1}float...{}",
					"{C:dark_edition,E:1}you cannot breathe...{}",
					"{C:inactive}(Must have room){}",
					"{s:0.7}{C:inactive}(Cryptid's Sob + Splash){}",
				},
			},
			["j_tsun_swimming_trunks"] = {
				["name"] = "Swimming Trunks",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Gains {C:red}+#1# Mult{} if played hand contains a {C:attention}Two Pair",
					"If played hand is a {C:attention}Two Pair{} with {C:attention}1 Extra Card,",
					"gain {C:attention}%#2#{} of its {C:attention}Rank as {C:attention}Mult",
					"{C:inactive}(Currently {C:red}+#3#{C:inactive} Mult)",
					"{s:0.7}{C:inactive}(Spare Trousers + Splash){}",
				},
			},
			["j_tsun_abrasion"] = {
				["name"] = "Abrasion",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"Gains {C:chips}+#1# Chips{} and {C:red}+#3# Mult{} for each played {C:attention}Stone Card{}",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips, {C:red}+#4#{C:inactive} Mult)",
					"{s:0.7}{C:inactive}(Stone Joker + Splash){}",
				},
			},
			["j_tsun_waterjet"] = {
				["name"] = "Waterjet Cutter",
				["text"] = {
					"Every {C:attention}played card{} counts in scoring",
					"{C:attention}Stone Cards{} gain a random {C:attention}Enhancement{} and {C:attention}Seal",
					"{C:attention}Extra played cards{} become Stone Cards",
					"{s:0.7}{C:inactive}(first effect takes priority)",
					"{s:0.7}{C:inactive}(Marble Joker + Splash){}",
				},
			},
		},
		["Tarot"] = {
			["c_tsun_aeon"] = {
				["name"] = "Aeon",
				["text"] = {
					"Creates {C:blue}Splash",
					"{C:inactive}(Must have room)",
				},
			},
		},
		["Voucher"] = {
			["v_tsun_water_supply"] = {
				["name"] = "Water Supply",
				["text"] = {
					"Creates {C:attention}#1#{} {C:dark_edition}Negative {C:blue}Splash",
				},
			},
			["v_tsun_water_source"] = {
				["name"] = "Water Source",
				["text"] = {
					"Creates {C:attention}#1#{} {C:blue}Splash{} {C:attention}Fusion Joker",
					"{C:tsun_gold1}Gold Fusions{} and {C:dark_edition}Legendary Fusions{} excluded",
				},
			},
		},
		["Spectral"] = {
			["c_tsun_poly"] = {
				["name"] = "Polymorph",
				["text"] = {
					"Creates {C:blue}Splash{} and one {C:attention}random non-legendary",
					"joker that can {C:attention}fuse{} with {C:blue}Splash",
					"{C:attention}-#1# Hand Size",
					"{C:inactive}(Must have room)",
				},
			},
		},
		["Tag"] = {
			["tag_tsun_bubble"] = {
				["name"] = "Bubble Tag",
				["text"] = {
					"Creates a {C:dark_edition}Foil{}, {C:dark_edition}Holographic",
					"or {C:dark_edition}Polychrome{} {C:blue}Splash{}",
				},
			},
		},
	},
}
