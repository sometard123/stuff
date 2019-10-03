package ninjakiwi.monkeyTown.btdModule.tutorial.tactics
{
   import assets.btdmodule.ui.RedHotSpikesTutorialPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.tutorial.TacticsTutorial;
   
   public class RHS2TutorialPanel extends TacticsTutorial
   {
       
      
      private const _clip:RedHotSpikesTutorialPanelClip = new RedHotSpikesTutorialPanelClip();
      
      public function RHS2TutorialPanel(param1:DisplayObjectContainer, param2:Object)
      {
         super(param1,this._clip,this._clip.closeButton,this._clip.checkBox,param2);
         this._clip.description.text = "Some Camo Lead Bloons are on their way.";
      }
      
      override protected function disableTutorial() : void
      {
         _save.rhs2 = 10;
      }
      
      override public function isDisabled() : Boolean
      {
         return _save.rhs1 >= 10 || _save.rhs2 >= 10;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         _save.rhs2++;
         super.reveal(param1);
      }
   }
}
