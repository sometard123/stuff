package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.ServerErrorPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.net.JSONRequest;
   import ninjakiwi.net.RequestQueuer;
   
   public class ServerErrorRetryPanel extends HideRevealView
   {
       
      
      private const _clip:ServerErrorPanelClip = new ServerErrorPanelClip();
      
      private const _errorStatePane:MovieClip = this._clip.errorStatePane;
      
      private const _totalFailStatePane:MovieClip = this._clip.failStatePane;
      
      private const _retryButton:ButtonControllerBase = new ButtonControllerBase(this._errorStatePane.retryButton);
      
      private const _failOKButton:ButtonControllerBase = new ButtonControllerBase(this._totalFailStatePane.okButton);
      
      private var _retryingMessage:MovieClip;
      
      private var _retryFunction:Function = null;
      
      private const RETRY_ATTEMPTS:int = 3;
      
      private var _retryAttempsRemaining:int = 3;
      
      private var _canForceRetry:Boolean = false;
      
      public function ServerErrorRetryPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         var container:DisplayObjectContainer = param1;
         var mutexGroup:* = param2;
         this._retryingMessage = new MovieClip();
         super(container,mutexGroup);
         isModal = true;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._retryButton.setClickFunction(this.onReconnectButtonClick);
         this._failOKButton.setClickFunction(this.onFailOKClick);
         this.showServerErrorPane();
         RequestQueuer.serverErrorSignal.add(this.onServerErrorSignal);
         RequestQueuer.requestCompleteSignal.add(function():void
         {
            if(isRevealed)
            {
               hide();
            }
         });
         JSONRequest.canForceRetrySignal.add(this.onCanForceRetry);
      }
      
      private function onCanForceRetry() : void
      {
         this._canForceRetry = true;
      }
      
      private function onServerErrorSignal(param1:Function) : void
      {
         this._retryButton.unlock(1);
         if(isRevealed)
         {
            if(this._retryAttempsRemaining < 1)
            {
               this.showTotalFailPane();
            }
            else
            {
               this.showServerErrorPane();
            }
         }
         else
         {
            if(this._canForceRetry)
            {
               this._canForceRetry = false;
               param1();
               return;
            }
            this.showServerErrorPane();
            this._retryAttempsRemaining = this.RETRY_ATTEMPTS;
         }
         this._retryFunction = param1;
         reveal();
      }
      
      private function showServerErrorPane() : void
      {
         this._retryButton.unlock(1);
         this._errorStatePane.visible = true;
         this._totalFailStatePane.visible = false;
      }
      
      private function showTotalFailPane() : void
      {
         this._errorStatePane.visible = false;
         this._totalFailStatePane.visible = true;
      }
      
      private function onReconnectButtonClick() : void
      {
         if(this._retryFunction === null)
         {
            return;
         }
         this._retryButton.lock(3);
         this._retryAttempsRemaining--;
         this._retryFunction();
      }
      
      private function onFailOKClick() : void
      {
         Main.instance.returnToHomeScreen(true);
         hide();
      }
   }
}
