package ninjakiwi.monkeyTown.btdModule.towers
{
   import display.ui.Button;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class TerrainRestrictionManager
   {
      
      private static var _instance:TerrainRestrictionManager = null;
       
      
      public function TerrainRestrictionManager()
      {
         super();
      }
      
      public static function getInstance() : TerrainRestrictionManager
      {
         if(_instance == null)
         {
            _instance = new TerrainRestrictionManager();
         }
         return _instance;
      }
      
      public function applyCosts(param1:Object) : void
      {
         var _loc2_:TowerPickerDef = null;
         var _loc3_:UpgradePathDef = null;
         var _loc4_:UpgradeDef = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         for(_loc5_ in param1)
         {
            _loc2_ = Main.instance.towerMenuSet.getPickerByTowerID(_loc5_);
            if(param1[_loc5_].costModifier != null)
            {
               if(_loc2_ != null)
               {
                  _loc2_.Cost(_loc2_.cost * Number(param1[_loc5_].costModifier));
               }
               _loc3_ = Main.instance.towerFactory.getUpgrades(_loc5_);
               if(_loc3_ != null && _loc3_.upgrades != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc3_.upgrades.length)
                  {
                     _loc7_ = 0;
                     while(_loc7_ < _loc3_.upgrades[_loc6_].length)
                     {
                        _loc4_ = _loc3_.upgrades[_loc6_][_loc7_];
                        _loc4_.cost = _loc4_.cost * Number(param1[_loc5_].costModifier);
                        _loc7_++;
                     }
                     _loc6_++;
                  }
                  continue;
               }
               continue;
            }
         }
      }
      
      public function applyTowerAvailability(param1:Object) : void
      {
         var _loc2_:TowerPickerDef = null;
         var _loc3_:Button = null;
         var _loc4_:* = null;
         for(_loc4_ in param1)
         {
            _loc2_ = Main.instance.towerMenuSet.getPickerByTowerID(_loc4_);
            _loc3_ = Main.instance.game.inGameMenu.towerMenu.getButtonByTowerID(_loc4_);
            if(Main.instance.game.gameRequest.specialMissionID != Constants.EMPTY_ENDLESS)
            {
               if(param1[_loc4_].allowed != null && Boolean(param1[_loc4_].allowed) == false)
               {
                  if(_loc3_ != null)
                  {
                     if(MovieClip(_loc3_).lock_mc != null)
                     {
                        MovieClip(_loc3_).lock_mc.visible = true;
                     }
                     _loc3_.click = null;
                     _loc3_.tooltip = "<font color=\'#E0CDB6\' face=\'Oetztype\'>" + _loc2_.tower.label + "</font>\nThese are not allowed on this terrain";
                     _loc2_.hotKey = 0;
                  }
               }
            }
            if(param1[_loc4_].costModifier != null && Number(param1[_loc4_].costModifier) < 1)
            {
               if(_loc3_ != null)
               {
                  if(MovieClip(_loc3_).favouredTick != null)
                  {
                     MovieClip(_loc3_).favouredTick.visible = true;
                  }
               }
            }
         }
      }
   }
}
