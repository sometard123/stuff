package ninjakiwi.monkeyTown.preloader
{
   import assets.ui.DevLoadBar;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.utils.getDefinitionByName;
   
   public class Preloader extends MovieClip
   {
       
      
      private var _clip:DevLoadBar;
      
      public function Preloader()
      {
         this._clip = new DevLoadBar();
         super();
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         addEventListener(Event.ENTER_FRAME,this.checkFrame);
         loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progress);
         loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioError);
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = false;
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         this.resize();
         this._clip.bar.scaleX = 0;
         _loc2_ = stage.root.loaderInfo.parameters;
         _loc3_ = _loc2_.userServices == "kong";
         if(_loc3_)
         {
            addChild(this._clip);
         }
         stage.addEventListener(Event.RESIZE,this.resize);
      }
      
      private function resize(param1:Event = null) : void
      {
         this._clip.x = Math.floor(stage.stageWidth * 0.5);
         this._clip.y = Math.floor(stage.stageHeight * 0.5);
      }
      
      private function ioError(param1:IOErrorEvent) : void
      {
      }
      
      private function progress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         this._clip.bar.scaleX = _loc2_;
      }
      
      private function checkFrame(param1:Event) : void
      {
         if(currentFrame == totalFrames)
         {
            stop();
            this.loadingFinished();
         }
      }
      
      private function loadingFinished() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.checkFrame);
         loaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progress);
         loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         if(this.contains(this._clip))
         {
            removeChild(this._clip);
         }
         stage.removeEventListener(Event.RESIZE,this.resize);
         this.startup();
      }
      
      private function startup() : void
      {
         var _loc1_:Class = getDefinitionByName("ninjakiwi.monkeyTown.Main") as Class;
         addChild(new _loc1_() as DisplayObject);
      }
   }
}
