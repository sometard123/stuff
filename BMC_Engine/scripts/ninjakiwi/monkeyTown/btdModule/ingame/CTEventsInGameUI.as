package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.SpecialAgentPanel;
   
   public class CTEventsInGameUI
   {
       
      
      private var _milestonesUIModule:CTMilestonesUIModule;
      
      public function CTEventsInGameUI(param1:SpecialAgentPanel)
      {
         super();
         this._milestonesUIModule = new CTMilestonesUIModule(param1.milestonesModule);
         this.hideAll();
      }
      
      private function hideAll() : void
      {
         this._milestonesUIModule.visible = false;
      }
   }
}
