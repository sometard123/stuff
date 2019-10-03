package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class StopAnimation extends BehaviorRoundOver
   {
       
      
      public function StopAnimation()
      {
         super();
      }
      
      override public function execute(param1:Tower) : void
      {
         param1.clip.gotoAndStop(0);
         if(param1.addonClips == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.addonClips.length)
         {
            param1.addonClips[_loc2_].looping = false;
            param1.addonClips[_loc2_].gotoAndStop(0);
            _loc2_++;
         }
      }
   }
}
