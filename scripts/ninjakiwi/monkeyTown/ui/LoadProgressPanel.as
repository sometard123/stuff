package ninjakiwi.monkeyTown.ui
{
   import assets.ui.LoadProgressPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   
   public class LoadProgressPanel extends HideRevealView
   {
       
      
      private var _clip:LoadProgressPanelClip;
      
      private var _target:EventDispatcher;
      
      public function LoadProgressPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new LoadProgressPanelClip();
         addChild(this._clip);
         super(param1,param2);
         isModal = true;
         enableDefaultOnResize(this._clip);
         this.reset();
      }
      
      public function setProgress(param1:Number) : void
      {
         this._clip.bar.scaleX = param1;
      }
      
      public function setMessage(param1:String) : void
      {
         this._clip.loadingMessage.htmlText = param1;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.setProgress(0);
         this.setMessage("Loading...");
         if(this._target !== null)
         {
            this._target.removeEventListener(Event.COMPLETE,this.onCompleteHandler);
            this._target.removeEventListener(ProgressEvent.PROGRESS,this.onProgressHandler);
            this._target = null;
         }
      }
      
      public function watch(param1:EventDispatcher) : void
      {
         this._target = param1;
         this._target.addEventListener(Event.COMPLETE,this.onCompleteHandler,false,0,true);
         this._target.addEventListener(ProgressEvent.PROGRESS,this.onProgressHandler,false,0,true);
         reveal();
      }
      
      private function onCompleteHandler(param1:Event) : void
      {
         hide();
         this.reset();
         this.setProgress(1);
      }
      
      private function onProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         this.setProgress(_loc2_);
      }
   }
}
