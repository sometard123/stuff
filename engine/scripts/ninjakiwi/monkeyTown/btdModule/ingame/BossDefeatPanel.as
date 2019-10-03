package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.town.BossDefeatPanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class BossDefeatPanel extends HideRevealViewSimple
   {
       
      
      protected var _clip:BossDefeatPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      public var okSignal:Signal;
      
      private var _textFieldY:int;
      
      public function BossDefeatPanel(param1:DisplayObjectContainer)
      {
         this._clip = new BossDefeatPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this.okSignal = new Signal();
         this._textFieldY = this._clip.loseDescriptionTxt.y;
         super(param1);
         addChild(this._clip);
         this._clip.loseDescriptionTxt.multiline = true;
         this._okButton.setClickFunction(this.onOkButton);
         setAutoPlayStopClipsArray([this._clip.skull1,this._clip.skull2]);
      }
      
      private function onOkButton() : void
      {
         this.hide();
         this.okSignal.dispatch();
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         super.reveal(param1);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this._clip.skull1,true,true,true);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this._clip.skull2,true,true,true);
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this._clip.skull1,false,true,true);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this._clip.skull2,false,true,true);
      }
   }
}
