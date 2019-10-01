package ninjakiwi.monkeyTown.town.ui
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class BuildPanelPremiumBuildingButton extends BuildPanelMainButton
   {
       
      
      public function BuildPanelPremiumBuildingButton(param1:MovieClip)
      {
         super(param1);
      }
      
      override protected function mouseOverHandler(param1:MouseEvent = null) : void
      {
         super.mouseOverHandler(param1);
         this.syncCurrencyIcon();
      }
      
      override protected function mouseOutHandler(param1:MouseEvent = null) : void
      {
         super.mouseOutHandler(param1);
         this.syncCurrencyIcon();
      }
      
      public function syncCurrencyIcon() : void
      {
         if(!target.hasOwnProperty("currencyIcon") || target.currencyIcon === null)
         {
            return;
         }
         if(Kong.isOnKong())
         {
            target.currencyIcon.gotoAndStop(2);
         }
         else
         {
            target.currencyIcon.gotoAndStop(1);
         }
      }
   }
}
