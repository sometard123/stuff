package ninjakiwi.monkeyTown.sound
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import org.osflash.signals.Signal;
   
   public class LoadingSound
   {
       
      
      public var sound:Sound;
      
      public var url:String;
      
      public var id:String;
      
      private var _progress:Number = 0;
      
      public const progressSignal:Signal = new Signal(LoadingSound);
      
      public const completeSignal:Signal = new Signal(LoadingSound);
      
      public const errorSignal:Signal = new Signal(LoadingSound,String);
      
      private var _isLoaded:Boolean = false;
      
      public function LoadingSound()
      {
         super();
      }
      
      public function load(param1:String, param2:String = "") : void
      {
         this.sound = new Sound();
         this.id = param2;
         this.sound.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this.sound.addEventListener(Event.COMPLETE,this.onComplete);
         this.sound.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         var _loc3_:URLRequest = new URLRequest(param1);
         this.sound.load(_loc3_);
      }
      
      private function onComplete(param1:Event) : void
      {
         this._isLoaded = true;
         this.completeSignal.dispatch(this);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         this._progress = param1.bytesLoaded / param1.bytesTotal;
         this.progressSignal.dispatch(this);
      }
      
      private function onError(param1:IOErrorEvent) : void
      {
         this.errorSignal.dispatch(this,param1.text);
      }
      
      public function get progress() : Number
      {
         return this._progress;
      }
      
      public function get isLoaded() : Boolean
      {
         return this._isLoaded;
      }
   }
}
