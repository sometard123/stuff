package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class QuestGatherSupplies extends Quest
   {
       
      
      private const DATA_VARIABLE_NAME:String = "gatherSuppliesLandProgress";
      
      protected var _targetForestedLand:int;
      
      public function QuestGatherSupplies(param1:int)
      {
         super();
         this._targetForestedLand = param1;
         AchieveSignal(GameSignals.TILE_CAPTURED_SIGNAL);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<Tile> = MonkeyCityMain.getInstance().worldView.map.getTilesByType().heavyForest;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(!_loc2_[_loc3_].isCaptured)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         var _loc5_:Vector.<Tile> = MonkeyCityMain.getInstance().worldView.map.getTilesByType().lightForest;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(!_loc5_[_loc6_].isCaptured)
            {
               _loc4_++;
            }
            _loc6_++;
         }
         var _loc7_:int = QuestCounter.getInstance().getCustomValue(this.DATA_VARIABLE_NAME) as int;
         var _loc8_:int = this._targetForestedLand - _loc7_;
         var _loc9_:int = _loc1_ + _loc4_;
         if(_loc7_ >= this._targetForestedLand)
         {
            return true;
         }
         if(_loc9_ < _loc8_)
         {
            QuestCounter.getInstance().setCustomValue(this.DATA_VARIABLE_NAME,this._targetForestedLand);
            return true;
         }
         return false;
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         var _loc2_:TileAttackDefinition = null;
         if(rest != null && rest.length > 1 && rest[2] != null)
         {
            _loc2_ = TileAttackDefinition(rest[2]);
         }
         if(_loc2_ == null)
         {
            ErrorReporter.error("QuestGatherSupplies::checkAchieveConditions - tileAttackDefinition cannot be null");
            return;
         }
         if(_loc2_.terrainType != "HeavyForestTerrain" && _loc2_.terrainType != "ForestTerrain")
         {
            return;
         }
         var _loc3_:int = QuestCounter.getInstance().getCustomValue(this.DATA_VARIABLE_NAME) as int;
         _loc3_++;
         QuestCounter.getInstance().setCustomValue(this.DATA_VARIABLE_NAME,_loc3_);
         if(_loc3_ >= this._targetForestedLand)
         {
            super.checkAchieveConditions();
         }
      }
   }
}
