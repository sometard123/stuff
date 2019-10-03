package ninjakiwi.monkeyTown.achievements.tests
{
   import ninjakiwi.monkeyTown.achievements.AchievementsConfig;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.CapturedTilesByType;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   
   public class TileCapturedTest extends AchievementTest
   {
       
      
      private var _specialTerrainKeysCity1:Array;
      
      private var _specialTerrainKeysCity2:Array;
      
      private var _system:MonkeySystem;
      
      public function TileCapturedTest()
      {
         this._system = MonkeySystem.getInstance();
         super();
         this.setupSpecialTerrainKeys();
         GameSignals.TILE_CAPTURED_SIGNAL.addWithPriority(this.onTileCaptured,LISTENER_PRIORITY);
      }
      
      private function setupSpecialTerrainKeys() : void
      {
         var _loc1_:TileDefinitions = TileDefinitions.getInstance();
         this._specialTerrainKeysCity1 = [_loc1_.WATTLE_TREES,_loc1_.TRANQUIL_GLADE,_loc1_.GLACIER,_loc1_.SHIPWRECK,_loc1_.PHASE_CRYSTAL,_loc1_.STICKY_SAP_PLANT,_loc1_.CONSECRATED_GROUND,_loc1_.MOAB_GRAVEYARD];
         this._specialTerrainKeysCity2 = [_loc1_.WATTLE_TREES,_loc1_.TRANQUIL_GLADE,_loc1_.GLACIER,_loc1_.SHIPWRECK,_loc1_.PHASE_CRYSTAL,_loc1_.STICKY_SAP_PLANT,_loc1_.CONSECRATED_GROUND,_loc1_.MOAB_GRAVEYARD,_loc1_.DRY_AS_A_BONE,_loc1_.SANDSTORM,_loc1_.ZZZZOMG];
      }
      
      private function onTileCaptured(... rest) : void
      {
         var _loc14_:Array = null;
         var _loc25_:String = null;
         var _loc26_:Number = NaN;
         var _loc2_:TileDefinitions = TileDefinitions.getInstance();
         var _loc3_:int = MonkeySystem.getInstance().map.totalCapturedCount();
         var _loc4_:Tile = rest[0];
         if(_loc4_.terrainSpecialProperty !== null)
         {
            _loc25_ = _loc4_.terrainSpecialProperty.id;
            if(_loc25_ === _loc2_.DRY_AS_A_BONE)
            {
               _achievementsManager.setAchievementProgress(_achievementsManager.DRY_AS_A_BONE,101);
            }
            else if(_loc25_ === _loc2_.SANDSTORM)
            {
               _achievementsManager.setAchievementProgress(_achievementsManager.SANDSTORM,101);
            }
            else if(_loc25_ === _loc2_.ZZZZOMG)
            {
               _achievementsManager.setAchievementProgress(_achievementsManager.ZZZZOMG,101);
            }
         }
         var _loc5_:Number = 100 * (_loc3_ / AchievementsConfig.LAND_SURVEYER_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.LAND_SURVEYOR,_loc5_);
         var _loc6_:Number = 100 * (_loc3_ / AchievementsConfig.LAND_AHOY_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.LAND_AHOY,_loc6_);
         var _loc7_:Number = 100 * (_loc3_ / AchievementsConfig.MONKEY_LAND_TRUST_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.MONKEY_LAND_TRUST,_loc7_);
         var _loc8_:Number = 100 * (_loc3_ / AchievementsConfig.MONKEY_LAND_CONSERVANCY_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.MONKEY_LAND_CONSERVANCY,_loc8_);
         var _loc9_:CapturedTilesByType = MonkeyCityMain.getInstance().worldView.map.getCapturedTilesByType();
         var _loc10_:Number = 100 * ((_loc9_.river.length + _loc9_.lakes.length) / AchievementsConfig.HERES_MY_WATER_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.HERES_MY_WATER,_loc10_);
         var _loc11_:Number = 100 * ((_loc9_.mountains.length + _loc9_.volcanoes.length) / AchievementsConfig.HIGH_GROUND_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.HIGH_GROUND,_loc11_);
         var _loc12_:Number = 100 * (_statsData.treasureChestsCaptured.value / AchievementsConfig.TREASURE_HUNTER_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.TREASURE_HUNTER,_loc12_);
         var _loc13_:Number = 100 * (_statsData.treasureChestsCaptured.value / AchievementsConfig.TREASURE_TROVE_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.TREASURE_TROVE,_loc13_);
         if(MonkeySystem.getInstance().city.cityIndex == 0)
         {
            _loc14_ = this._specialTerrainKeysCity1;
         }
         else if(MonkeySystem.getInstance().city.cityIndex == 1)
         {
            _loc14_ = this._specialTerrainKeysCity2;
         }
         var _loc15_:Object = MonkeySystem.getInstance().map.getCapturedSpecialTerrains();
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         while(_loc17_ < _loc14_.length)
         {
            if(_loc15_.hasOwnProperty(_loc14_[_loc17_]))
            {
               _loc16_++;
            }
            _loc17_++;
         }
         var _loc18_:Number = 100 * (_loc16_ / _loc14_.length);
         _achievementsManager.setAchievementProgress(_achievementsManager.EXTRA_SPECIAL,_loc18_);
         var _loc19_:int = _loc9_.desertBadlands.length;
         var _loc20_:Number = 100 * (_loc19_ / AchievementsConfig.ARE_THERE_GOOD_LANDS_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.ARE_THERE_GOOD_LANDS,_loc20_);
         var _loc21_:int = _loc9_.desertAridGrasslands.length;
         var _loc22_:Number = 100 * (_loc21_ / AchievementsConfig.GRASS_LAND_EXPLORER_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.GRASS_LAND_EXPLORER,_loc22_);
         var _loc23_:int = _loc9_.desertHighlands.length;
         var _loc24_:Number = 100 * (_loc23_ / AchievementsConfig.HIGH_LAND_FLING_THRESHOLD);
         _achievementsManager.setAchievementProgress(_achievementsManager.HIGHLAND_FLING,_loc24_);
         if(this._system.city.cityIndex === 1)
         {
            _loc26_ = 100 * (TrackManager.getInstance().totalUnlocked / AchievementsConfig.TRACK_MASTER_THRESHOLD);
            _achievementsManager.setAchievementProgress(_achievementsManager.TRACK_MASTER,_loc26_);
         }
      }
   }
}
