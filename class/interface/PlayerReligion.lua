--Veins of the Earth
--Zireael 2014-2015

require 'engine.class'

--Handle actor skills
module(..., package.seeall, class.make)

--Deity system code

function _M:isFollowing(deity)
  return self.descriptor.deity == deity
end


function _M:incFavorFor(deity, d)
  if self:isFollowing(deity) then
    self.favor = self.favor + d
    self.max_favor = self.favor
  end
end


function _M:getFavorLevel(max_favor)
  local ret = 0

  if max_favor == 0 then ret = 0 end
  if max_favor < 100 then ret = 0 end

  --Incursion's values, streamlined
  if max_favor >= 100 then ret = 1 end
  if max_favor >= 500 then ret = 2 end
  if max_favor >= 1250 then ret = 3 end
  if max_favor >= 4500 then ret = 4 end
  if max_favor >= 12000 then ret = 5 end
  if max_favor >= 24000 then ret = 6 end
  if max_favor >= 54000 then ret = 7 end
  if max_favor >= 96000 then ret = 8 end
  if max_favor >= 102000 then ret = 9 end
  if max_favor >= 205000 then ret = 10 end

    game.log("Favor level:"..ret)

  return ret
end

--Lifted whole from Incursion
--Some deity colors have been changed from Inc! (lots of them were duplicated)
--Asherath is tan not cyan; Immotian is gold not pink; Khasrach is olive not red; Essiah is pink not blue
--Hesani is uniformly yellow, Multitude uniformly slate
function _M:divineMessage(deity, message, desc)
  local string
  local color = ""

  if message == "raise" then string = "A voice speaks into the darkness: |I offer you a second chance to find glory in my name!|#LAST#" end

  if deity == "Aiswin" then
    color = "#BLUE#"
    if message == "anger" then string = "The air grows sharply cold, and all the hairs on the back of your neck stand up straight!" end
    if message == "pleased" then string = "A soft red glow surronds you, and you hear a whispered voice in the back of your mind:"..color.."|Ideal.|#LAST#" end
    if message == "prove worth" then string = "A silky, dangerous voice whispers into your mind:"..color.."|Prove your devotion.|#LAST#" end
    if message == "insufficient" then string = "A silky whisper mindspeaks: "..color.."|Insufficient.|#LAST#" end
    if message == "blessing one" then string = "A silky whisper speaks into your mind: "..color.."|I will make you one with shadows!|#LAST#" end
    if message == "blessing two" then string = "A silky whisper speaks into your mind: "..color.."|I grant you intimacy with the night!|#LAST#" end
    if message == "blessing three" then string = "A silky whisper speaks into your mind: "..color.."|I gift you with secret lore!|#LAST#" end
    if message == "blessing four" then string = "A silky whisper speaks into your mind: "..color.."|I will open your eyes to the weakness of your enemies!|#LAST#" end
    if message == "blessing five" then string = "A silky whisper speaks into your mind: "..color.."|I name you master over all shadows!|#LAST#" end
    if message == "blessing six" then string = "A silky whisper speaks into your mind: "..color.."|I gift you with words of silk and malice!|#LAST#" end
    if message == "blessing seven" then string = "A silky whisper speaks into your mind: "..color.."|I teach you now to glory in the lamentations of those who have wronged you!|#LAST#" end
    if message == "blessing eight" then string = "A silky whisper speaks into your mind: "..color.."|I teach you now to strike by surprise and inflict pain with a touch!|#LAST#" end
    if message == "blessing nine" then string = "A silky whisper speaks into your mind: "..color.." |To you I open the most secret shadow paths, and grant words to call forth a thousand knives!|#LAST#" end
    if message == "crowned" then string = "A silky whisper speaks into your mind: "..color.."|I crown you the Harbringer of Ruin!|#LAST#" end
    if message == "insufficient" then string = "A sinuous voice intones: "..color.."|Insufficient.|#LAST#" end
    if message == "bad sacrifice" then string = "A silky voice hisses angrily: "..color.."|Abomination!|#LAST#" end
    if message == "offer raise" then string = color.."|I offer to you a chance to avenge yourself from beyond death!|#LAST#" end
    if message == "salutation" then string = color.."|Blessed be those who walk the path of shadows!|#LAST#" end
    if message == "convert" then string = "" end
  end


  if deity == "Asherath" then
    color = "#TAN#"
    if message == "salutation" then string = color.."|Go forth; gain strength and knowledge to shape the world!|#LAST#" end
    if message == "anger" then string = "You feel that Asherath is gravely displeased with you." end
    if message == "bad prayer" then string = "The air grows sharply cold, and you realize you have made a serious mistake." end
    if message == "jealousy" then string = color.."|Do you really believe I could not have predicted your betrayal? Fool.|#LAST#" end
    if message == "convert" then string = "There is no response from Asherath, but you have a sense of acceptance." end
    if message == "timeout" then string = "You know that Asherath expects His clerics to succeed with little aid, and you feel gravely uneasy about your frequent requests." end
    if message == "prayer" then string = "Time seems to slow down around you briefly... or is it just the fog of war?" end
    if message == "no aid" then string = "As is often the case, Asherath apparently expects you to solve this matter yourself." end
    if message == "out of aid" then string = "Asherath will no longer aid you." end
    if message == "nearly out" then string = "You feel certain Asherath grows tired of your entreaties." end
    if message == "blessing one" then string = "Your training in the Ways of Asherath teaches you to strike true against your enemies." end
    if message == "blessing two" then string = "Your training in the Ways of Asherath helps you to preserve your mental and physical might." end
    if message == "blessing three" then string = "Your training in the Ways of Asherath brings you closer to mental and physical perfection. You also improve your knowledge of the arts of Divination and Evocation." end
    if message == "blessing four" then string = "Your training in the Ways of Asherath expands your horizons." end
    if message == "blessing five" then string = "Your training in the Ways of Asherath brings you closer to mental and physical perfection." end
    if message == "blessing six" then string = "Your training in the Ways of Asherath allows you to push your body and mind beyond previously-understood limits. You also improve your knowledge of the arts of Divination and Evocation." end
    if message == "blessing seven" then string = "Your training in the Ways of Asherath brings you closer to mental and physical perfection." end
    if message == "blessing eight" then string = "Your training in the Ways of Asherath allows you to push your body and mind beyond previously-understood limits." end
    if message == "blessing nine" then string = "Your training in the Ways of Asherath brings you closer to mental and physical perfection.  You also improve your knowledge of the arts of Divination and Evocation." end
    if message == "crowned" then string = color.."|I crown you the Psyche of War!|#LAST#" end
  end

  if deity == "Ekliazeh" then
    color = "#SANDY_BROWN#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|By the forge and the hammer, we stand united!|#LAST#" end
    if message == "anger" then string = "A deep voice thunders, "..color.."|Thou hast broken the ancient Law!|#LAST#" end
    if message == "pleased" then string = "A deep voice thunders, "..color.."|Great riches are these!|#LAST#" end
    if message == "prove worth" then string = "A deep voice intones, "..color.."|Any aspirant must first prove his mettle!|#LAST#" end
    if message == "not worthy" then string = "A deep voice scorns, "..color.."|Thou art no child of mine!|#LAST#" end
    if message == "bad prayer" then string = "A deep voice thunders, "..color.." |Unclean creature! Betrayer of the Law!|#LAST#" end
    if message == "jealousy" then string = "A deep voice thunders, "..color.." |Thou turns back on our covenant? Then suffer!|#LAST#" end
    if message == "convert" then string = color.."|Uphold my Law, and I will carry you through all of life's hardships. Honor the ways of my people, and you will discover tremendous strength!|#LAST#" end
    if message == "forsake" then string = "A deep voice thunders, "..color.." |Thou art a traitor to the Law, and art forever anathema to all my people!|#LAST#" end
    if message == "timeout" then string = "A deep voice intones, "..color.." |"..self.name..", you rely overmuch on my aid! You must survive on your own.|#LAST#" end
    if message == "prayer" then string = "The earth seems to rumble in time with your heartbeat!" end
    if message == "no aid" then string = "A deep voice speaks sorrowfully, "..color.."|I have no further aid to grant unto you, my child.|#LAST#" end
    if message == "out of aid" then string = "A deep voice speaks sorrowfully, "..color.."|I have given you all the aid even a champion may receive in one lifetime!|#LAST#" end
    if message == "nearly out" then string = "A deep voice speaks sorrowfully, "..color.." |Soon I will no longer be able to aid you, my child. Be ready!|#LAST#" end
    if message == "sacrifice" then string = "Your sacrifice dissolves in a rich golden light!" end
    if message == "insufficient" then string = "A deep voice thunders, "..color.."|This is the paltry portion you reserve for your god?!|#LAST#" end
    if message == "satisfied" then string = "A deep voice thunders, "..color.."|You honor the Law with your offering.|#LAST#" end
    if message == "impressed" then string = "A deep voice thunders, "..color.."|Great glory be upon you for the sacrifice you have wrought!|#LAST#" end
    if message == "lessened" then string = "You feel as though your sins have been lessened in Ekliazeh's eyes." end
    if message == "mollified" then string = "You feel as though your sins have been washed away in Ekliazeh's eyes." end
    if message == "bad sacrifice" then string = "A deep voice thunders, "..color.."|You dare to offer me the blood of goodly folk?!|#LAST#" end
    -- "A deep voice thunders, |You dare to offer me the blood of my chosen people?!|"
    if message == "offer raise" then string = "I offer you the chance to return to life, to me my champion and guide my people on the path to righteousness!" end
    if message == "blessing one" then string = color.."|I gift you with the fortitude to endure all of life's ordeals!|#LAST#" end
    if message == "blessing two" then string = color.."|I gift you with the endurance of a perfect worker-soldier!|#LAST#" end
    if message == "blessing three" then string = color.."|I gift you with the ability to shape metal, and to speak with the spirits of the earth!|#LAST#" end
    if message == "blessing four" then string = color.."|I gift you with unearthly resilience!|#LAST#" end
    if message == "blessing five" then string = color.."|I shall render your flesh as hard as the stone itself!|#LAST#" end
    if message == "blessing six" then string = color.."|I gift you with unearthly resilience!|#LAST#" end
    if message == "blessing seven" then string = color.."|I shall render your flesh as hard as the stone itself!|#LAST#" end
    if message == "blessing eight" then string = color.."|I gift you with unearthly resilience!|#LAST#" end
    if message == "blessing nine" then string = color.."|I shall render your flesh as hard as the stone itself!|#LAST#" end
    if message == "crowned" then string = color.."|I crown you the Warrior of the Law!|#LAST#" end
    --Drow/Goblin
    if message == "custom one" then string = color.."|You whose people have slain my children for millenia now appeal to me? Suffer!|#LAST#" end
    --Elf/Lizardfolk
    if message == "custom two" then string = color.."|Your people are too distant from the Earth to follow my ways.|#LAST#" end
    if message == "custom three" then string = color.."|I bless thy workings of the earth!|#LAST#" end
  end


  if deity == "Erich" then
    color = "#PURPLE#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Let there be zeal in your heart, truth in your words, honor in your deeds and blood upon your sword!|#LAST#" end
    if message == "convert" then string = "" end
    if message == "bad sacrifice" then string = "A proud voice booms, "..color.."|Thou stains my altar with the blood of that trash?! Suffer, churl!|#LAST#" end
    --Goblin in sight for smite
    if message == "custom one" then string = "A proud voice booms, "..color.." |I will cleanse this filth from your presence!|#LAST#" end
    --No target for smite
    if message == "custom two" then string = "A proud voice intones, "..color.."|I cannot aid you against worthy foes. You must fight your own battles, with my blessing.|#LAST#" end
    --Grant item
    if message == "custom three" then string = "A proud voice proclaims, "..color.."|Use this and find glory in my name!|#LAST#" end
    --Erich's Disfavor Effect (-4 penalty on all rolls in combat, persistent)
    if message == "custom four" then string = "A proud voice scorns, "..color.."|Vile cur, suffer for thy cowardice!|#LAST#" end
    --Goblinoid
    if message == "custom five" then string = "An angry voice declares, "..color.."|I deal not with filth and base creatures!|#LAST#" end
  end


  if deity == "Essiah" then
    color = "#PINK#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|The horizon awaits...|#LAST#" end
    if message == "convert" then string = "" end
    if message == "blessing one" then string = color.."|I teach thee now to honor the feelings of thy lovers, and the crafts of herbs to control thine own body.|#LAST#" end
    if message == "blessing two" then string = color.."|May all thy journeys be swift and clear, if not uninteresting.|#LAST#" end
    if message == "blessing three" then string = color.."|I grant to thee the beauty to lead an entertaining life, and further the wisdom to lead a good one.|#LAST#" end
    if message == "blessing four" then string = color.."|Let nothing impede thy freedom to move!|#LAST#" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end

  end


  if deity == "Hesani" then
    color = "#YELLOW#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Walk in harmony with the world, and your prosperity shall multiply a thousand-fold. Fight against its tides, and they will tear your life asunder.|#LAST#" end
    if message == "convert" then string = "" end
    --only barbarian levels
    if message == "custom one" then string = color.."|To embrace the path of harmony, one must first turn away from barbarism.|#LAST#" end

  end


  if deity == "Immotian" then
    color = "#GOLD#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|The flame of purity lights the path to righteousness!|#LAST#" end
    if message == "bad sacrifice" then string = color.."|Barbarian! Thou hast stained My altar with blood! This is an abomination of the highest order!|#LAST#" end
    if message == "convert" then string = "" end
    --any hostile in sight on smite (transforms into a pillar of salt DC 25)
    if message == "custom one" then string = color.."|Accursed be those who strike at believers!|#LAST#" end
    if message == "custom two" then string = "" end
    --god pulse (summon fire critters)
    if message == "custom three" then string = color.."|Blessed is thee who shares kinship with the spirits of flame!|#LAST#" end
    --god pulse event (empowered maximized enlarged Order's Wrath)
    if message == "custom four" then string = color.."|Let no unlawful villain lay hands upon my follower!|#LAST#" end
    --change water in equipment into blood
    if message == "custom five" then string = color.."|I curse thee, wayward follower: let thy sweetest water taste as bitter as a clotted blood of thine enemies!|#LAST#" end
    if message == "custom six" then string = color.."|I curse thee, wayward follower: a plague upon thy fields!|#LAST#" end
    --4d50 favor
    if message == "custom seven" then string = "You feel Immotian is pleased with the community you have built and will not strain it further by enlarging it." end
    if message == "blessing one" then string = color.."|Walk in the light of My truth, and no flames shall burn thee!|#LAST#" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Khasrach" then
    color = "#OLIVE_DRAB#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = "" end
    if message == "convert" then string = "" end
    if message == "bad sacrifice" then string = color.."|Thou dares to offer me the blood of mine own people?! SUFFER!|#LAST#" end
    --|Thou dares to offer me the blood of our allies?!|
    --anger, changeLevel(10, math.max(game.level.level + ((self.anger -3)/5)))
    if message == "custom one" then string = color.."|Thou hast sinned against my way; now, prove thy loyalty in this trial by ordeal!|#LAST#" end
    --god pulse, summon a friendly orc(s)
    if message == "custom two" then string = color.."|Know always that our people have strength in numbers!|#LAST#" end
    --retribution, summon enemy orc(s)
    if message == "custom three" then string = color.."|Destroy the infidel, my children!|#LAST#" end
    --elf/dwarf/human/mage level
    if message == "custom four" then string = color.."|Thou art an enemy of my people! Suffer, infidel!|#LAST#" end
    if message == "blessing one" then string = color.."|So I bless thee: that thou shalt turn aside all charms and compulsions, and see clearly past the machinations of others to determine thy future!|#LAST#" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Kysul" then
    color = "#LIGHT_GREEN#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Seek now thine antediluvian progenitors that in sunken cities for eons have lain.|#LAST#" end
    if message == "aid" then string = "Kysul guides you to safety through the cracks and flaws between dimensions." end
    if message == "convert" then string = "" end
    --god pulse, gift
    if message == "custom one" then string = "An inhuman emanation vaguely imitates language: "..color.."|This, my child: a relic of civilizations long since engulfed by the flow of eons!|#LAST#" end
    --anger, ???
    if message == "custom two" then string = "You feel profane." end
    --anger x2, closest enemy gets pseudonatural template
    if message == "custom three" then string = "You feel you are surely facing the ire of Kysul..." end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Mara" then
    color = "#ANTIQUE_WHITE#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|May you find beauty in endings.|#LAST#" end
    if message == "bad sacrifice" then string = "A solemn voice thunders: "..color.."|You have stained my altar with conquest-blood! You shall suffer for this grievous misjudgement!|#LAST#" end
    if message == "convert" then string = "" end
    --anger, your body decomposes
    if message == "custom one" then string = "A solemn voice speaks crossly: "..color.."|Learn now why death is never to be lightly dispensed!|#LAST#" end
    --god pulse, revenant
    if message == "custom two" then string = "A solemn voice intones: "..color.."|This soul seeks to make atonement for past misdeeds, and will travel with you to aid you on your quest.|#LAST#" end
    --god pulse, self.level >= 5, revenant w/class levels
    if message == "custom three" then string = "A solemn voice intones: "..color.."|This soul seeks to find closure lacking in life, and will travel with you to aid you on your quest.|#LAST#" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Maeve" then
    color = "#DARK_GREEN#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|And there shall be laughter and magic and blood, and we shall dance our dance until the end of time...|#LAST#" end
    if message == "convert" then string = "" end
    --god pulse; o.type is either cloak/ring/amulet; must be magical
    if message == "custom one" then string = "A mellifluous voice titters, "..color.."|Oh, what a pretty" ..o.type.."! I simply must have it!|#LAST#" end
    --god pulse; summon single non-good non-lawful CR player.level+2 monster
    if message == "custom two" then string = "A mellifluous voice titters, "..color.."|Now, my precious acolyte, entertain me with your wonderous displays of warcraft!|#LAST#" end
    --god pulse; Maeve's Whimsy
    if message == "custom three" then string = "A mellifluous voice titters, "..color.."|Now, on this moonless eve, the Faerie Queen works her wiles: so what's fair is foul, and foul's fair!|#LAST#" end
    --god pulse x2; closest friendly non-player turns hostile;
    --random magic non-cursed item glows with a silvery light and gets a +1 bonus
    if message == "custom four" then string = "A mellifluous voice titters, "..color.."|Let discord and misrule reign eternal!|#LAST#" end

    if message == "custom five" then string = "A mellifluous voice intones, "..color.."|Now, my beautiful plaything, drink deeply of my well of ancient fey dweomers!|#LAST#" end
    --god pulse; 1 on 1d3, a druidic spell or an arcane spell (player.level+3)/2
    if message == "custom six" then string = "A mellifluous voice intones, "..color.."|To you, my loyal knight of the trees, I bequithe this ancient faerie magick!|#LAST#" end
    --beautiful/handsome; god pulse - magic non-cursed item
    if message == "custom seven" then string = "A mellifluous voice intones, "..color.."|A gift I bequeath to thee, for my most loyal and <hText> of champions!|#LAST#" end
    --anger/god pulse; enlarged Othello's irresistible dance
    if message == "custom eight" then string = "A mellifluous voice titters, "..color.." |Let there be dance and music and merryment!|#LAST#" end
    --retribution; summons hostile elf twilight huntsman
    if message == "custom nine" then string = "A mellifluous voice howls, "..color.."|Now, my loyal huntsman, destroy the traitor!|#LAST#" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Sabin" then
    color = "#LIGHT_BLUE#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Life is a whirlwind. Cast free your tethers, dive forward and watch as you soar!|#LAST#" end
    if message == "convert" then string = "" end
    if message == "custom one" then string = "A resonant voice speaks: "..color.."|Thou hast grown too static -- be changed!|#LAST#" end
    if message == "custom two" then string = "You are struck by a bolt of inspiration!" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = color.."|I grant thee the potential for excellence!|#LAST#" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Semirath" then
    color = "#ORCHID#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|Now, my child, go forth and teach the legions of ignorance that there are many fates worse than death, and some even involve radishes!|#LAST#" end
    if message == "convert" then string = "" end
    --god pulse; hostile non-good humanoid in LOS
    if message == "custom one" then string = "A boyish voice speaks: "..color.."|Leave my follower alone, you cretins!|#LAST#" end
    --anger; drop armor (clothes)
    if message == "custom two" then string = "A boyish voice speaks: "..color.."|Gratuitous nudity is *always* appropriate!|#LAST#" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Xavias" then
    color = "#DARK_SLATE_GRAY#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|And the path of the Golden Lion, the Philosopher's Treasure, the Glory of Transmutation shall soon be lain clear before thee!|#LAST#" end
    if message == "convert" then string = "" end
    if message == "custom one" then string = "An elderly voice speaks sadly, "..color.."|Forgive me, my child: thou lacks the depth of vision to truly explore the Holy Mysteries.|#LAST#" end
    --grant spellbook
    if message == "custom two" then string = "An elderly voice speaks slowly: "..color.."|I gift you with Hermetic wisdom!|#LAST#" end
    --Int+Wis < 26
    if message == "custom three" then string = "An elderly voice speaks slowly: "..color.." |Thy mind is too feeble to be initiated into thine Holy Mysteries.|#LAST#" end
    if message == "blessing one" then string = "" end
    if message == "blessing two" then string = "" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end


  if deity == "Xel" then
    color = "#DARK_RED#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = "You feel an aching, primordial hunger. "..color.."|Blood for the blood god!|#LAST#" end
    --doesn't really communicate
  end


  if deity == "Zurvash" then
    color = "#CRIMSON#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = "May your hunt be fruitful, and your plunder rich and succulent!" end
    if message == "convert" then string = "" end
    --anger; summon several hostile non-good fiendish critters, total CR player.level +2
    if message == "custom one" then string = "A growling voice hisses: "..color.."|Destroy the infidel, my beautiful children!|#LAST#" end
    if message == "blessing one" then string = "A growling voice speaks: "..color.."|Only the strong will survive!|#LAST#" end
    if message == "blessing two" then string = "A growling voice speaks: "..color.."|Be you the hunter and not the hunted!|#LAST#" end
    if message == "blessing three" then string = "" end
    if message == "blessing four" then string = "" end
    if message == "blessing five" then string = "" end
    if message == "blessing six" then string = "" end
    if message == "blessing seven" then string = "" end
    if message == "blessing eight" then string = "" end
    if message == "blessing nine" then string = "" end
    if message == "crowned" then string = "" end
  end

  if deity == "Multitude" then
    color = "#SLATE#"
    if message == "anger" then string = "" end
    if message == "salutation" then string = color.."|killemflayemburnemhurtemmakeemscreammakeemBLEED...|#LAST#" end
    if message == "convert" then string = "" end
    --god pulse, gain 4d50 favor
    if message == "custom one" then string = color.."|Goodhordegrownhordebloodyhordeghostspleased...|#LAST#" end
    --god pulse, summon several player.level+2 demons
    if message == "custom two" then string = color.."|aidhimservehimlovehimkillforhim...|#LAST#" end
    --anger; summon several player.level+2 demons but hostile
    if message == "custom three" then string = color.."|traitortraitortraitorDIEtraitortraitor...|#LAST#" end
    --don't really communicate
  end



    if desc then string = string.." about "..desc end
    game.logPlayer(self, string)
end

function _M:transgress(deity, anger, angered, desc)
  --Currently only increase for your patron
  if self:isFollowing(deity) then

  --reduce Wis temporarily by math.max(anger, 10)
  old_anger = self.anger

  self.anger = old_anger + anger
  end

  if angered then self:setGodAngerTimer() end

  if self.anger >= 50 then self.anathema = true end
  if self.anger >= 35 then self.forsaken = true end

  if self.anger >= 5 then self:divineMessage(deity, "very uneasy", desc)
  else self:divineMessage(deity, "uneasy", desc) end

end

function _M:isForsaken(deity)
  if self.forsaken == true then return true
  else return false end
end

function _M:isAnathema(deity)
  if self.anathema == true then return true
  else return false end
end

function _M:setGodPulse()
  local deity = self.descriptor.deity

  if deity == "Aiswin" or deity == "Hesani" or deity == "Immotian" or deity == "Sabin" or deity == "Semirath" or deity == "Xel" or deity == "Zurvash" then self.god_pulse_counter = 10
  elseif deity == "Ekliazeh" or deity == "Essiah" or deity == "Khasrach" or deity == "Kysul" or deity == "Mara" or deity == "Xavias" then self.god_pulse_counter = 20
  elseif deity == "Maeve" then self.god_pulse_counter = 25
  elseif deity == "Erich" then self.god_pulse_counter = 30
  elseif deity == "Multitude" then self.god_pulse_counter = 7
  end
end

function _M:setGodAngerTimer()
  local deity = self.descriptor.deity

  if deity == "Erich" or deity == "Hesani" or deity == "Kysul" or deity == "Mara" or deity == "Xel" or deity == "Zurvash" then self.god_anger_counter = 10
  elseif deity == "Immotian" then self.god_anger_counter = 15
  elseif deity == "Aiswin" or deity == "Essiah" or deity == "Semirath" or deity == "Xavias" then self.god_anger_counter = 20
  elseif deity == "Ekliazeh" then self.god_anger_counter = 25
  elseif deity == "Khasrach" or deity == "Sabin" then self.god_anger_counter = 30
  elseif deity == "Maeve" or deity == "Multitude" then self.god_anger_counter = 7
  end
end


function _M:godPulse()
  local deity = self.descriptor.deity
  if deity == "Aiswin" then
  --  game.logPlayer(self, "Aiswin whispers a secret to you!")
    --case one: identify a random item
    --case two: give Aiswin's Lore spell ("Mystical knowledge of Aiswin's Lore imprints itself on your mind!")
    --case three: mark random actor in range 30 as seen
  end
  if deity == "Ekliazeh" then
    --case one: mend random item in inventory
    --case two: "Your o.name glows with a brilliant silver light!"
  --  self:divineMessage("Ekliazeh", "custom three")
  end
  if deity == "Erich" then
    --grant a random arms/weapon
  --  self:divineMessage("Erich", "custom three")
  end
  if deity == "Essiah" then
    --ESSIAH_DREAM stuff
    --after rest, if angry, damage 3d10 CON, the wrath of Essiah
    --if self:getFavorLevel(max_favor) >= 1d12 then
    --"Essiah appears to you in your dreams in the form you find most appealing, and beckons seductively. /n Accept the embrace?"
    --Y:"You experience a feverish, erotic dream of great intensity. That was certainly a learning experience!"
    --self:gainExp(10*self.level*(self.getFavorLevel+4))
    --exercise CHA and CON
    --self:exercise("cha", rng.dice(5,12), "cha_Essiah", 70)
    --self:exercise("con", rng.dice(5,12), "con_Essiah", 70)
    --N: "The goddess shrugs, smiles warmly without condemnation at you, and vanishes."
  end
  if deity == "Hesani" then
    if game.level.level > 1 and self.level < 12 then
      if game.level.level > (self.level/2) then
        self:transgress("Hesani", 1, "lack of patience")
      end
    end
  --  game.logPlayer(self, "Natural flows replenish you.")
    --refresh random available spell
  end
  if deity == "Immotian" then
    --if threatened
  --  self:divineMessage("Immotian", "custom four")
    --Empowered+Maximized+Enlarged Order's Wrath centered on player
    --else if something then
    --self:incFavorFor("Immotian", 4d50) self:divineMessage("Immotian", "custom seven")
    --else summon fire critters self:divineMessage("Immotian", "custom three")
  end
  if deity == "Khasrach" then
    --summon orcs
    --if angry self:divineMessage("Khasrach", "custom three") all orcs e.faction = "enemies"
    --else self:divineMessage("Khasrach", "custom two") e.faction == "players"
  end

  if deity == "Kysul" then
    if self:getFavorLevel(self.max_favor) < 3 then
    else --gift random item
  --    self:divineMessage("Kysul", "custom one")
    end
  end

  if deity == "Mara" then
    if self.favor >= 1500 then
      --summon revenant
    --  self:divineMessage("Mara", "custom two")
    end
  end

  if deity == "Maeve" then
    --exercise LUC
    self:exerciseStat("luc", rng.dice(4,12), "luc_Maeve", 80)
    --if threatened and rng.dice(1,2) == 1 then
    --Othello's Irresistible Dance on player
  --  self:divineMessage("Maeve", "custom eight")
    --else self:randomMaeveStuff(false) end
  end

  if deity == "Sabin" then
    --if has allies then self:transgress("Sabin", 1, "relying on others")
    if self:getFavorLevel(self.max_favor) > 3 then
      self:divineMessage("Sabin", "custom two")
      local gain = 10*self.level*self:getFavorLevel(self.max_favor)
      self:gainExp(gain)
      --exercise INT
      self:exerciseStat("int", rng.dice(5,12), "int_Sabine", 70)
    end
  end
  if deity == "Semirath" then
    --fumble a non-good hostile humanoid in player's sight if there's one
  --  self:divineMessage("Semirath", "custom one")
    --game.logSeen("%s collapses in a fit of uncontrollable laughter!")
  end
  if deity == "Xavias" then
    game.logPlayer(self, "Your mind is filled with dreamlike images and cryptic symbolism -- you are enlightened!")
    --exercise INT & WIS
    self:exerciseStat("int", rng.dice(5,12), "int_Xavias", 70)
    self:exerciseStat("wis", rng.dice(5,12), "wis_Xavias", 70)

    local Intbonus = math.floor((game.player:getInt()-10)/2)
    local Wisbonus = math.floor((game.player:getWis()-10)/2)
    self:gainExp(math.max(1,((Intbonus+Wisbonus)*100)))
  end
  if deity == "Xel" then
    if self.life < self.max_life then
      game.logPlayer(self, "Stolen vitality heals your injuries!")
      self:resetToFull()
    end
  end
  if deity == "Zurvash" then
    --if has a non-animal ally, self:transgress("Zurvash", 1, "relying on others")
    game.logPlayer(self, "You go berserk! You feel flush with a supernatural endurance!")
    self:setEffect(self.EFF_RAGE, self:getFavorLevel(self.max_favor), {})
  end

  if deity == "Multitude" then
    --if something then
    --summon several player.level+2 demons for 30+Chamod turns
    --if angry, e.faction = "enemies", else e.faction = "players"
    --self:divineMessage("Multitude", "custom three")
    --else
    self:incFavorFor("Multitude", rng.dice(4,50))
    self:divineMessage("Multitude", "custom seven")
  end

end

function _M:godAnger()
    local deity = self.descriptor.deity

    if deity == "Aiswin" then
      --if not afraid then
    --  self:setEffect(self.EFF_FEAR, 200, {})
      game:logPlayer(self, "You catch vague glimses of nightmarish, obscene shapes menacing you from the shadows!")
    end

    if deity == "Ekliazeh" then
      --pick random good item, destroy it
    --  game:logPlayer(self, "Your %s dissolves into a pile of gravel!":format(o.name))
    end

    if deity == "Erich" then
      --if already has this effect, do nothing
      --self:setEffect(self.EFF_ERICH_DISFAVOR, 20, {})
      self:divineMessage("Erich", "custom four")
    end

    if deity == "Essiah" then
      --if has ESSIAH_DREAM flag, remove it
      game.logPlayer(self, "In your dreams, you relive all the suffering you have wrongfully brought to others!")
      --CON damage 3d10
    end

    if deity == "Hesani" then
      --forget random x spells prepared
      game.logPlayer(self, "Moving against the currents of the world, you feel depleted.")
    end

    if deity == "Immotian" then
      --if has potion in equipment, destroy it and give a potion of blood instead
      --self:divineMessage("Immotian", "custom five")
      --else cast insect plague on player
      self:divineMessage("Immotian", "custom three")
    end

    if deity == "Khasrach" then
      if game.level.level > math.min(9, self.level+2) then
        --retribution
      end
      self:divineMessage("Khasrach", "custom one")
      game.logPlayer(self, "You are cast down!")

      local change = (10 - game.level.level)

      if game.level.level >= 10 then game:changeLevel(1)
      else
--[[        if game.zone.max_level >= self.level.level + change then
        game:changeLevel(change) end]]
      end
    end

    if deity == "Kysul" then
      --get closest enemy, apply pseudonatural template to it
      self:divineMessage("Kysul", "custom three")
    end

    if deity == "Mara" then
      if self.type ~= "undead" then
        self:divineMessage("Mara", "custom one")
        game.logPlayer(self, "Your body decomposes!")
      end
    end

    if deity == "Maeve" then
      self:randomMaeveStuff(true)
    end

    if deity == "Sabin" then
      self:divineMessage("Sabin", "custom one")
      --swap attributes
    end

    if deity == "Semirath" then
      if self.anger >= 15 then
        self:divineMessage("Semirath", "custom two")
        --retribution
      end
      --take random item and place it in a random place on map
    end

    if deity == "Xavias" then
      game.logPlayer(self, "Your mind is filled with dreamlike images and cryptic symbolism -- you can't comprehend it!")
      --a harrowing vision from Xavias, confuse for 40 turns
    end

    if deity == "Xel" then
      game.logPlayer(self, "Xel drinks your life!")
    --  deal xd6 necro damage
    --if self.life == old life then
    --game.logPlayer("You feel Xel is angrier now")
    --self:transgress("Xel", 1, false, "frustrating Xel")
    end

    if deity == "Zurvash" then
      local result = rng.dice(1,3)
      local duration = rng.dice(3,8)
      if result == 1 then
        game.logPlayer(self, "You are stricken with fear!")
        --self:setEffect(self.EFF_FEAR, duration, {})
      end
      if result == 2 then
        game.logPlayer(self, "You are stricken with weakness")
        --reduce STR by ?
      end
      if result == 3 then
        game.logPlayer(self, "You are inexplicably struck blind!")
        --self:setEffect(self.EFF_BLIND, duration, {})
      end
    end

    if deity == "Multitude" then
      self:divineMessage("Multitude", "custom four")
      --summon multiple CR player.level+2 hostile demons
    end
end

function _M:randomMaeveStuff(anger)
  local result = rng.dice(1,8)

  if anger then result = rng.dice(1,4) end

  --BAD stuff
  if result == 1 then
    --remove random cloak/ring/amulet
  --  game.logPlayer(self, "Your %s vanishes!":format(o.name))
  end

  if result == 2 then
    --summon single non-good non-lawful hostile CR self.level +2
    self:divineMessage("Maeve", "custom two")
  end

  if result == 3 then
    self:divineMessage("Maeve", "custom three")
    --Maeve's Whimsy
  end

  if result == 4 then
    --find closest friendly and turn it hostile
    self:divineMessage("Maeve", "custom four")
  end

  --Good stuff
  if result == 5 then
    --random magic non-cursed item gets an additional +1
    self:divineMessage("Maeve", "custom four")
  --  game.logPlayer("Your %s glows with a silvery light!"):format(o.name))
  end

  if result == 6 then
    self:divineMessage("Maeve", "custom six")
    local result = rng.dice(1,3)
    if result == 1 then
      --random druidic spell level (CR+2)/3
      game.logPlayer(self, "Knowledge of the dweomer %s imprints itself on your mind!"):format(t.name)
    else
      --random arcane spell, level (CR+2)/3
      game.logPlayer(self, "Knowledge of the dweomer %s imprints itself on your mind!"):format(t.name)
    end
  end

  if result == 7 then
    self:divineMessage("Maeve", "custom seven")
    --give a random good item
  end

  if result == 8 then
    game.logPlayer(self, "You are surronded in a corona of rainbow light!")
    --for every non-construct hostile in LOS and 12 range
  --  game.logSeen("%s's heart is forever ensnared!":format(e.name))
  end

end

--Determines if the sacrifice is neutral, unworthy, angry or abomination
function _M:getActorSacrificeReaction(deity, actor)
  local ret

  if deity == "Aiswin" then
    if actor.type == "humanoid" then
      ret = "neutral"
    end
    --no flag for grave wounding
    if not actor.aiswin or not actor.aiswin == true then
      ret = "unworthy"
    end
    --if used to be friendly then return "abomination"
  end

  if deity == "Ekliazeh" then
    if actor.subtype == "dwarf" then
      ret = "abomination"
    end
    --if was friendly then return "unworthy"
  end

  if deity == "Erich" then
    if actor.subtype == "goblinoid" then
      ret = "abomination"
    end
  end

  if deity == "Essiah" then
    --if non-evil then ret = "angry"
    --if was friendly then ret = "angry"
    --or vampire or erinyes or gray nymph
    if actor.name == "satyr" or actor.name == "nymph" then
      ret = "neutral"
    end
  end

  if deity == "Khasrach" then
    if actor.subtype == "goblinoid" then
      ret = "angry"
    end
    if actor.subtype == "orc" then
      ret = "abomination"
    end
    if actor.challenge < self.level then
      ret = "unworthy"
    end
  end

  if deity == "Kysul" then
    if actor.type == "aberration" then
      ret = "neutral"
      --if not evil then ret = "abomination"
    end
  --  if actor.alignment == "lawful good" or actor.alignment == "neutral good" or actor.alignment == "chaotic good"
  --or was friendly then ret = "abomination"
  end

  if deity == "Mara" then
    --flag damaged by player
    if actor.mara == true then
      ret = "abomination"
    else
      ret = "neutral"
    end
  end

  if deity == "Maeve" then
    if actor.subtype == "elf" then
      ret = "abomination"
    end
  end

  if deity == "Multitude" then
    --if non-good and was friendly then ret = "unworthy"
  end

  if deity == "Zurvash" then
    if actor.challenge < self.level then
      ret = "unworthy"
    end
  end

  return ret
end

function _M:sacrificeMult(actor)
  local deity = game.player.descriptor.deity

  if not deity.sacrifice then return end

  if not deity.sacrifice[actor.type] or deity.sacrifice[actor.subtype] then return end

  if actor.type ~= "humanoid"  then
    return deity.sacrifice[actor.type]
  else
    if not deity.sacrifice[humanoid] then
    return deity.sacrifice[actor.subtype]
    else return deity.sacrifice[actor.type]
    end
  end
end



function _M:sacrificeValue(actor)
  local player = game.player
  local value = player.sacrifice_value
  local max_value = player.max_sacrifice_value
  local mult = 10

  mult = self:sacrificeMult(actor) or 10

--  value = (mult*actor.challenge*(10+player.knowledge_skill))/10
    --cba to add another skill now
    player.sacrifice_value = player.sacrifice_value or {}
    value[actor.type] = value[actor.type] or 0
    value[actor.type] = (mult*actor.challenge)/10

    player.max_sacrifice_value = player.max_sacrifice_value or {}
    max_value[actor.type] = max_value[actor.type] or 0

    if value[actor.type] > (max_value[actor.type] or 0) then
      max_value[actor.type] = value[actor.type]
      self.impressed_deity = true
    end

    return value[actor.type]

end


--NOTE: actor is the monster that got killed on the altar tile
function _M:liveSacrifice(actor)
  local player = game.player
  --sacrificing only to player's deity for now
  local deity = self.descriptor.deity

  local sac_val = self:sacrificeValue(actor)

  --No live sacrifices if Hesani worshipper
  if deity == "Hesani" then return end
  --..or Immotian
  if deity == "Immotian" then return end

  if self.forsaken == true then
    player:divineMessage(deity, "bad prayer")
    --retribution
  return end

  --if actor.summoned == true or actor.illusion == true then return end

  --check deity reaction first before doing anything else
  if self:getActorSacrificeReaction(deity, actor) == "abomination" then
    player:transgress(deity, 5, true, "offensive sacrifice")
    player:divineMessage(deity, "bad sacrifice")
    return end

  if self:getActorSacrificeReaction(deity, actor) == "angry" then
    player:transgress(deity, 1, false, "offensive sacrifice")
    player:divineMessage(deity, "bad sacrifice")
    return end
  if self:getActorSacrificeReaction(deity, actor) == "unworthy" then
    player:divineMessage(deity, "insufficient")
    return end


  player:divineMessage(deity, "sacrifice")

  self:sacrificeValue(actor)

  --reduce anger
  if self.anger > 0 then
    local check_anger = math.max(0, (self.anger-3))
    if check_anger > 0 then
      player:divineMessage(deity, "lessened")
    else
      player:divineMessage(deity, "mollified")
    end
  end

  --message
  if self.impressed_deity == true then
    player:divineMessage(deity, "impressed")
    --exercise WIS
  else
    player:divineMessage(deity, "satisfied")
  end

  --increase favor by sacrifice value
  player:incFavorFor(deity, sac_val)

end

function _M:sacrificeItemMult(actor)
  local deity = game.player.descriptor.deity

  if not deity.sacrifice then return end

  if not deity.sacrifice[item.type] or deity.sacrifice[item.subtype] then return end

end



function _M:sacrificeItemValue(item)
  local player = game.player
  local value = player.sacrifice_value
  local max_value = player.max_sacrifice_value
  local mult = 10

  mult = self:sacrificeItemMult(item) or 10

--  value = (mult*actor.challenge*(10+player.knowledge_skill))/10
    --cba to add another skill now
    player.sacrifice_value = player.sacrifice_value or {}
    value[item.type] = value[item.type] or 0
    value[item.type] = (mult*item.cost)/10

    player.max_sacrifice_value = player.max_sacrifice_value or {}
    max_value[item.type] = max_value[item.type] or 0


    --deity is impressed if item.cost > WealthByLevel[self.level / 2] / 20)
 --[[   if value[item.type] > (max_value[item.type] or 0) then
      max_value[item.type] = value[item.type]
      self.impressed_deity = true
    end]]

    return value[item.type]
end


function _M:itemSacrifice(item)
  local player = game.player
  --sacrificing only to player's deity for now
  local deity = self.descriptor.deity

  local sac_val

  --Hesani takes only golden items

  if self.forsaken == true then
    player:divineMessage(deity, "bad prayer")
    --retribution
  return end

  --check deity reaction first before doing anything else
  if self:getActorSacrificeReaction(deity, actor) == "abomination" then
    player:transgress(deity, 5, true, "offensive sacrifice")
    player:divineMessage(deity, "bad sacrifice")
    return end

  if self:getActorSacrificeReaction(deity, actor) == "angry" then
    player:transgress(deity, 1, false, "offensive sacrifice")
    player:divineMessage(deity, "bad sacrifice")
    return end
  if self:getActorSacrificeReaction(deity, actor) == "unworthy" then
    player:divineMessage(deity, "insufficient")
    return end


  player:divineMessage(deity, "sacrifice")


  if item.subtype == "corpse" and item.victim then
    sac_val = self:sacrificeValue(item.victim)
  else
    sac_val = self:sacrificeItemValue(item)
  end

  --reduce anger
  if self.anger > 0 then
    local check_anger = math.max(0, (self.anger-3))
    if check_anger > 0 then
      player:divineMessage(deity, "lessened")
    else
      player:divineMessage(deity, "mollified")
    end
  end

  --message
  if self.impressed_deity == true then
    player:divineMessage(deity, "impressed")
    --exercise WIS
  else
    player:divineMessage(deity, "satisfied")
  end

  --increase favor by sacrifice value
  player:incFavorFor(deity, sac_val)

end

--Do only one thing in order of importance
--Deduce aid costs as favor penalty %
---if existing favor penalty + aid cost > 100 then player:divineMessage(deity, "out of aid")
--if favor penalty > 70 & favor penalty + aid cost <= 70 then player:divineMessage(deity, "nearly out")
function _M:divineAid()
  local player = game.player
  local poisoned = player:isPoisoned()

  if self.life < self.max_life*0.7 then
    self:resetToFull()
    game.logPlayer(self, "Your wounds heal fully!")
    return end
  if poisoned then player:removeEffect(self[poisoned]) return end
  if self.nutrition < 1500 then
    self.nutrition = 3500
    game.logPlayer(self, "You no longer feel hungry.")
    return end
--if petrified then unpetrify "Your afflictions are purified!"
--if blind then remove the effect "Your afflictions are purified!"
--if paralysed/held then remove the effect "Divine clarity restores focus to your thoughts!"
--if afraid then remove the effect "Your afflictions are purified!"
--if enemy & enemy CR > player.level*2 then teleport "deity carries you to safety!"
--if diseased/sick then remove the effect "Your afflictions are purified!"
--if cursed then remove curse ""Your curses are lifted!"
  if self.nutrition < 2000 then
    self.nutrition = 3500
    game.logPlayer(self, "You no longer feel hungry.")
    return end
-- if enemy & enemy CR > player.level then smite

end


--For prayer talent
function _M:pray()
  game.logPlayer(self, ("You prayed to %s for divine aid"):format(self.descriptor.deity))

  --knowledge:theology check against PRAYER_DC
  --"You fail to recite the ritual prayers and invocations correctly." if failed

  --if not your deity, divine jealousy

  --if self.anger above tolerance, retribution

  --maybe implement timeout?

  self:divineAid()

end


--Called by DeathDialog
function _M:godWillRaise()
    local deity = self.descriptor.deity

    local min_raise_level = {
        Aiswin = 3,
        Asherath = nil,
        Ekliazeh = 8,
        Erich = 8,
        Essiah = 8,
        Hesani = 5,
        Immotian = 6,
        Khasrach = 7,
        Kysul = 8,
        Mara = 3,
        Maeve = 6,
        Sabin = 7,
        Semirath = 7,
        Xavias = 6,
        Xel = 7,
        Zurvash = 8,
        Multitude = 9,
    }

    --not atheist
    if self:isFollowing("None") then return false end
    if not min_raise_level[deity] then return false end

    if self:isAnathema() or self:isForsaken() then return false end
    --if penalty + resurrection cost > 100 then return false end
    --if god.anger > math.max(3,tolerance value) then return false end

    if self.level < min_raise_level[deity] then return false end

    if self:getCon() < 3 then return false end

    return true
end

local resurrection_cost = {
    Aiswin = 6,
    Asherath = nil,
    Ekliazeh = 20,
    Erich = 15,
    Essiah = 15,
    Hesani = 10,
    Immotian = 7,
    Khasrach = 20,
    Kysul = 30,
    Mara = 3,
    Maeve = 6,
    Sabin = 14,
    Semirath = 12,
    Xavias = 10,
    Xel = 15,
    Zurvash = 20,
    Multitude = 7,
}

function _M:godResurrect()
    local deity = self.descriptor.deity
    self:divineMessage(deity, "raise")

    --increase favor penalty by resurrection cost
    --lose a level
    --lose 1 Con
end
