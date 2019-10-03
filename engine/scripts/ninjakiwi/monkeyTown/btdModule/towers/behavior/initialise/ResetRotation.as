package ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class ResetRotation extends BehaviorInitialise
   {
       
      
      public function ResetRotation()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         param1.rotation = 0;
      }
   }
}
