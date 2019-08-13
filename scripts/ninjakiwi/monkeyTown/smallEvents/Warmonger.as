package ninjakiwi.monkeyTown.smallEvents
{
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventSubManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuData;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class Warmonger extends GameEventSubManager
   {
       
      
      private var _pillageScale:INumber;
      
      private var _freeBonusRegen:INumber;
      
      private var _freeBonusCamo:INumber;
      
      private var _freeBonusLead:INumber;
      
      private var _freeBonusMoab:INumber;
      
      public function Warmonger()
      {
         this._pillageScale = DancingShadows.getOne();
         this._freeBonusRegen = DancingShadows.getOne();
         this._freeBonusCamo = DancingShadows.getOne();
         this._freeBonusLead = DancingShadows.getOne();
         this._freeBonusMoab = DancingShadows.getOne();
         super();
         GameEventManager.gameEventManagerReadySignal.add(this.onGameEventManagerReady);
      }
      
      override public function get typeID() : String
      {
         return "warmonger";
      }
      
      public function getPillageScale() : Number
      {
         return this._pillageScale.value;
      }
      
      public function get freeBonusRegen() : Boolean
      {
         return this._freeBonusRegen.value != 0;
      }
      
      public function get freeBonusCamo() : Boolean
      {
         return this._freeBonusCamo.value != 0;
      }
      
      public function get freeBonusLead() : Boolean
      {
         return this._freeBonusLead.value != 0;
      }
      
      public function get freeBonusMoab() : Boolean
      {
         return this._freeBonusMoab.value != 0;
      }
      
      public function getBonusPillageAmount(param1:Number) : Number
      {
         var _loc2_:Number = param1 * this._pillageScale.value - param1;
         return _loc2_;
      }
      
      public function reset(... rest) : void
      {
         this._pillageScale.value = 1;
         this._freeBonusRegen.value = 0;
         this._freeBonusCamo.value = 0;
         this._freeBonusLead.value = 0;
         this._freeBonusMoab.value = 0;
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
         SkuSettingsLoader.getGameEventDataByID("warmonger",_loc2_.dataID,this.setGameEventData);
      }
      
      private function setGameEventData(param1:Object) : void
      {
         this.reset();
         if(null == param1)
         {
            return;
         }
         if(param1.hasOwnProperty("modifier"))
         {
            this._pillageScale.value = param1.modifier;
         }
         if(param1.hasOwnProperty("freeExtraRegen"))
         {
            this._freeBonusRegen.value = param1.freeExtraRegen;
         }
         if(param1.hasOwnProperty("freeExtraCamo"))
         {
            this._freeBonusCamo.value = param1.freeExtraCamo;
         }
         if(param1.hasOwnProperty("freeExtraLead"))
         {
            this._freeBonusLead.value = param1.freeExtraLead;
         }
         if(param1.hasOwnProperty("freeExtraMoab"))
         {
            this._freeBonusMoab.value = param1.freeExtraMoab;
         }
         callWhenCurrentEventEnds(this.reset);
      }
      
      public function isFreeForResearch(param1:String) : Boolean
      {
         switch(param1)
         {
            case BloonResearchLabUpgrades.RUBBER_REPAIR.id:
               return this.freeBonusRegen;
            case BloonResearchLabUpgrades.CAMO_MOD_TECH.id:
               return this.freeBonusCamo;
            case BloonResearchLabUpgrades.HEAVY_BLOON_ARMOUR.id:
               return this.freeBonusLead;
            case BloonResearchLabUpgrades.MOABS.id:
               return this.freeBonusMoab;
            default:
               return false;
         }
      }
   }
}
