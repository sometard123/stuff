package ninjakiwi.mynk.save
{
   import assets.btdmodule.ui.RedHotSpikesTutorialPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.SharedObject;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BuffMethodModuleSharedFunctions;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.mynk.net.LoginSystem;
   import ninjakiwi.mynk.sharedDefinitions.Msg;
   import ninjakiwi.state.State;
   
   public class SaveBoss extends EventDispatcher
   {
       
      
      private var _login:LoginSystem;
      
      private var _data:UserData;
      
      private var _cookie:SharedObject;
      
      private var _blockSaves:Boolean;
      
      private var _dataWasChanged:Boolean;
      
      public function SaveBoss(param1:LoginSystem)
      {
         super();
         var _loc2_:String = this.removeWhitespace("guest_" + Settings.GAME_NAME);
         this._cookie = SharedObject.getLocal(_loc2_,"/");
         this._login = param1;
         this._login.state.LOGGED_IN.addEventListener(State.ENTER,this.enterLoggedInHandler);
         this._login.state.LOGGED_IN.addEventListener(State.EXIT,this.exitLoggedInHandler);
         this._login.state.LOGGED_OUT.addEventListener(State.ENTER,this.enterLoggedOutHandler);
         this._login.state.FAILED.addEventListener(State.ENTER,this.enterFailedHandler);
      }
      
      private function removeWhitespace(param1:String) : String
      {
         var _loc2_:RegExp = /\W/g;
         return param1.replace(_loc2_,"");
      }
      
      public function saveData(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         if(this._blockSaves)
         {
            dispatchEvent(new Event(Msg.SAVE_ERROR,true));
            return;
         }
         this._login.state.receive(Msg.SAVE);
         if(this._login.state.isCurrently(this._login.state.LOGGED_IN))
         {
            _loc2_ = this._data.writeObject();
            this._login.remote.call("save",_loc2_,param1);
         }
         else
         {
            this._cookie.data.ud = this._data.writeObject();
            this._cookie.flush();
            dispatchEvent(new Event(Msg.SAVE_OK,true));
         }
      }
      
      private function enterLoggedInHandler(param1:Event) : void
      {
         this._blockSaves = true;
         this._login.remote.call("setDataHandler",this.gotRemoteData);
      }
      
      private function exitLoggedInHandler(param1:Event) : void
      {
         this._blockSaves = false;
      }
      
      private function enterLoggedOutHandler(param1:Event) : void
      {
         this._data = null;
         this._login.remote.call("setDataHandler",null);
         this.gotLocalData(this._cookie.data.ud);
      }
      
      private function enterFailedHandler(param1:Event) : void
      {
         this._data = null;
         this.gotLocalData(this._cookie.data.ud);
      }
      
      private function gotLocalData(param1:Object) : void
      {
         this._dataWasChanged = false;
         var _loc2_:UserData = new UserData(param1);
         if(this._data == null || !this._data.equals(_loc2_))
         {
            this._data = _loc2_;
            this._dataWasChanged = true;
            dispatchEvent(new Event(Msg.DATA_INVALIDATED));
         }
         dispatchEvent(new Event(Msg.DATA_READY));
      }
      
      private function gotRemoteData(param1:Object) : void
      {
         var _loc3_:UserData = null;
         var _loc4_:UserData = null;
         this._dataWasChanged = false;
         this._blockSaves = false;
         var _loc2_:UserData = new UserData(param1);
         if(!_loc2_.isBlank())
         {
            this._data = _loc2_;
            this._dataWasChanged = true;
            dispatchEvent(new Event(Msg.DATA_INVALIDATED));
         }
         else
         {
            _loc3_ = this._data;
            _loc4_ = new UserData(this._cookie.data.ud);
            this._data = _loc4_;
            if(!_loc4_.isBlank())
            {
               this._cookie.clear();
               this.saveData(true);
            }
            if(_loc3_ == null)
            {
               this._dataWasChanged = true;
               dispatchEvent(new Event(Msg.DATA_INVALIDATED));
            }
         }
         dispatchEvent(new Event(Msg.DATA_READY));
      }
      
      public function get data() : UserData
      {
         return this._data;
      }
      
      public function set data(param1:UserData) : void
      {
         this._data = param1;
      }
      
      public function get dataWasChanged() : Boolean
      {
         return this._dataWasChanged;
      }
   }
}
