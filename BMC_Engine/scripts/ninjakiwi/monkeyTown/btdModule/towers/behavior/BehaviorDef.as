package ninjakiwi.monkeyTown.btdModule.towers.behavior
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.destroy.BehaviorDestroy;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.BehaviorInitialise;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.BehaviorProcess;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.BehaviorRoundOver;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BehaviorRoundStart;
   
   public class BehaviorDef extends EventDispatcher
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var process_:BehaviorProcess = null;
      
      private var initialise_:BehaviorInitialise = null;
      
      private var roundStart_:BehaviorRoundStart = null;
      
      private var roundOver_:BehaviorRoundOver = null;
      
      private var destroy_:BehaviorDestroy = null;
      
      public function BehaviorDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("process","initialise","roundStart","roundOver","destroy");
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
      
      public function set initialise(param1:BehaviorInitialise) : void
      {
         if(this.initialise_ != param1)
         {
            this.initialise_ = param1;
            dispatchEvent(new PropertyModEvent("initialise"));
         }
      }
      
      public function get initialise() : BehaviorInitialise
      {
         return this.initialise_;
      }
      
      public function Initialise(param1:BehaviorInitialise) : BehaviorDef
      {
         this.initialise = param1;
         return this;
      }
      
      public function set roundStart(param1:BehaviorRoundStart) : void
      {
         if(this.roundStart_ != param1)
         {
            this.roundStart_ = param1;
            dispatchEvent(new PropertyModEvent("roundStart"));
         }
      }
      
      public function get roundStart() : BehaviorRoundStart
      {
         return this.roundStart_;
      }
      
      public function RoundStart(param1:BehaviorRoundStart) : BehaviorDef
      {
         this.roundStart = param1;
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
   }
}
