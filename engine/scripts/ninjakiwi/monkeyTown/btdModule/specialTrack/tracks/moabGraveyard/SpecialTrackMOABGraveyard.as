package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.moabGraveyard
{
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnType;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackMOABGraveyard extends SpecialTrack
   {
      
      public static const SPACING_NORMAL:Number = 0.6;
       
      
      public function SpecialTrackMOABGraveyard()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.TerrainType(Constants.MOAB_GRAVEYARD);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
         param1.StartingMoney(30000);
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc5_:BloonSpawnType = null;
         super.applySpecialTrack(param1);
         var _loc2_:Vector.<Round> = new Vector.<Round>();
         var _loc3_:Round = new Round(Main.instance.game.level);
         var _loc4_:int = 0;
         _loc5_ = new BloonSpawnType(Constants.MOAB_ID);
         _loc5_.Spacing(Constants.SPACING_NORMAL);
         _loc3_.queueBloon(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < 2)
         {
            _loc5_ = new BloonSpawnType(Constants.MOAB_ID);
            _loc5_.Spacing(Constants.SPACING_NORMAL * 35);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc5_ = new BloonSpawnType(Constants.MOAB_ID);
            _loc5_.Spacing(Constants.SPACING_NORMAL * 30);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc5_ = new BloonSpawnType(Constants.MOAB_ID);
            _loc5_.Spacing(Constants.SPACING_NORMAL * 20);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc2_.push(_loc3_);
         _loc3_ = new Round(Main.instance.game.level);
         _loc5_ = new BloonSpawnType(Constants.BFB_ID);
         _loc5_.Spacing(Constants.SPACING_NORMAL);
         _loc3_.queueBloon(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc5_ = new BloonSpawnType(Constants.BFB_ID);
            _loc5_.Spacing(Constants.SPACING_NORMAL * 110);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc2_.push(_loc3_);
         _loc3_ = new Round(Main.instance.game.level);
         _loc5_ = new BloonSpawnType(Constants.BOSS_ID);
         _loc5_.Spacing(Constants.SPACING_NORMAL);
         _loc3_.queueBloon(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < 1)
         {
            _loc5_ = new BloonSpawnType(Constants.BOSS_ID);
            _loc5_.Spacing(Constants.SPACING_NORMAL * 170);
            _loc3_.queueBloon(_loc5_);
            _loc4_++;
         }
         _loc2_.push(_loc3_);
         Main.instance.game.level.roundGenerator.setCustomRounds(_loc2_);
      }
   }
}
