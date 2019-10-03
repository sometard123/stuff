package ninjakiwi.monkeyTown.btdModule.towers.def
{
   import assets.base.Tower;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class AltDisplayAddonDef extends EventDispatcher
   {
      
      public static var useFor_baseof:Class = Tower;
      
      public static var display_baseof:Class = Tower;
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var useFor_:Class = null;
      
      private var display_:Class = null;
      
      public function AltDisplayAddonDef()
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
      
      public function UseFor(param1:Class) : AltDisplayAddonDef
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
      
      public function Display(param1:Class) : AltDisplayAddonDef
      {
         this.display = param1;
         return this;
      }
   }
}
