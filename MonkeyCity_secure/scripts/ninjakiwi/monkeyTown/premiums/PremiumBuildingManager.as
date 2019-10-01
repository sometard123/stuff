package ninjakiwi.monkeyTown.premiums
{
   import assets.ui.CTMilestonesIconClip;
   import assets.ui.FriendCrateInfoBoxClip;
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.display.MovieClip;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.monkeyKnowledge.KnowledgeBounty;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.BuildingData;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.MilestoneRewardInfoBox;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge._state;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import org.osflash.signals.PrioritySignal;
   
   public class PremiumBuildingManager
   {
      
      public static const PREMIUM_BUILDINGS_COOKIE_NAME:String = "monkey_city_premium_buildings";
      
      public static const premiumBuildingPurchasedSignal:PrioritySignal = new PrioritySignal(int,int,String);
      
      protected static var _instance:PremiumBuildingManager;
       
      
      protected var _user:NKGatewayUser = null;
      
      protected const _buildingData:BuildingData = BuildingData.getInstance();
      
      protected var _buildingsBoughtINumbers:Object;
      
      protected var _premiumBuildingsInCookie:Object;
      
      protected var _lastKnownBuildingsToSave:Object;
      
      protected var _cookie:Object = null;
      
      public function PremiumBuildingManager()
      {
         this._buildingsBoughtINumbers = {};
         this._premiumBuildingsInCookie = {};
         this._lastKnownBuildingsToSave = {};
         super();
      }
      
      public static function getInstance() : PremiumBuildingManager
      {
         if(Kong.isOnKong())
         {
            return PremiumBuildingManagerKong.getInstance();
         }
         if(_instance == null)
         {
            _instance = new PremiumBuildingManager();
         }
         return _instance;
      }
      
      public function initForUser(param1:NKGatewayUser) : void
      {
         this.reset();
         this._user = param1;
         this._user.gotItemsSignal.add(this.onGotItems);
         this.populatePremiumBuildingList();
         this.loadCookieInfo();
      }
      
      protected function loadCookieInfo() : void
      {
         this._cookie = Kloud.loadCookie(PREMIUM_BUILDINGS_COOKIE_NAME).data;
         if(false == this._cookie.hasOwnProperty(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id))
         {
            this._cookie[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id] = {};
         }
         else
         {
            this._premiumBuildingsInCookie = this._cookie[MonkeySystem.getInstance().nkGatewayUser.loginInfo.id];
            this._lastKnownBuildingsToSave = this._premiumBuildingsInCookie;
         }
      }
      
      public function reset() : void
      {
         if(this._user !== null)
         {
            this._user.gotItemsSignal.remove(this.onGotItems);
            this._user = null;
         }
      }
      
      protected function populatePremiumBuildingList() : void
      {
         this._buildingsBoughtINumbers = {};
         var _loc1_:int = 0;
         while(_loc1_ < this._buildingData.premiumBuildingDefinitions.length)
         {
            this._buildingsBoughtINumbers[this._buildingData.premiumBuildingDefinitions[_loc1_].id] = DancingShadows.getOne();
            _loc1_++;
         }
      }
      
      public function processInventory(param1:NKGatewayUser) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc2_:Object = param1.inventory.coinsItems;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = this._buildingsBoughtINumbers[_loc3_.instanceLabel];
            if(_loc4_ != null)
            {
               this._buildingsBoughtINumbers[_loc3_.instanceLabel].value++;
            }
         }
      }
      
      public function buyPremiumBuilding(param1:int, param2:String) : void
      {
         var _loc3_:INumber = DancingShadows.getOne();
         var _loc4_:int = 0;
         while(_loc4_ < this._buildingData.premiumBuildingDefinitions.length)
         {
            if(this._buildingData.premiumBuildingDefinitions[_loc4_].id == param2)
            {
               _loc3_.value = this._buildingData.premiumBuildingDefinitions[_loc4_].nkCoinCost;
               if(_loc3_.value <= MonkeySystem.getInstance().nkGatewayUser.coins)
               {
                  this._user.buyNKCoinsItem(param1,param2).then(this.onGotItems,this.onBuyPremiumBuildingFailed);
               }
               else
               {
                  PanelManager.getInstance().showFreePanel(TownUI.getInstance().purchaseNKCoinsPanel);
               }
               DancingShadows.returnOne(_loc3_);
               return;
            }
            _loc4_++;
         }
      }
      
      protected function onGotItems(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         t.obj(param1);
         if(param1.success)
         {
            _loc2_ = param1.items;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_];
               _loc5_ = this._buildingsBoughtINumbers[_loc4_.instanceLabel];
               if(_loc5_ != null)
               {
                  _loc6_.value = _loc7_;
                  premiumBuildingPurchasedSignal.dispatch(_loc4_.id,1,_loc4_.instanceLabel);
               }
               _loc3_++;
            }
         }
      }
      
      protected function onBuyPremiumBuildingFailed(param1:Object) : void
      {
         var _loc2_:String = param1["error"];
         var _loc3_:String = param1["message"];
      }
      
      public function addLastKnownPremiumBuilding(param1:String) : void
      {
         var _loc2_:Object = this._lastKnownBuildingsToSave[param1];
         if(null == _loc2_)
         {
            this._lastKnownBuildingsToSave[param1] = 0;
         }
      }
      
      public function saveLastKnownPremiumBuildings() : void
      {
         this._premiumBuildingsInCookie = this._lastKnownBuildingsToSave;
         var _loc1_:Vector.<String> = new Vector.<String>();
         var _loc2_:Vector.<Object> = new Vector.<Object>();
         _loc1_.push(MonkeySystem.getInstance().nkGatewayUser.loginInfo.id);
         _loc2_.push(this._premiumBuildingsInCookie);
         Kloud.saveCookieFromObjects(PREMIUM_BUILDINGS_COOKIE_NAME,_loc1_,_loc2_);
      }
      
      public function get buildingsBoughtINumbers() : Object
      {
         return this._buildingsBoughtINumbers;
      }
      
      public function get premiumBuildingsFromLastSession() : Object
      {
         return this._premiumBuildingsInCookie;
      }
   }
}
