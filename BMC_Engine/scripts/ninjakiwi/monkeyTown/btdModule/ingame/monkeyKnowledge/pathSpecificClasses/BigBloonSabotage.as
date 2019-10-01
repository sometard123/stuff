package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.BuffManager;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.HealthScaleMOABSubtract;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.MovementScaleMOABSubtract;
   
   public class BigBloonSabotage
   {
      
      public static const instance:BigBloonSabotage = new BigBloonSabotage();
      
      private static const BIG_BLOON_SABOTAGE_ID:String = "BigBloonSabotage";
       
      
      public var moabHealthPercent:Number = 1;
      
      public var moabSpeedPercent:Number = 1;
      
      public function BigBloonSabotage()
      {
         super();
      }
      
      public function reset() : void
      {
         this.moabHealthPercent = 1;
         this.moabSpeedPercent = 1;
      }
      
      public function activateBuffs() : void
      {
         this.reset();
         BuffManager.instance.activateBuffsOfMethodInPath(MovementScaleMOABSubtract,BIG_BLOON_SABOTAGE_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(HealthScaleMOABSubtract,BIG_BLOON_SABOTAGE_ID);
      }
      
      public function applyMOABHealthBuffs() : void
      {
         Bloon.furtherScaleMOABHealth(this.moabHealthPercent);
      }
   }
}
