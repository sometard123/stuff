package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   
   public class BehaviorCollision extends EventDispatcher
   {
       
      
      private var next_:BehaviorCollision;
      
      public function BehaviorCollision()
      {
         super();
      }
      
      public function execute(param1:Projectile) : void
      {
      }
      
      public function set next(param1:BehaviorCollision) : void
      {
         if(this.next_ != param1)
         {
            this.next_ = param1;
            dispatchEvent(new PropertyModEvent("next"));
         }
      }
      
      public function get next() : BehaviorCollision
      {
         return this.next_;
      }
      
      public function Next(param1:BehaviorCollision) : BehaviorCollision
      {
         this.next = param1;
         return this;
      }
   }
}
