package ninjakiwi.monkeyTown.btdModule.abilities
{
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class Sabotage extends Ability
   {
      
      private static var timersRunning:int = 0;
       
      
      private var level:Level = null;
      
      public function Sabotage()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         this.level = param1.level;
         if(false == this.level.sabotageBloons)
         {
            timersRunning = 0;
         }
         this.level.sabotageBloons = true;
         var _loc3_:Vector.<Bloon> = this.level.getBloonsInLastSeconds(10);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(false === _loc3_[_loc4_].isBoss)
            {
               _loc3_[_loc4_].sabotaged = true;
            }
            _loc4_++;
         }
         var _loc5_:GameSpeedTimer = new GameSpeedTimer(15);
         _loc5_.addEventListener(GameSpeedTimer.COMPLETE,this.endSabotage);
         timersRunning++;
      }
      
      private function endSabotage(param1:Event) : void
      {
         GameSpeedTimer(param1.target).removeEventListener(GameSpeedTimer.COMPLETE,this.endSabotage);
         timersRunning--;
         if(timersRunning == 0)
         {
            if(this.level != null)
            {
               this.level.sabotageBloons = false;
            }
         }
      }
   }
}
