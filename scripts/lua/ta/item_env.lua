--- Item Generator Environment.
-- @module ta.item_env
-- @alias E

local ffi = require 'ffi'
local ip = require 'solstice.itemprop'
local ipc = ip.const
local E = {}

E.CRE = require('solstice.creature').const
E.DAMAGE = require('solstice.damage').const
E.CLASS = require('solstice.class').const
E.SKILL = require('solstice.skill').const
E.DAMAGE = require('solstice.damage').const

local function add_ip(fname, ...)
   local t = {...}
   t.f = fname
   return t
end

E.Random = Dyn.Random
E.Chance = Dyn.Chance

--- Create Ability bonus/penalty item property.
-- @param ability CRE.ABILITY_*
-- @param mod Bonus: [1, 12], Penalty [-12, -1]
function E.Ability(ability, mod)
   return add_ip("AbilityScore", ability, mod)
end


--- Create AC item property
-- @param value Bonus: [1,20] Penaly [-20, -1]
function E.AC(value)
   return add_ip("AC", value)
end

--- Creates additional item property
-- @param addition ADDITIONAL_*
function E.Additional(addition)
   return add_ip("Additional", addition)
end

--- Create arcane spell failure item property
-- @param value
function E.ArcaneSpellFailure(value)
   return add_ip("ArcaneSpellFailure", value)
end

--- Creatures attack modifier item property
-- @param value [1,20] or [-5, -1]
function E.AttackModifier(value)
   return add_ip("AttackModifier", value)
end

--- Item Property Bonus Feat
-- @param feat solstice.itemprop.FEAT_*
function E.BonusFeat(value)
   return add_ip("BonusFeat", value)
end

--- Creates a "bonus spell of a specified level" itemproperty.
-- @param class CLASS.* constant
-- @param level [0, 9]
-- @param n Number of spell slots to add.
function E.BonusLevelSpell(class, level, n)
   local t = add_ip("BonusLevelSpell", class, level)
   t.n = n
   return t
end

--- Creates a "cast spell" itemproperty.
-- @param spell solstice.itemprop.const.CASTSPELL_*
-- @param uses solstice.itemprop.const.CASTSPELL_NUMUSES_*
function E.CastSpell(spell, uses)
   return add_ip("CastSpell", spell, uses)
end

--- Create a "reduced weight container" itemproperty.
-- @param amount CONTAINERWEIGHTRED_*
function E.ContainerReducedWeight(amount)
   return add_ip("ContainerReducedWeight", amount)
end

--- Creates a damage bonus itemproperty.
-- @param damage_type DAMAGE.* constant.
-- @param damage DAMAGE.BONUS_*
function E.DamageBonus(damage_type, damage)
   return add_ip("DamageBonus", damage_type, damage)
end

--- Creates a damage immunity itemproperty.
-- @param damage_type solstice.damage type constant.
-- @param amount solstice.itemprop.const.DAMAGEIMMUNITY_*
function E.DamageImmunity(damage_type, amount)
   return add_ip("DamageImmunity", damage_type, amount)
end

--- Creatses a damage penalty itemproperty.
-- @param amount [1,5]
function E.DamagePenalty(amount)
   return add_ip("DamagePenalty", amount)
end

--- Creates a damage reduction itemproperty.
-- @param enhancement solstice.itemprop.REDUCTION_*
-- @param soak solstice.itemprop.SOAK_*
function E.DamageReduction(enhancement, soak)
   return add_ip("DamageReduction", enhancement, soak)
end

--- Creates damage resistance item property.
-- @param damage_type solstice.damage type constant.
-- @param amount solstice.itemprop.RESIST_*
function E.DamageResistance(damage_type, amount)
   return add_ip("DamageResistance", damage_type, amount)
end

--- Creates damage vulnerability item property.
-- @param damage_type solstice.damage type constant.
-- @param amount solstice.itemprop.const.DAMAGEVULNERABILITY_*
function E.DamageVulnerability(damage_type, amount)
   return add_ip("DamageVulnerability", damage_type, amount)
end

--- Creates Darkvision Item Property
function E.Darkvision()
   return add_ip("Darkvision")
end

--- Item Property Enhancement Bonus
-- @see solstice.itemprop.EnhancementModifier
function E.EnhancementModifier(value)
   return add_ip("EnhancementModifier", value)
end

--- Creates an "extra damage type" item property.
-- @param damage_type DAMAGE.*
-- @param[opt=false] is_ranged ExtraRangedDamge if true, melee if false.
function E.ExtraDamageType(damage_type, is_ranged)
   return add_ip("ExtraDamageType", damage_type, is_ranged)
end

--- Creates a free action (freedom of movement) itemproperty.
function E.Freedom()
   return add_ip("Freedom")
end

--- Creates haste item property.
function E.Haste()
   return add_ip("Haste")
end

--- Creates a healers' kit item property.
-- @param modifier [1,12]
function E.HealersKit(modifier)
   return add_ip("HealersKit", modifier)
end

--- Creates Holy Avenger item propety.
function E.HolyAvenger()
   return add_ip("HolyAvenger")
end

--- Creates immunity item property
-- @param immumity_type solstice.itemprop.IMMUNITYMISC_*
function E.Immunity(immumity_type)
   return add_ip("ImmunityMisc", immumity_type)
end

--- Creates Improved evasion item property.
function E.ImprovedEvasion()
   return add_ip("ImprovedEvasion")
end

--- Creates keen item property
function E.Keen()
   return add_ip("Keen")
end

--- Creates a light item property.
-- @param brightness LIGHTBRIGHTNESS_*
-- @param color LIGHTCOLOR_*
function E.Light(brightness, color)
   return add_ip("Light", brightness, color)
end

--- Creates a class use limitation item property
-- @param class solstice.class constant
function E.LimitUseByClass(class)
   return add_ip("LimitUseByClass", class)
end

--- Creates a race use limitation item property
-- @param race Racial type
function E.LimitUseByRace(race)
   return add_ip("LimitUseByRace", race)
end

--- Creates a massive criticals item property.
-- @param damage solstice.damage.BONUS_*
function E.MassiveCritical(damage)
   return add_ip("MassiveCritical", damage)
end

--- Creates material item property
-- @param material The material type should be [0, 77] based on
-- iprp_matcost.2da.
function E.Material(material)
   return add_ip("Material", material)
end

--- Creates a mighty item property.
-- @param modifier [1,20]
function E.Mighty(value)
   return add_ip("Mighty", value)
end

--- Creates Monster Damage effect.
-- @param damage solstice.itemprop.const.MONSTERDAMAGE_*
function E.MonsterDamage(damage)
   return add_ip("MonsterDamage", damage)
end

--- Creates no damage item property
function E.NoDamage()
   return add_ip("NoDamage")
end

--- Creates an "on hit cast spell" item property.
-- @param spell solstice.itemprop.const.ONHIT_CASTSPELL_*
-- @param level Level spell is cast at.
function E.OnHitCastSpell(spell, level)
   return add_ip("OnHitCastSpell", spell, level)
end

--- Creates on monster hit item property.
-- NOTE: Item property is bugged.  See NWN Lexicon.
-- @param prop solstice.itemprop.const.ONMONSTERHIT_*
-- @param special ???
function E.OnHitMonster(prop, special)
   return add_ip("OnHitMonster", prop, special)
end

--- Creates an OnHit itemproperty.
-- @param prop solstice.itemprop.const.ONHIT_*
-- @param dc solstice.itemprop.const.ONHIT_SAVEDC_*
-- @param special Meaning varies with type. (Default: 0)
function E.OnHit(prop, dc, special)
   return add_ip("OnHitProps", prop, dc, special)
end

--- Creates a regeneration item property.
-- @param amount [1, 20]
function E.Regeneration(amount)
   return add_ip("Regeneration", amount)
end

--- Creates quality item property
-- @param quality solstice.itemprop.const.QUALITY_*
function E.Quality(quality)
   return add_ip("Quality", quality)
end

--- Creates saving throw bonus item property
-- @param save_type solstice.itemprop.const.SAVEBASETYPE_*
-- @param amount [1,20] or [-20, -1]
function E.SavingThrow(save, amount)
   return add_ip("SavingThrow", save, amount)
end

--- Creates saving throw bonus vs item property
-- @param save_type solstice.itemprop.const.SAVEVS_*
-- @param amount [1,20] or [-20, -1]
function E.SavingThrowVersus(save, amount)
   return add_ip("SavingThrowVersus", save, amount)
end

--- Creates skill modifier item property
-- @param skill solstice.skill type constant.
-- @param amount [1, 50] or [-10, -1]
function E.Skill(skill, mod)
   return add_ip("SkillModifier", skill, mod)
end

--- Create an "immunity to spell level" item property.
-- @param level Spell level [1,9]
function E.SpellImmunityLevel(level)
   return add_ip("SpellImmunityLevel", level)
end

--- Creates an "immunity to specific spell" itemproperty.
-- @param spell solstice.itemprop.const.IMMUNITYSPELL_*
function E.SpellImmunitySpecific(spell)
   return add_ip("SpellImmunitySpecific", spell)
end

--- Creates an "immunity against spell school" itemproperty.
-- @param school solstice.itemprop.const.SPELLSCHOOL_*
function E.SpellImmunitySchool(school)
   return add_ip("SpellImmunitySchool", school)
end

--- Creates a spell resistince item property
-- @param amount solstice.itemprop.const.SPELLRESISTANCEBONUS_*
function E.SpellResistance(amount)
   return add_ip("SpellResistance", amount)
end

--- Creates a thieves tool item property
-- @param modifier [1, 12]
function E.ThievesTools(modifier)
   return add_ip("ThievesTools", modifier)
end

--- Creates a trap item property
-- @param level TRAPSTRENGTH_*
-- @param trap_type TRAPTYPE_*
function E.Trap(level, trap_type)
   return add_ip("Trap", level, trap_type)
end

--- Creates true seeing item property
function E.TrueSeeing()
   return add_ip("TrueSeeing")
end

--- Creates a turn resistance item property.
-- @param value [1, 50]
function E.TurnResistance(value)
   return add_ip("TurnResistance", value)
end

--- Creates an unlimited ammo itemproperty.
-- @param ammo UNLIMITEDAMMO_*
function E.UnlimitedAmmo(ammo)
   return add_ip("UnlimitedAmmo", ammo)
end

--- Creates vampiric regeneration effect.
-- @param amount [1,20]
function E.VampiricRegeneration(amount)
   return add_ip("VampiricRegeneration", amount)
end

--- Creates a visual effect item property
-- @param effect VISUAL_*
function E.VisualEffect(effect)
   return add_ip("VisualEffect", effect)
end

--- Item Property Weight Increase
-- @param amount WEIGHTINCREASE_*
function E.WeightIncrease(amount)
   return add_ip("WeightIncrease", amount)
end

--- Item Property Weight Reuction
-- @param amount REDUCEDWEIGHT_*
function E.WeightReduction(amount)
   return add_ip("WeightReduction", amount)
end


return E
