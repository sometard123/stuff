package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import assets.base.Projectile;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   
   public class ProjectileDisplayMod extends EventDispatcher
   {
      
      public static var useFor_baseof:Class = Projectile;
      
      public static var display_baseof:Class = Projectile;
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var useFor_:Class = null;
      
      private var display_:Class = null;
      
      private var additiveBlend_:Boolean = false;
      
      public function ProjectileDisplayMod()
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
      
      public function UseFor(param1:Class) : ProjectileDisplayMod
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
      
      public function Display(param1:Class) : ProjectileDisplayMod
      {
         this.display = param1;
         return this;
      }
      
      public function set additiveBlend(param1:Boolean) : void
      {
         if(this.additiveBlend_ != param1)
         {
            this.additiveBlend_ = param1;
            dispatchEvent(new PropertyModEvent("additiveBlend"));
         }
      }
      
      public function get additiveBlend() : Boolean
      {
         return this.additiveBlend_;
      }
      
      public function AdditiveBlend(param1:Boolean) : ProjectileDisplayMod
      {
         this.additiveBlend_ = param1;
         return this;
      }
   }
}
