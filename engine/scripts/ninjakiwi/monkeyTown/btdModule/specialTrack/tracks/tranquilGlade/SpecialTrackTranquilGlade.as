package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.tranquilGlade
{
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnDefinition;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackTranquilGlade extends SpecialTrack
   {
       
      
      public function SpecialTrackTranquilGlade()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc3_:* = null;
         super.setSpecialTrack(param1);
         param1.BloonWeights(new BloonWeightsDefinition().StrongestBloonID(Constants.CERAMIC_ID).StrongestBloonType(Constants.CERAMIC_BLOON));
         param1.TerrainType(Constants.TRANQUIL_GLADE);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
         var _loc2_:Object = param1.availableTowers;
         if(_loc2_ != null)
         {
            for(_loc3_ in _loc2_)
            {
               if(!(_loc3_ == Constants.TOWER_DART || _loc3_ == Constants.TOWER_NINJA || _loc3_ == Constants.TOWER_SNIPER))
               {
                  _loc2_[_loc3_].allowed = false;
               }
            }
         }
         if(param1.bloonWeights.strongestBloonID >= Constants.MOAB_ID)
         {
            param1.bloonWeights.StrongestBloonID(Constants.CERAMIC_ID);
            param1.bloonWeights.StrongestBloonType(Constants.CERAMIC_BLOON);
         }
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc4_:Round = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         super.applySpecialTrack(param1);
         var _loc2_:Vector.<Round> = Main.instance.game.level.roundGenerator.rounds;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = _loc4_.queuedBloons.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               (_loc4_.queuedBloons[_loc6_] as BloonSpawnDefinition).spawnType.camo = true;
               _loc6_++;
            }
            _loc3_++;
         }
      }
   }
}
