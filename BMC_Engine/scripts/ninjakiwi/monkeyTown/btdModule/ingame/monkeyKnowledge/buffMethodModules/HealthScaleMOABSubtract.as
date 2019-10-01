package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.BigBloonSabotage;
   
   public class HealthScaleMOABSubtract implements IBuffMethodModule
   {
       
      
      public function HealthScaleMOABSubtract()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         if(BigBloonSabotage.instance.moabHealthPercent > param1.buffValue)
         {
            BigBloonSabotage.instance.moabHealthPercent = BigBloonSabotage.instance.moabHealthPercent - param1.buffValue;
         }
      }
   }
}
