package ninjakiwi.monkeyTown.town.specialMissions
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.town.specialMissions.definition.SpecialMissionDefinition;
   
   public class SpecialMissionsData
   {
      
      public static const WATTLE_TREES:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.WATTLE_TREES);
      
      public static const TRANQUIL_GLADE:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.TRANQUIL_GLADE);
      
      public static const GLACIER:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.GLACIER);
      
      public static const SHIPWRECK:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.SHIPWRECK);
      
      public static const STICKY_SAP_PLANT:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.STICKY_SAP_PLANT);
      
      public static const PHASE_CRYSTAL:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.PHASE_CRYSTAL);
      
      public static const CONSECRATED_GROUND:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.CONSECRATED_GROUND);
      
      public static const MOAB_GRAVEYARD:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.MOAB_GRAVEYARD);
      
      public static const DRY_AS_A_BONE:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.DRY_AS_A_BONE);
      
      public static const SANDSTORM:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.SANDSTORM);
      
      public static const ZZZZOMG:SpecialMissionDefinition = new SpecialMissionDefinition().Id(Constants.ZZZZOMG);
      
      public static const PERFORMANCE_TESTING:SpecialMissionDefinition = new SpecialMissionDefinition().Name("Test Performance").Id(Constants.TEST_PERFORMANCE);
      
      public static const SEND_TESTING:SpecialMissionDefinition = new SpecialMissionDefinition().Name("Test Sending").Id(Constants.EMPTY_ENDLESS);
      
      public static const SPECIAL_MISSIONS:Vector.<SpecialMissionDefinition> = Vector.<SpecialMissionDefinition>([WATTLE_TREES,TRANQUIL_GLADE,GLACIER,SHIPWRECK,STICKY_SAP_PLANT,PHASE_CRYSTAL,CONSECRATED_GROUND,MOAB_GRAVEYARD,DRY_AS_A_BONE,SANDSTORM,ZZZZOMG,PERFORMANCE_TESTING,SEND_TESTING]);
       
      
      public function SpecialMissionsData()
      {
         super();
      }
   }
}
