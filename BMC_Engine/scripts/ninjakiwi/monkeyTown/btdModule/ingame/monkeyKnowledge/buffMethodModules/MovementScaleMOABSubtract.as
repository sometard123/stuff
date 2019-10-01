package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.BigBloonSabotage;
   
   public class MovementScaleMOABSubtract implements IBuffMethodModule
   {
       
      
      public function MovementScaleMOABSubtract()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         if(BigBloonSabotage.instance.moabSpeedPercent > param1.buffValue)
         {
            BigBloonSabotage.instance.moabSpeedPercent = BigBloonSabotage.instance.moabSpeedPercent - param1.buffValue;
         }
      }
   }
}
