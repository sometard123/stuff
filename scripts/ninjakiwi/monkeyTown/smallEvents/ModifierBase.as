package ninjakiwi.monkeyTown.smallEvents
{
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   
   public class ModifierBase extends GameEventSubManager
   {
       
      
      protected var _modifier:INumber;
      
      public function ModifierBase()
      {
         this._modifier = DancingShadows.getOne();
         super();
         GameEventManager.gameEventManagerReadySignal.addOnce(this.onManagerReady);
      }
      
      override public function get typeID() : String
      {
         return "not_defined";
      }
      
      private function onManagerReady() : void
      {
         this.syncModifier();
      }
      
      private function syncModifier(... rest) : void
      {
         var arguments:Array = rest;
         var currentEvent:GameplayEvent = findCurrentEvent();
         if(currentEvent === null)
         {
            this._modifier.value = 1;
            callWhenNextEventBecomesActive(this.syncModifier);
         }
         else
         {
            SkuSettingsLoader.getGameEventDataByID(this.typeID,currentEvent.dataID,function(param1:Object):void
            {
               _modifier.value = param1.modifier;
            });
            callWhenCurrentEventEnds(this.syncModifier);
         }
      }
      
      public function get modifier() : Number
      {
         return this._modifier.value;
      }
   }
}
