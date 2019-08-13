package ninjakiwi.monkeyTown.ui
{
   import assets.town.LoseInfoPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class LoseInfoPanel extends HideRevealViewPopup
   {
      
      public static var instance:LoseInfoPanel = null;
       
      
      protected var _clip:LoseInfoPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      public var okSignal:Signal;
      
      private var _textFieldY:int;
      
      public function LoseInfoPanel(param1:DisplayObjectContainer)
      {
         this._clip = new LoseInfoPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this.okSignal = new Signal();
         this._textFieldY = this._clip.loseDescriptionTxt.y;
         instance = this;
         super(param1);
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this.isModal = true;
         this._clip.loseDescriptionTxt.multiline = true;
         this._okButton.setClickFunction(this.onOkButton);
         setAutoPlayStopClipsArray([this._clip.skull1,this._clip.skull2]);
      }
      
      public function syncToGameResult(param1:GameResultDefinition) : void
      {
         if(param1.wasContestedTerritory)
         {
            if(param1.roundsCompleted == 0)
            {
               this._clip.loseDescriptionTxt.htmlText = "You abandoned your Monkey<br/> troops to defeat on the battlefield!";
               this._clip.loseDescriptionTxt.y = this._textFieldY - 12;
            }
            else
            {
               this._clip.loseDescriptionTxt.htmlText = "You beat: " + param1.roundsCompleted + " Round" + (param1.roundsCompleted == 1?".":"s.");
               this._clip.loseDescriptionTxt.y = this._textFieldY;
            }
         }
         else if(param1.cancelledGame)
         {
            this._clip.loseDescriptionTxt.htmlText = "You abandoned your Monkey<br/> troops to defeat on the battlefield!";
            this._clip.loseDescriptionTxt.y = this._textFieldY - 12;
         }
         else
         {
            this._clip.loseDescriptionTxt.htmlText = "You ran out of lives on Round: " + param1.roundReached;
            this._clip.loseDescriptionTxt.y = this._textFieldY;
         }
      }
      
      private function onOkButton() : void
      {
         hide();
         this.okSignal.dispatch();
      }
   }
}
