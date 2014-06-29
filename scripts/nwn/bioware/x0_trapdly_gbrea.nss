
//::///////////////////////////////////////////////////
//:: X0_TRAPDLY_GBREA
//:: OnTriggered script for a projectile trap
//:: Spell fired: SPELL_GREATER_SPELL_BREACH
//:: Spell caster level: 11
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/17/2002
//::///////////////////////////////////////////////////

#include "x0_i0_projtrap"

void main()
{
    TriggerProjectileTrap(SPELL_GREATER_SPELL_BREACH, GetEnteringObject(), 11);
}

