package ninjakiwi.monkeyTown.btdModule.towers.behavior.destroy
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.Sacrifice;
   
   public class UnSacrifice extends BehaviorDestroy
   {
       
      
      public function UnSacrifice()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         if(Sacrifice.sacrificeSpentOn[param1])
         {
            delete Sacrifice.sacrificeSpentOn[param1];
         }
         if(Sacrifice.dont.indexOf(param1) != -1)
         {
            Sacrifice.dont.splice(Sacrifice.dont.indexOf(param1),1);
         }
      }
   }
}
