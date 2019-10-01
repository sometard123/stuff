package ninjakiwi.monkeyTown.cheat
{
   import com.lgrey.game.cheat.CheatCodeListener;
   import flash.display.Stage;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.salePanels.SaleItemData;
   import ninjakiwi.monkeyTown.town.ui.salePanels.SaleItemInfoBox;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   import ninjakiwi.net.JSONRequest;
   
   public class Cheats
   {
      
      public static var cheatStartingCashBonus:int = 0;
       
      
      private var _cheatCodeListener:CheatCodeListener;
      
      private var cheatsAreUnlocked:Boolean = false;
      
      private var _stage:Stage;
      
      private var _monkeyCityMain:MonkeyCityMain;
      
      public function Cheats(param1:Stage)
      {
         super();
         this._stage = param1;
         this._monkeyCityMain = MonkeyCityMain.getInstance();
         this.initMasterCheat();
      }
      
      private function initMasterCheat() : void
      {
         var that:* = this;
         this._cheatCodeListener = new CheatCodeListener(this._stage);
         this._cheatCodeListener.registerCheatCode("custodialarts",function():void
         {
            Constants.BYPASS_MAINTENANCE_MODE = true;
         });
         this._cheatCodeListener.registerCheatCode("nkwinwin",function():void
         {
            enableRequestLogging();
         });
      }
      
      public function enableRequestLogging() : void
      {
         JSONRequest.logRequests = !JSONRequest.logRequests;
         ErrorReporter.externalLog("Request logging is " + (!!JSONRequest.logRequests?"ON":"OFF"));
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
      }
      
      private function initCheatListeners() : void
      {
         var _loc1_:* = this;
      }
      
      public function saveTextFile(param1:String, param2:String) : void
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param1);
         var _loc4_:FileReference = new FileReference();
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.saveDataToFileIOErrorHandler);
         _loc4_.save(_loc3_,param2);
      }
      
      private function saveDataToFileIOErrorHandler(param1:IOErrorEvent) : void
      {
      }
   }
}
