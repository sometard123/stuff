package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.MonkeyKnowledgeTutorialClip;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MonkeyKnowledgeTutorialPanel extends HideRevealView
   {
       
      
      private var _clip:MonkeyKnowledgeTutorialClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _okButton:ButtonControllerBase;
      
      public function MonkeyKnowledgeTutorialPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new MonkeyKnowledgeTutorialClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this._clip.book.gotoAndStop(1);
         this._closeButton.setClickFunction(hide);
         this._okButton.setClickFunction(hide);
         isModal = true;
         setAutoPlayStopClipsArray([this._clip.boxAnimation]);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         var time:Number = param1;
         super.reveal(time);
         setTimeout(function():void
         {
            MonkeySystem.getInstance().flashStage.addEventListener(MouseEvent.CLICK,onStageClick);
         },1000);
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         MonkeySystem.getInstance().flashStage.removeEventListener(MouseEvent.CLICK,this.onStageClick);
      }
   }
}
