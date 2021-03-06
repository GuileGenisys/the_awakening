resref = "fab_druid_helm"

-- Properties
properties = {
   AC(6),
   Ability(CRE.ABILITY_STRENGTH, Random(3, 5)),
   Ability(CRE.ABILITY_WISDOM, 4),
   Ability(CRE.ABILITY_CHARISMA, 4),
   DamageImmunity(DAMAGE.DIVINE, 62),
   DamageImmunity(DAMAGE.MAGICAL, 60),
   DamageImmunity(DAMAGE.NEGATIVE, 60),
   DamageImmunity(DAMAGE.POSITIVE, 60),
   BonusLevelSpell(CLASS.DRUID, 6, 2),
   BonusLevelSpell(CLASS.DRUID, 7, 2),
   BonusLevelSpell(CLASS.DRUID, 8, 2),
   BonusLevelSpell(CLASS.DRUID, 9),
   Skill(SKILL.CRAFT_ARMOR, 4),
   Skill(SKILL.CRAFT_WEAPON, 4),
   Skill(SKILL.CONCENTRATION, 6),
   Skill(SKILL.ANIMAL_EMPATHY, 6),
   Skill(SKILL.SPELLCRAFT, 6),
   Regeneration(6),
   TrueSeeing(),
   Immunity(IMMUNITYMISC_MINDSPELLS),
   SavingThrowVersus(SAVEVS_UNIVERSAL, 3),
}