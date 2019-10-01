package ninjakiwi.monkeyTown.net.kloud
{
   import org.osflash.signals.Signal;
   
   public class HandShake
   {
      
      public static var sessionInitialisedSignal:Signal = new Signal();
       
      
      private var _sID = -1;
      
      private var _sessionID = -1;
      
      private var _nkApiID = -1;
      
      private var _transactionID:int = -1;
      
      private var _token:String = null;
      
      private var _hasBeenInitialised:Boolean = false;
      
      public function HandShake(param1:String)
      {
         super();
         this._token = param1;
      }
      
      public function initialiseSession(param1:*, param2:*, param3:*) : void
      {
         if(this._hasBeenInitialised)
         {
            return;
         }
         this._sID = param1;
         this._sessionID = param2;
         this._nkApiID = param3;
         this._transactionID = 0;
         this._hasBeenInitialised = true;
         this.testInit("initialise( )");
         sessionInitialisedSignal.dispatch();
      }
      
      public function invalidateSession() : void
      {
         this._sID = -1;
         this._sessionID = -1;
         this._nkApiID = -1;
         this._transactionID = -1;
         this._hasBeenInitialised = false;
      }
      
      public function get hasSession() : Boolean
      {
         return this._hasBeenInitialised;
      }
      
      public function get sessionID() : *
      {
         this.testInit("get sessionID( )");
         return this._sessionID;
      }
      
      public function get currentTransactionID() : int
      {
         return this._transactionID;
      }
      
      public function get nextTransactionID() : int
      {
         this.testInit("get nextTransactionID( )");
         return ++this._transactionID;
      }
      
      public function get token() : String
      {
         this.testInit("get token( )");
         return this._token;
      }
      
      public function get nkApiID() : *
      {
         return this._nkApiID;
      }
      
      public function get sID() : *
      {
         return this._sID;
      }
      
      private function testInit(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(this._token == null)
         {
            _loc2_ = "HandShake::" + param1;
            if(this._hasBeenInitialised)
            {
               _loc3_ = " - token is null!!!";
            }
            else
            {
               _loc3_ = " - not yet initialised!!!";
            }
            throw new Error(_loc2_ + _loc3_);
         }
      }
   }
}
