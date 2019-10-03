package ninjakiwi.monkeyTown.ui.videoAds
{
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class InterstitialController
   {
       
      
      public function InterstitialController()
      {
         super();
         this.initSignals();
      }
      
      public function btdGameComplete() : void
      {
         this.everyThreeQueueEvent();
      }
      
      private function initSignals() : void
      {
         TownUI.getInstance().pvpAttackPanel.revealStartSignal.add(this.everyTwoQueueEvent);
      }
      
      private function everyThreeQueueEvent(... rest) : void
      {
         MonkeyCityMain.getInstance().ui.videoPromptGeneric.queue(VideoPromptInterstitial.THREE);
      }
      
      private function everyTwoQueueEvent(... rest) : void
      {
         MonkeyCityMain.getInstance().ui.videoPromptGeneric.queue(VideoPromptInterstitial.TWO);
      }
   }
}
