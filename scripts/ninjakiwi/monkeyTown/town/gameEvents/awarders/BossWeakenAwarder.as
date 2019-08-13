package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   
   public class BossWeakenAwarder extends Awarder
   {
       
      
      public function BossWeakenAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().bossWeakens = ResourceStore.getInstance().bossWeakens + _quantity.value;
      }
   }
}
