package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDisplayMod;
   
   public class BehaviorModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var bananaMod_:BananaModDef = null;
      
      private var bloonchipperStoreMod_:BloonchipperStoreModDef = null;
      
      private var behaviorSet_:BehaviorDef = null;
      
      private var display_:Vector.<TowerDisplayMod> = null;
      
      public function BehaviorModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("bananaMod","behaviorSet");
         }
         return displayOrder;
      }
      
      public function set bananaMod(param1:BananaModDef) : void
      {
         if(this.bananaMod_ != param1)
         {
            this.bananaMod_ = param1;
            dispatchEvent(new PropertyModEvent("bananaMod"));
         }
      }
      
      public function get bananaMod() : BananaModDef
      {
         return this.bananaMod_;
      }
      
      public function BananaMod(param1:BananaModDef) : BehaviorModDef
      {
         this.bananaMod = param1;
         return this;
      }
      
      public function set bloonchipperStoreMod(param1:BloonchipperStoreModDef) : void
      {
         if(this.bloonchipperStoreMod_ != param1)
         {
            this.bloonchipperStoreMod_ = param1;
            dispatchEvent(new PropertyModEvent("bloonchipperStoreMod"));
         }
      }
      
      public function get bloonchipperStoreMod() : BloonchipperStoreModDef
      {
         return this.bloonchipperStoreMod_;
      }
      
      public function BloonchipperStoreMod(param1:BloonchipperStoreModDef) : BehaviorModDef
      {
         this.bloonchipperStoreMod = param1;
         return this;
      }
      
      public function set behaviorSet(param1:BehaviorDef) : void
      {
         if(this.behaviorSet_ != param1)
         {
            this.behaviorSet_ = param1;
            dispatchEvent(new PropertyModEvent("behaviorSet"));
         }
      }
      
      public function get behaviorSet() : BehaviorDef
      {
         return this.behaviorSet_;
      }
      
      public function BehaviorSet(param1:BehaviorDef) : BehaviorModDef
      {
         this.behaviorSet = param1;
         return this;
      }
      
      public function set display(param1:Vector.<TowerDisplayMod>) : void
      {
         if(this.display_ != param1)
         {
            this.display_ = param1;
            dispatchEvent(new PropertyModEvent("display"));
         }
      }
      
      public function get display() : Vector.<TowerDisplayMod>
      {
         return this.display_;
      }
      
      public function Display(param1:Vector.<TowerDisplayMod>) : BehaviorModDef
      {
         this.display = param1;
         return this;
      }
   }
}
