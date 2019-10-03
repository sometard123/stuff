package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   
   public class BehaviorDestroy extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var next_:BehaviorDestroy;
      
      public function BehaviorDestroy()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("next");
         }
         return displayOrder;
      }
      
      public function set next(param1:BehaviorDestroy) : void
      {
         if(this.next_ != param1)
         {
            this.next_ = param1;
            dispatchEvent(new PropertyModEvent("next"));
         }
      }
      
      public function get next() : BehaviorDestroy
      {
         return this.next_;
      }
      
      public function Next(param1:BehaviorDestroy) : BehaviorDestroy
      {
         this.next = param1;
         return this;
      }
      
      public function execute(param1:Projectile) : void
      {
      }
   }
}
