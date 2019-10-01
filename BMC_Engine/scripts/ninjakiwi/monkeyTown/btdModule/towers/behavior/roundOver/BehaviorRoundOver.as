package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.Behavior;
   
   public class BehaviorRoundOver extends Behavior
   {
       
      
      private var isCalledOnReInit_:Boolean = true;
      
      public function BehaviorRoundOver()
      {
         super();
      }
      
      public function execute(param1:Tower) : void
      {
      }
      
      public function get isCalledOnReInit() : Boolean
      {
         return this.isCalledOnReInit_;
      }
      
      public function set isCalledOnReInit(param1:Boolean) : void
      {
         this.isCalledOnReInit_ = param1;
      }
      
      public function IsCalledOnReInit(param1:Boolean) : BehaviorRoundOver
      {
         this.isCalledOnReInit_ = param1;
         return this;
      }
   }
}
