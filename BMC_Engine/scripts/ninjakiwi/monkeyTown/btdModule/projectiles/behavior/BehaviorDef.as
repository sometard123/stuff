package ninjakiwi.monkeyTown.btdModule.projectiles.behavior
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.BehaviorCollision;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.BehaviorDestroy;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.lifespanOver.BehaviorLifeSpanOver;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.BehaviorProcess;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.roundOver.BehaviorRoundOver;
   
   public class BehaviorDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var process_:BehaviorProcess = null;
      
      private var roundOver_:BehaviorRoundOver = null;
      
      private var destroy_:BehaviorDestroy = null;
      
      private var collision_:BehaviorCollision = null;
      
      private var lifespanOver_:BehaviorLifeSpanOver = null;
      
      public function BehaviorDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("process","roundOver","destroy","collision");
         }
         return displayOrder;
      }
      
      public function set process(param1:BehaviorProcess) : void
      {
         if(this.process_ != param1)
         {
            this.process_ = param1;
            dispatchEvent(new PropertyModEvent("process"));
         }
      }
      
      public function get process() : BehaviorProcess
      {
         return this.process_;
      }
      
      public function Process(param1:BehaviorProcess) : BehaviorDef
      {
         this.process = param1;
         return this;
      }
      
      public function set roundOver(param1:BehaviorRoundOver) : void
      {
         if(this.roundOver_ != param1)
         {
            this.roundOver_ = param1;
            dispatchEvent(new PropertyModEvent("roundOver"));
         }
      }
      
      public function get roundOver() : BehaviorRoundOver
      {
         return this.roundOver_;
      }
      
      public function RoundOver(param1:BehaviorRoundOver) : BehaviorDef
      {
         this.roundOver = param1;
         return this;
      }
      
      public function set destroy(param1:BehaviorDestroy) : void
      {
         if(this.destroy_ != param1)
         {
            this.destroy_ = param1;
            dispatchEvent(new PropertyModEvent("destroy"));
         }
      }
      
      public function get destroy() : BehaviorDestroy
      {
         return this.destroy_;
      }
      
      public function Destroy(param1:BehaviorDestroy) : BehaviorDef
      {
         this.destroy = param1;
         return this;
      }
      
      public function set collision(param1:BehaviorCollision) : void
      {
         if(this.collision_ != param1)
         {
            this.collision_ = param1;
            dispatchEvent(new PropertyModEvent("collision"));
         }
      }
      
      public function get collision() : BehaviorCollision
      {
         return this.collision_;
      }
      
      public function Collision(param1:BehaviorCollision) : BehaviorDef
      {
         this.collision = param1;
         return this;
      }
      
      public function get lifespanOver() : BehaviorLifeSpanOver
      {
         return this.lifespanOver_;
      }
      
      public function set lifespanOver(param1:BehaviorLifeSpanOver) : void
      {
         this.lifespanOver_ = param1;
      }
      
      public function LifespanOver(param1:BehaviorLifeSpanOver) : BehaviorDef
      {
         this.lifespanOver_ = param1;
         return this;
      }
   }
}
