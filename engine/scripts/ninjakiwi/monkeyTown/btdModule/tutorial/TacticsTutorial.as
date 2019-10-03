package ninjakiwi.monkeyTown.btdModule.tutorial
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.ingame.ModalBlocker;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   
   public class TacticsTutorial extends HideRevealViewSimple
   {
       
      
      private var _counter:int = 0;
      
      private var _closeButton:ButtonControllerBase;
      
      protected var _save:Object;
      
      private var _tickBox:TickBox;
      
      public function TacticsTutorial(param1:DisplayObjectContainer, param2:MovieClip, param3:MovieClip, param4:MovieClip, param5:Object)
      {
         super(param1);
         this.addChild(param2);
         this._closeButton = new ButtonControllerBase(param3);
         this._closeButton.setClickFunction(this.hide);
         this._tickBox = new TickBox(param4);
         this._save = param5;
      }
      
      public function isDisabled() : Boolean
      {
         return false;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         ModalBlocker.getInstance().reveal("TacticsTutorial",_container);
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         if(this._tickBox.ticked == true)
         {
            this.disableTutorial();
         }
         ModalBlocker.getInstance().hide("TacticsTutorial");
         super.hide(param1);
      }
      
      protected function disableTutorial() : void
      {
      }
   }
}
