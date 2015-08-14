--Veins of the Earth
--Zireael 2015

require 'engine.class'

--Handle actor skills
module(..., package.seeall, class.make)

--what it says on the tin
function _M:domainSelection(actor)
    --Domain selection
    if actor:hasDescriptor{deity="Aiswin"} then
    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Fate", desc=""},
    {name="Knowledge", desc=""},
    {name="Night", desc=""},
    {name="Planning", desc=""},
    {name="Retribution", desc=""},
    {name="Trickery", desc=""},
    },
    function(result)
        if result == "Fate" then end
        if result == "Knowledge" then end
        if result == "Night" then end
        if result == "Planning" then end
        if result == "Retribution" then end
        if result == "Trickery" then end
    end))

    end

    if actor:hasDescriptor{deity="Asherath"} then
     game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Fate", desc=""},
    {name="Knowledge", desc=""},
    {name="Night", desc=""},
    {name="Planning", desc=""},
    {name="Retribution", desc=""},
    {name="Trickery", desc=""},
    },
    function(result)
        if result == "Fate" then end
        if result == "Knowledge" then end
        if result == "Night" then end
        if result == "Planning" then end
        if result == "Retribution" then end
        if result == "Trickery" then end
    end))

    end

    if actor:hasDescriptor{deity="Ekliazeh"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Craft", desc=""},
    {name="Community", desc=""},
    {name="Earth", desc=""},
    {name="Law", desc=""},
    {name="Strength", desc=""},
    {name="Protection", desc=""},
    },
    function(result)
        if result == "Craft" then end
        if result == "Community" then end
        if result == "Earth" then end
        if result == "Law" then end
        if result == "Strength" then end
        if result == "Protection" then end
    end))

    end

    if actor:hasDescriptor{deity="Erich"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Domination", desc=""},
    {name="Guardian", desc=""},
    {name="Law", desc=""},
    {name="Nobility", desc=""},
    {name="Protection", desc=""},
    {name="War", desc=""},
    },
    function(result)
        if result == "Domination" then end
        if result == "Guardian" then end
        if result == "Law" then end
        if result == "Nobility" then end
        if result == "Protection" then end
        if result == "War" then end
    end))

    end

    if actor:hasDescriptor{deity="Essiah"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Beauty", desc=""},
    {name="Good", desc=""},
    {name="Liberation", desc=""},
    {name="Luck", desc=""},
    {name="Passion", desc=""},
    {name="Travel", desc=""},
    },
    function(result)
        if result == "Beauty" then end
        if result == "Good" then end
        if result == "Liberation" then end
        if result == "Luck" then end
        if result == "Passion" then end
        if result == "Travel" then end
    end))

    end

    if actor:hasDescriptor{deity="Hesani"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Fate", desc=""},
    {name="Healing", desc=""},
    {name="Magic", desc=""},
    {name="Succor", desc=""},
    {name="Sun", desc=""},
    {name="Weather", desc=""},
    },
    function(result)
        if result == "Fate" then end
        if result == "Healing" then end
        if result == "Magic" then end
        if result == "Succor" then end
        if result == "Sun" then end
        if result == "Weather" then end
    end))
    end

    if actor:hasDescriptor{deity="Immotian"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Community", desc=""},
    {name="Fire", desc=""},
    {name="Knowledge", desc=""},
    {name="Law", desc=""},
    {name="Protection", desc=""},
    {name="Succor", desc=""},
    },
    function(result)
        if result == "Community" then end
        if result == "Fire" then end
        if result == "Knowledge" then end
        if result == "Law" then end
        if result == "Protection" then end
        if result == "Succor" then end
    end))

    end

    if actor:hasDescriptor{deity="Khasrach"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Destruction", desc=""},
    {name="Hatred", desc=""},
    {name="Mysticism", desc=""},
    {name="Strength", desc=""},
    {name="Pain", desc=""},
    {name="War", desc=""},
    },
    function(result)
        if result == "Destruction" then end
        if result == "Hatred" then end
        if result == "Mysticism" then end
        if result == "Strength" then end
        if result == "Pain" then end
        if result == "War" then end
    end))

    end

    if actor:hasDescriptor{deity="Kysul"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Fate", desc=""},
    {name="Good", desc=""},
    {name="Mysticism", desc=""},
    {name="Planning", desc=""},
    {name="Slime", desc=""},
    {name="Water", desc=""},
    },
    function(result)
        if result == "Fate" then end
        if result == "Good" then end
        if result == "Mysticism" then end
        if result == "Planning" then end
        if result == "Slime" then end
        if result == "Water" then end
    end))

    end

    if actor:hasDescriptor{deity="Maeve"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Beauty", desc=""},
    {name="Chaos", desc=""},
    {name="Domination", desc=""},
    {name="Magic", desc=""},
    {name="Moon", desc=""},
    {name="Nobility", desc=""},
    },
    function(result)
        if result == "Beauty" then end
        if result == "Chaos" then end
        if result == "Domination" then end
        if result == "Magic" then end
        if result == "Moon" then end
        if result == "Nobility" then end
    end))

    end

    if actor:hasDescriptor{deity="Mara"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Beauty", desc=""},
    {name="Death", desc=""},
    {name="Good", desc=""},
    {name="Healing", desc=""},
    {name="Night", desc=""},
    {name="Succor", desc=""},
    },
    function(result)
        if result == "Beauty" then end
        if result == "Death" then end
        if result == "Good" then end
        if result == "Healing" then end
        if result == "Night" then end
        if result == "Succor" then end
    end))

    end

    if actor:hasDescriptor{deity="Sabin"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Air", desc=""},
    {name="Chaos", desc=""},
    {name="Destruction", desc=""},
    {name="Luck", desc=""},
    {name="Time", desc=""},
    {name="Weather", desc=""},
    },
    function(result)
        if result == "Air" then end
        if result == "Chaos" then end
        if result == "Destruction" then end
        if result == "Luck" then end
        if result == "Time" then end
        if result == "Weather" then end
    end))

    end

    if actor:hasDescriptor{deity="Semirath"} then
    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Chaos", desc=""},
    {name="Good", desc=""},
    {name="Liberation", desc=""},
    {name="Luck", desc=""},
    {name="Retribution", desc=""},
    {name="Trickery", desc=""},
    },
    function(result)
        if result == "Chaos" then end
        if result == "Good" then end
        if result == "Liberation" then end
        if result == "Luck" then end
        if result == "Retribution" then end
        if result == "Trickery" then end
    end))

    end

    if actor:hasDescriptor{deity="Multitude"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Blood", desc=""},
    {name="Chaos", desc=""},
    {name="Destruction", desc=""},
    {name="Death", desc=""},
    {name="Evil", desc=""},
    {name="Pain", desc=""},
    },
    function(result)
        if result == "Blood" then end
        if result == "Chaos" then end
        if result == "Destruction" then end
        if result == "Death" then end
        if result == "Evil" then end
        if result == "Pain" then end
    end))

    end

    if actor:hasDescriptor{deity="Xavias"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Craft", desc=""},
    {name="Fate", desc=""},
    {name="Knowledge", desc=""},
    {name="Magic", desc=""},
    {name="Mysticism", desc=""},
    {name="Planning", desc=""},
    },
    function(result)
        if result == "Craft" then end
        if result == "Fate" then end
        if result == "Knowledge" then end
        if result == "Magic" then end
        if result == "Mysticism" then end
        if result == "Planning" then end
    end))

    end

    if actor:hasDescriptor{deity="Xel"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Community", desc=""},
    {name="Death", desc=""},
    {name="Evil", desc=""},
    {name="Pain", desc=""},
    {name="Nature", desc=""},
    {name="Trickery", desc=""},
    },
    function(result)
        if result == "Community" then end
        if result == "Death" then end
        if result == "Evil" then end
        if result == "Pain" then end
        if result == "Nature" then end
        if result == "Trickery" then end
    end))
    end

    if actor:hasDescriptor{deity="Zurvash"} then
        game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
    {name="Animal", desc=""},
    {name="Domination", desc=""},
    {name="Night", desc=""},
    {name="Passion", desc=""},
    {name="Pain", desc=""},
    {name="Strength", desc=""},
    },
    function(result)
        if result == "Animal" then end
        if result == "Domination" then end
        if result == "Night" then end
        if result == "Passion" then end
        if result == "Pain" then end
        if result == "Strength" then end
    end))

    end
end
