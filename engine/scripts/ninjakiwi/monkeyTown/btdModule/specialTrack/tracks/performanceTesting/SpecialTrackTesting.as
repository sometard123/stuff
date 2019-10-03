package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.performanceTesting
{
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnType;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackTesting extends SpecialTrack
   {
       
      
      public function SpecialTrackTesting()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.TerrainType(Constants.TERRAIN_GRASS);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
         param1.StartingMoney(19810404);
         param1.StartingLives(19810404);
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc5_:BloonSpawnType = null;
         super.applySpecialTrack(param1);
         var _loc2_:Vector.<Round> = new Vector.<Round>();
         var _loc3_:Round = new Round(Main.instance.game.level);
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc5_ = new BloonSpawnType(Constants.RED_ID);
            _loc5_.Spacing(Constants.SPACING_CLOSE * 10);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc2_.push(_loc3_);
         Main.instance.game.level.roundGenerator.setCustomRounds(_loc2_);
      }
   }
}
