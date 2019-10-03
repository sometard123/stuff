package ninjakiwi.monkeyTown.net.kloud
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.ui.SavingNotifier;
   import ninjakiwi.mynk.save.TrafficGate;
   
   public class CityDataPersistence
   {
      
      public static const CONTENT_KEY:String = "content";
      
      public static const WORLD_SEED_KEY:String = "worldSeed";
      
      public static const TERRAIN_DATA_KEY:String = "terrainData";
      
      public static const UPGRADE_TREE_KEY:String = "upgradeTree";
      
      public static const CITY_RESOURCES_KEY:String = "cityResources";
      
      public static const CITY_QUESTS_KEY:String = "cityQuests";
      
      public static const CITY_STATS_KEY:String = "cityStats";
      
      public static const TILES_KEY:String = "tiles";
      
      private static var instance:CityDataPersistence;
       
      
      private var _trafficGate:TrafficGate;
      
      private var _saveData:Object;
      
      private var _isSaving:Boolean = false;
      
      private var _saveInProgress:Boolean = false;
      
      private var _saveIsQueued:Boolean = false;
      
      public function CityDataPersistence(param1:SingletonEnforcer#1038)
      {
         this._trafficGate = new TrafficGate();
         this._saveData = {};
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use CityDataPersistence.getInstance() instead of new.");
         }
         this.initListeners();
      }
      
      public static function getInstance() : CityDataPersistence
      {
         if(instance == null)
         {
            instance = new CityDataPersistence(new SingletonEnforcer#1038());
         }
         return instance;
      }
      
      private function initListeners() : void
      {
      }
      
      public function saveValue(param1:String, param2:*) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:Tile = null;
         var _loc7_:int = 0;
         var _loc8_:Tile = null;
         if(TILES_KEY == param1)
         {
            if(this._saveData.hasOwnProperty(TILES_KEY) == false)
            {
               this._saveData[TILES_KEY] = param2;
            }
            else
            {
               _loc3_ = this._saveData[TILES_KEY] as Array;
               _loc4_ = param2 as Array;
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length)
               {
                  _loc6_ = _loc4_[_loc5_];
                  _loc7_ = 0;
                  while(_loc7_ < _loc3_.length)
                  {
                     _loc8_ = _loc3_[_loc7_];
                     if(_loc6_.positionTilespace.x == _loc8_.positionTilespace.x && _loc6_.positionTilespace.y == _loc8_.positionTilespace.y)
                     {
                        _loc3_.splice(_loc7_,1);
                     }
                     _loc7_++;
                  }
                  _loc5_++;
               }
               this._saveData[TILES_KEY] = _loc3_.concat(_loc4_);
            }
         }
         else
         {
            if(this._saveData.hasOwnProperty(CONTENT_KEY) == false)
            {
               this._saveData[CONTENT_KEY] = {};
            }
            this._saveData[CONTENT_KEY][param1] = param2;
         }
         SavingNotifier.trafficGateOn();
         this._isSaving = true;
         if(this._saveInProgress)
         {
            this._saveIsQueued = true;
         }
         else
         {
            this._trafficGate.callFunction(this.finalSave);
         }
      }
      
      private function finalSave() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:Tile = null;
         var _loc4_:int = 0;
         var _loc5_:Tile = null;
         if(this._saveData[TILES_KEY])
         {
            _loc1_ = this._saveData[TILES_KEY];
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc3_ = _loc1_[_loc2_];
               _loc4_ = 0;
               while(_loc4_ < _loc1_.length)
               {
                  if(_loc2_ != _loc4_)
                  {
                     _loc5_ = _loc1_[_loc4_];
                     if(_loc3_.positionTilespace.x == _loc5_.positionTilespace.x && _loc3_.positionTilespace.y == _loc5_.positionTilespace.y)
                     {
                     }
                  }
                  _loc4_++;
               }
               _loc2_++;
            }
         }
         Kloud.saveContent(this._saveData,this.onSaveComplete);
         this._saveData = {};
         this._saveInProgress = true;
      }
      
      private function onSaveComplete(... rest) : void
      {
         this._saveInProgress = false;
         if(this._saveIsQueued)
         {
            this._trafficGate.callFunction(this.finalSave);
            this._saveIsQueued = false;
         }
         else
         {
            this._isSaving = false;
            SavingNotifier.trafficGateOff();
         }
      }
      
      public function get isSaving() : Boolean
      {
         return this._isSaving;
      }
   }
}

class SingletonEnforcer#1038
{
    
   
   function SingletonEnforcer#1038()
   {
      super();
   }
}
