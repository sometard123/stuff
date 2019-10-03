package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.glacier
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackGlacier extends SpecialTrack
   {
       
      
      public function SpecialTrackGlacier()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.Difficulty(23);
         param1.BloonWeights(new BloonWeightsDefinition().StrongestBloonID(Constants.MOAB_ID).StrongestBloonType(Constants.MOAB_BLOON));
         param1.TerrainType(Constants.GLACIER);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         super.applySpecialTrack(param1);
         Bloon.baseSpeedModifier = 0.5;
         Bloon.cashChanceModifier = 0.5;
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         Bloon.baseSpeedModifier = 1;
         Bloon.cashChanceModifier = 1;
      }
   }
}
