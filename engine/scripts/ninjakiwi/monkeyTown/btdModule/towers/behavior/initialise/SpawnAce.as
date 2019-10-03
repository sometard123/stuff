package ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class SpawnAce extends BehaviorInitialise
   {
       
      
      private var display_:Class = null;
      
      public function SpawnAce()
      {
         super();
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
      
      public function Display(param1:Class) : SpawnAce
      {
         this.display = param1;
         return this;
      }
      
      override public function execute(param1:Tower) : void
      {
         param1.def.behavior.roundStart.execute(param1);
      }
   }
}
