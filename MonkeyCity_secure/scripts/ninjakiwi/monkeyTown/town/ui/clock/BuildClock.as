package ninjakiwi.monkeyTown.town.ui.clock
{
   import assets.town.BuildClockClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import org.osflash.signals.PrioritySignal;
   
   public class BuildClock extends Clock
   {
      
      public static const buildClockSkippedSignal:PrioritySignal = new PrioritySignal(BuildClock);
       
      
      public function BuildClock(param1:BuildClockManager, param2:Function, param3:Building, param4:int)
      {
         _clip = new BuildClockClip();
         super(param1,param2,param3,param4);
      }
      
      override public function simulateClick() : void
      {
         BuildClockManager(manager).userClickedBuildClockSignal.dispatch(this);
      }
      
      override protected function onRollover(param1:MouseEvent) : void
      {
         super.onRollover(param1);
         _completeNowPopup.setCost(getBloonstonesRequiredToSkip());
      }
      
      override public function skip() : void
      {
         buildClockSkippedSignal.dispatch(this);
         super.skip();
      }
      
      override public function update(param1:Number, param2:Number = 1.0) : void
      {
         super.update(param1,GameMods.getModifier(GameModConstants.BUILD_SPEED_MOD));
      }
   }
}
