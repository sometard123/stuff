package ninjakiwi.monkeyTown.btdModule.tutorial.tactics
{
   import assets.btdmodule.ui.RedHotSpikesTutorialPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.tutorial.TacticsTutorial;
   
   public class RHS1TutorialPanel extends TacticsTutorial
   {
       
      
      private const _clip:RedHotSpikesTutorialPanelClip = new RedHotSpikesTutorialPanelClip();
      
      public function RHS1TutorialPanel(param1:DisplayObjectContainer, param2:Object)
      {
         super(param1,this._clip,this._clip.closeButton,this._clip.checkBox,param2);
         this._clip.description.text = "Some Lead Bloons are on their way. If you don\'t have anything that can pop them, never fear! Just drop a stack or two of Red Hot Spikes on the track. Each stack pops up to 20 Bloons. Costs 5 Bloonstones.";
      }
      
      override protected function disableTutorial() : void
      {
         _save.rhs1 = 10;
      }
      
      override public function isDisabled() : Boolean
      {
         return _save.rhs1 >= 10 || _save.rhs2 >= 10;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         _save.rhs1++;
         super.reveal(param1);
      }
   }
}
