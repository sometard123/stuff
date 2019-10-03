package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.templeRuins
{
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackTempleRuin extends SpecialTrack
   {
      
      private static const CLIPPING_ROUND:int = 10;
      
      private static const START_ROUND:int = 16;
       
      
      public function SpecialTrackTempleRuin()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc3_:* = null;
         super.setSpecialTrack(param1);
         param1.Difficulty(25);
         param1.BloonWeights(new BloonWeightsDefinition().StrongestBloonID(Constants.BFB_ID).StrongestBloonType(Constants.BFB_BLOON));
         param1.TerrainType(Constants.TERRAIN_RUINS);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
         var _loc2_:Object = param1.availableTowers;
         if(_loc2_ != null)
         {
            for(_loc3_ in _loc2_)
            {
               if(!(_loc3_ == Constants.TOWER_SUPER || _loc3_ == Constants.TOWER_APPRENTICE))
               {
                  _loc2_[_loc3_].allowed = false;
               }
            }
         }
         param1.StartingMoney(30000);
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         super.applySpecialTrack(param1);
         var _loc2_:Vector.<Round> = Main.instance.game.level.roundGenerator.rounds;
         var _loc3_:int = START_ROUND - 1;
         var _loc4_:int = CLIPPING_ROUND;
         if(_loc2_.length >= START_ROUND + CLIPPING_ROUND)
         {
            _loc3_ = START_ROUND - 1;
         }
         else
         {
            _loc3_ = _loc2_.length - CLIPPING_ROUND;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
            _loc4_ = _loc2_.length;
         }
         var _loc5_:Vector.<Round> = _loc2_.splice(_loc3_,_loc4_);
         Main.instance.game.level.roundGenerator.setCustomRounds(_loc5_);
      }
   }
}
