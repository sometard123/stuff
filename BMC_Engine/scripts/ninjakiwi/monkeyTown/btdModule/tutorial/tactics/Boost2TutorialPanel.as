package ninjakiwi.monkeyTown.btdModule.tutorial.tactics
{
   import assets.btdmodule.ui.MonkeyBoostTutorialPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.tutorial.TacticsTutorial;
   
   public class Boost2TutorialPanel extends TacticsTutorial
   {
       
      
      private const _clip:MonkeyBoostTutorialPanelClip = new MonkeyBoostTutorialPanelClip();
      
      public function Boost2TutorialPanel(param1:DisplayObjectContainer, param2:Object)
      {
         super(param1,this._clip,this._clip.closeButton,this._clip.checkBox,param2);
         this._clip.description.text = "Here comes some MOAB class bloons that might overwhelm your Monkeys! Use Monkey Boost to speed up all of your Monkeys for 10 seconds.";
      }
      
      override protected function disableTutorial() : void
      {
         super.disableTutorial();
         _save.boost2 = 10;
      }
      
      override public function isDisabled() : Boolean
      {
         return _save.boost1 >= 10 || _save.boost2 >= 10;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         _save.boost2++;
         super.reveal(param1);
      }
   }
}
