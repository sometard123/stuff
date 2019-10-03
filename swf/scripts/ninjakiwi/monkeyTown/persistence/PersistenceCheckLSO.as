package ninjakiwi.monkeyTown.persistence
{
   import flash.net.SharedObject;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.city.City;
   import ninjakiwi.net.WebAction;
   
   public class PersistenceCheckLSO
   {
      
      public static var instance:PersistenceCheckLSO;
       
      
      private var _system:MonkeySystem;
      
      private var _resourceStore:ResourceStore;
      
      private var _previousXP:int = 0;
      
      private var _previousXPDebt:int = 0;
      
      private var _previousHonor:int = 0;
      
      private var so:SharedObject;
      
      private var dataObject:Object;
      
      public function PersistenceCheckLSO()
      {
         this._system = MonkeySystem.getInstance();
         this._resourceStore = ResourceStore.getInstance();
         super();
         instance = this;
      }
      
      public function init() : void
      {
         this.load();
         City.cityInfoChanged.add(this.save);
         ResourceStore.setXPNoAwardSignal.add(this.test);
      }
      
      public function get userID() : String
      {
         return this._system.nkGatewayUser.loginInfo.id.toString();
      }
      
      public function get xp() : int
      {
         if(this.dataObject.hasOwnProperty("xp"))
         {
            return this.dataObject.xp;
         }
         return 0;
      }
      
      public function get xpDebt() : int
      {
         if(this.dataObject.hasOwnProperty("xpDebt"))
         {
            return this.dataObject.xpDebt;
         }
         return 0;
      }
      
      public function get honour() : int
      {
         if(this.dataObject.hasOwnProperty("honour"))
         {
            return this.dataObject.honour;
         }
         return 0;
      }
      
      private function test() : void
      {
         if(this._resourceStore.xp < this._previousXP)
         {
            AnalyticsUtil.track("xp_went_down",this._resourceStore.xp.toString(),this._previousXP,WebAction.sid.toString(),WebAction.tid.toString());
         }
         if(this._resourceStore.xpDebt < 0)
         {
            AnalyticsUtil.track("negative_xpdebt",this._resourceStore.xpDebt.toString(),WebAction.sid,WebAction.tid.toString());
         }
         if(this._resourceStore.honour < 0)
         {
            AnalyticsUtil.track("negative_honour",this._resourceStore.honour.toString(),WebAction.sid,WebAction.tid.toString());
         }
      }
      
      private function load() : void
      {
         this.so = SharedObject.getLocal("monkey_city_check");
         if(!this.so.data.hasOwnProperty(this.userID))
         {
            this.so.data[this.userID] = {};
         }
         this.dataObject = this.so.data[this.userID];
         this._previousXP = this.xp;
         this._previousXPDebt = this.xpDebt;
         this._previousHonor = this.honour;
      }
      
      private function save(... rest) : void
      {
         this.test();
         this.dataObject.xp = this._resourceStore.xp;
         this.dataObject.xpDebt = this._resourceStore.xpDebt;
         this.dataObject.honour = this._resourceStore.honour;
         this.so.flush();
         this._previousXP = this._resourceStore.xp;
         this._previousXPDebt = this._resourceStore.xpDebt;
         this._previousHonor = this._resourceStore.honour;
      }
   }
}
