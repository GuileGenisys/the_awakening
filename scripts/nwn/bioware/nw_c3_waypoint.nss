///////////////////////////////////////////////////////////////////////////////
//:: Restart walk after conversation
//::
//:: NW_C3_Waypoint
//:: Copyright (c) 2000 Bioware Corp.
///////////////////////////////////////////////////////////////////////////////
/*   Reinitaites the walk cycle this script should be placed in the two end
     conversation events in the conversation file(s)on any creature using the
     waypoint set.
*/
///////////////////////////////////////////////////////////////////////////////
//:: Created By: Aidan Scanlan   On: September 6, 2001
///////////////////////////////////////////////////////////////////////////////

void main()
{
    SignalEvent(OBJECT_SELF,EventUserDefined(1));
}
