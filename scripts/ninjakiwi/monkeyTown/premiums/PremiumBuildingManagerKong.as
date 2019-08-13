package ninjakiwi.monkeyTown.premiums
{
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.analytics.IdleTracker;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.HandShake;
   import ninjakiwi.monkeyTown.pvp.PvPClient;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.quests.QuestData;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class PremiumBuildingManagerKong extends PremiumBuildingManager
   {
      
      private static var _instance:PremiumBuildingManagerKong;
       
      
      public function PremiumBuildingManagerKong()
      {
         super();
         HandShake.sessionInitialisedSignal.add(this.onSessionInitialised);
      }
      
      public static function getInstance() : PremiumBuildingManagerKong
      {
         if(_instance == null)
         {
            _instance = new PremiumBuildingManagerKong();
         }
         return _instance;
      }
      
      private function onSessionInitialised() : void
      {
         this.loadInventory();
      }
      
      override public function initForUser(param1:NKGatewayUser) : void
      {
         super.initForUser(param1);
         _user.gotItemsSignal.remove(onGotItems);
      }
      
      override public function reset() : void
      {
      }
      
      override public function processInventory(param1:NKGatewayUser) : void
      {
      }
      
      private function loadInventory() : void
      {
         Kong.getInventory(function onUserItems(param1:Object):void
         {
            var _loc2_:INumber = null;
            var _loc3_:int = 0;
            var _loc4_:Object = null;
            var _loc5_:MonkeyTownBuildingDefinition = null;
            var _loc6_:String = null;
            var _loc7_:Object = null;
            t.obj(param1);
            if(param1.success)
            {
               for each(_loc2_ in _buildingsBoughtINumbers)
               {
                  _loc2_.value = 0;
               }
               _loc3_ = 0;
               while(_loc3_ < param1.data.length)
               {
                  _loc4_ = param1.data[_loc3_];
                  _loc5_ = _buildingData.getPremiumBuildingDefinitionByNKStoreID(_loc4_.identifier);
                  if(_loc5_ != null)
                  {
                     _loc6_ = _loc5_.id;
                     _loc7_ = _buildingsBoughtINumbers[_loc6_];
                     if(_loc7_ != null)
                     {
                        _loc7_.value++;
                     }
                  }
                  _loc3_++;
               }
            }
         });
      }
      
      private function checkForNewBuildingsInInventory() : void
      {
         Kong.getInventory(function onUserItems(param1:Object):void
         {
            var _loc2_:* = null;
            var _loc3_:Object = null;
            var _loc4_:INumber = null;
            var _loc5_:int = 0;
            var _loc6_:Object = null;
            var _loc7_:String = null;
            var _loc8_:Object = null;
            var _loc9_:int = 0;
            if(param1.success)
            {
               _loc3_ = {};
               for(_loc2_ in _buildingsBoughtINumbers)
               {
                  _loc4_ = _buildingsBoughtINumbers[_loc2_];
                  _loc3_[_loc2_] = _loc4_.value;
                  _loc4_.value = 0;
               }
               _loc5_ = 0;
               while(_loc5_ < param1.data.length)
               {
                  _loc6_ = param1.data[_loc5_];
                  _loc7_ = _buildingData.getPremiumBuildingDefinitionByNKStoreID(_loc6_.identifier).id;
                  _loc8_ = _buildingsBoughtINumbers[_loc7_];
                  if(_loc8_ != null)
                  {
                     _loc8_.value++;
                  }
                  _loc5_++;
               }
               for(_loc2_ in _buildingsBoughtINumbers)
               {
                  _loc4_ = _buildingsBoughtINumbers[_loc2_];
                  if(_loc4_.value > _loc3_[_loc2_])
                  {
                     _loc9_ = _buildingData.getBuildingDefinitionByID(_loc2_).nkItemID;
                     premiumBuildingPurchasedSignal.dispatch(_loc9_,1,_loc2_);
                  }
               }
            }
         });
      }
      
      override public function buyPremiumBuilding(param1:int, param2:String) : void
      {
         var _loc3_:KongStoreAction = new KongStoreAction([param1.toString()],this.onStoreActionComplete);
      }
      
      protected function onStoreActionComplete(param1:KongStoreAction) : void
      {
         t.obj(param1);
         this.checkForNewBuildingsInInventory();
      }
   }
}
