package ninjakiwi.monkeyTown.btdModule.levels.util
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import ninjakiwi.monkeyTown.common.Constants;
   import org.osflash.signals.Signal;
   
   public class LevelSwfLoader
   {
      
      private static var _loaders:Object = {};
       
      
      public const completeSignal:Signal = new Signal(MovieClip,ApplicationDomain);
      
      public const progressSignal:Signal = new Signal(Number);
      
      public const ioErrorSignal:Signal = new Signal();
      
      private var _name:String = null;
      
      private var _loadedSwf:MovieClip = null;
      
      public function LevelSwfLoader(param1:String = null)
      {
         super();
         if(param1 !== null)
         {
            this.load(param1);
         }
      }
      
      public static function getInstance(param1:String) : void
      {
      }
      
      public function clean() : void
      {
         this.completeSignal.removeAll();
         this.progressSignal.removeAll();
         this.ioErrorSignal.removeAll();
         this._name = null;
         this._loadedSwf = null;
      }
      
      public function load(param1:String) : void
      {
         var _loc6_:MovieClip = null;
         if(this._name !== null)
         {
            return;
         }
         this._name = param1;
         var _loc2_:String = Constants.BASE_PATH + Constants.LEVEL_URL + "/" + param1 + Constants.BUST_STRING;
         var _loc3_:Loader = _loaders[param1];
         if(_loc3_)
         {
            _loc6_ = MovieClip(_loc3_.contentLoaderInfo.content);
            this.completeSignal.dispatch(_loc6_,_loc3_.contentLoaderInfo.applicationDomain);
            return;
         }
         var _loc4_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loc3_ = _loaders[param1] = new Loader();
         var _loc5_:URLRequest = new URLRequest(_loc2_);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onCompleteHandler);
         _loc3_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgressHandler);
         _loc3_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onErrorHandler);
         _loc3_.load(_loc5_,_loc4_);
      }
      
      private function onCompleteHandler(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this._loadedSwf = MovieClip(_loc2_.content);
         this._loadedSwf.addEventListener(Event.FRAME_CONSTRUCTED,this.onSWFFrameConstructed);
         this._loadedSwf.gotoAndStop(1);
         this.completeSignal.dispatch(this._loadedSwf,_loc2_.applicationDomain);
      }
      
      private function onSWFFrameConstructed(param1:Event) : void
      {
         this._loadedSwf.removeEventListener(Event.FRAME_CONSTRUCTED,this.onSWFFrameConstructed);
         while(this._loadedSwf.numChildren > 0)
         {
            this._loadedSwf.removeChildAt(0);
         }
      }
      
      private function onErrorHandler(param1:IOErrorEvent) : void
      {
         this.ioErrorSignal.dispatch();
      }
      
      private function onProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         this.progressSignal.dispatch(_loc2_);
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}
