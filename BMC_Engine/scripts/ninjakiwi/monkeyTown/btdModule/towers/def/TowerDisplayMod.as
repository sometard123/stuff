package ninjakiwi.monkeyTown.btdModule.towers.def
{
   import assets.base.Tower;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class TowerDisplayMod extends EventDispatcher
   {
      
      public static var useFor_baseof:Class = Tower;
      
      public static var display_baseof:Class = Tower;
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var useFor_:Class = null;
      
      private var display_:Class = null;
      
      private var weaponOffsets_:Vector.<Vector2> = null;
      
      public function TowerDisplayMod()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("useFor","display");
         }
         return displayOrder;
      }
      
      public function set useFor(param1:Class) : void
      {
         if(this.useFor_ != param1)
         {
            this.useFor_ = param1;
            dispatchEvent(new PropertyModEvent("useFor"));
         }
      }
      
      public function get useFor() : Class
      {
         return this.useFor_;
      }
      
      public function UseFor(param1:Class) : TowerDisplayMod
      {
         this.useFor = param1;
         return this;
      }
      
      public function set display(param1:Class) : void
      {
         if(this.display_ != param1)
         {
            this.display_ = param1;
            dispatchEvent(new PropertyModEvent("display"));
         }
      }
      
      public function get display() : Class
      {
         return this.display_;
      }
      
      public function Display(param1:Class) : TowerDisplayMod
      {
         this.display = param1;
         return this;
      }
      
      public function set weaponOffsets(param1:Vector.<Vector2>) : void
      {
         if(this.weaponOffsets_ != param1)
         {
            this.weaponOffsets_ = param1;
            dispatchEvent(new PropertyModEvent("weaponOffsets"));
         }
      }
      
      public function get weaponOffsets() : Vector.<Vector2>
      {
         return this.weaponOffsets_;
      }
      
      public function WeaponOffsets(param1:Vector.<Vector2>) : TowerDisplayMod
      {
         this.weaponOffsets = param1;
         return this;
      }
   }
}
