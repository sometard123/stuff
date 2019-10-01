package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.BehaviorCollision;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.BehaviorDestroy;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.BehaviorProcess;
   
   public class ProjectileBehaviorModDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var addDestroy_:BehaviorDestroy = null;
      
      private var addCollision_:BehaviorCollision = null;
      
      private var setProcess_:BehaviorProcess = null;
      
      public function ProjectileBehaviorModDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("addDestroy");
         }
         return displayOrder;
      }
      
      public function set addDestroy(param1:BehaviorDestroy) : void
      {
         if(this.addDestroy_ != param1)
         {
            this.addDestroy_ = param1;
            dispatchEvent(new PropertyModEvent("addDestroy"));
         }
      }
      
      public function get addDestroy() : BehaviorDestroy
      {
         return this.addDestroy_;
      }
      
      public function AddDestroy(param1:BehaviorDestroy) : ProjectileBehaviorModDef
      {
         this.addDestroy = param1;
         return this;
      }
      
      public function set addCollision(param1:BehaviorCollision) : void
      {
         if(this.addCollision_ != param1)
         {
            this.addCollision_ = param1;
            dispatchEvent(new PropertyModEvent("addCollision"));
         }
      }
      
      public function get addCollision() : BehaviorCollision
      {
         return this.addCollision_;
      }
      
      public function AddCollision(param1:BehaviorCollision) : ProjectileBehaviorModDef
      {
         this.addCollision = param1;
         return this;
      }
      
      public function set setProcess(param1:BehaviorProcess) : void
      {
         if(this.setProcess_ != param1)
         {
            this.setProcess_ = param1;
            dispatchEvent(new PropertyModEvent("setProcess"));
         }
      }
      
      public function get setProcess() : BehaviorProcess
      {
         return this.setProcess_;
      }
      
      public function SetProcess(param1:BehaviorProcess) : ProjectileBehaviorModDef
      {
         this.setProcess = param1;
         return this;
      }
   }
}
