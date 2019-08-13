package ninjakiwi.monkeyTown.premiums
{
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.definitions.FirstTimeTriggerDefinition;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.GenericEventPopupPanel;
   import ninjakiwi.monkeyTown.town.ui.InfoBoxBase;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.BloonBeaconEventMenuItem;
   import ninjakiwi.monkeyTown.town.ui.pvp.PVPOpponentInfoBox;
   
   final class BloonstonesRequest
   {
      
      private static const TIME_OUT_TIME:int = 5000;
      
      private static const _system:MonkeySystem = MonkeySystem.getInstance();
       
      
      public var deposit:int = 0;
      
      public var expectedBalance:int = 0;
      
      private var _callback:Function = null;
      
      private var _timedOut:Boolean = false;
      
      private var _timeOutID:int = 0;
      
      function BloonstonesRequest(param1:int, param2:int)
      {
         super();
         this.deposit = param1;
         this.expectedBalance = param2;
      }
      
      public function go(param1:Function) : void
      {
         this._callback = param1;
         if(this.deposit > 0)
         {
            this.depositBloonstones();
         }
         else if(this.deposit < 0)
         {
            this.spendBloonstones();
         }
         this._timeOutID = setTimeout(this.onTimeOut,TIME_OUT_TIME);
      }
      
      public function depositBloonstones() : void
      {
         if(_system.nkGatewayUser === null)
         {
            Main.instance.unLockReturnToHomeScreen();
            Main.instance.returnToHomeScreen();
            return;
         }
         _system.nkGatewayUser.awardIgc(this.deposit,"301","woot").then(function ok(param1:int):void
         {
            if(param1 !== expectedBalance)
            {
            }
         },function notOK(param1:Object):void
         {
         });
      }
      
      public function spendBloonstones() : void
      {
         var spent:int = 0;
         spent = -this.deposit;
         ResourceStore.getInstance().bloonstonesDirect = ResourceStore.getInstance().bloonstonesDirect - spent;
         _system.nkGatewayUser.buyIgcItem("1",spent,"item").then(_system.nkGatewayUser.consumeIgcItem,function notOK(param1:Object):void
         {
            clearTimeout(_timeOutID);
            _timeOutID = 0;
            executeCallback({"success":false});
         }).then(function consumed():void
         {
            clearTimeout(_timeOutID);
            _timeOutID = 0;
            executeCallback({
               "success":true,
               "spent":spent
            });
         },function failed(param1:Object):void
         {
            clearTimeout(_timeOutID);
            _timeOutID = 0;
            executeCallback({"success":false});
         });
      }
      
      private function responseHandler(param1:Object) : void
      {
         if(this._timedOut)
         {
            return;
         }
         if(param1.balance !== this.expectedBalance)
         {
         }
      }
      
      private function onTimeOut() : void
      {
         this._timedOut = true;
         this._timeOutID = 0;
         this.executeCallback({"success":false});
      }
      
      private function executeCallback(param1:Object) : void
      {
         this._callback(param1);
      }
   }
}
