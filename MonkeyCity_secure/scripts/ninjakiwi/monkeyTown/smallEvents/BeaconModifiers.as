package ninjakiwi.monkeyTown.smallEvents
{
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   
   public class BeaconModifiers extends GameEventSubManager
   {
      
      public static const TYPE_ID:String = "beaconModifiers";
       
      
      private var _rechargeCostModifier:INumber;
      
      private var _rechargeTimeModifier:INumber;
      
      private var _activeEventID:String = "";
      
      public function BeaconModifiers()
      {
         this._rechargeCostModifier = DancingShadows.getOne();
         this._rechargeTimeModifier = DancingShadows.getOne();
         super();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReady);
      }
      
      public function onGameEventManagerReady(... rest) : void
      {
         this.reset();
         var _loc2_:GameplayEvent = findCurrentEvent();
         if(null == _loc2_)
         {
            callWhenNextEventBecomesActive(this.onGameEventManagerReady);
            return;
         }
         this._activeEventID = _loc2_.uid;
         SkuSettingsLoader.getGameEventDataByID(TYPE_ID,_loc2_.dataID,this.setGameEventData);
      }
      
      private function setGameEventData(param1:Object) : void
      {
         if(null == param1)
         {
            return;
         }
         if(param1.hasOwnProperty("priceModifier"))
         {
            this._rechargeCostModifier.value = param1.priceModifier;
         }
         if(param1.hasOwnProperty("timeModifier"))
         {
            this._rechargeTimeModifier.value = param1.timeModifier;
         }
      }
      
      private function reset(... rest) : void
      {
         this._rechargeCostModifier.value = 1;
         this._rechargeTimeModifier.value = 1;
      }
      
      override public function get typeID() : String
      {
         return TYPE_ID;
      }
      
      public function get rechargeCostModifier() : Number
      {
         return this._rechargeCostModifier.value;
      }
      
      public function get rechargeTimeModifier() : Number
      {
         return this._rechargeTimeModifier.value;
      }
   }
}
