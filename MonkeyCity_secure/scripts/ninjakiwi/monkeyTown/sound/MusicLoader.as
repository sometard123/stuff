package ninjakiwi.monkeyTown.sound
{
   import flash.media.Sound;
   import org.osflash.signals.Signal;
   
   public class MusicLoader
   {
       
      
      private var _sounds:Object;
      
      private var _loadingSounds:Object;
      
      public const progressSignal:Signal = new Signal(Number,String);
      
      public const completeSignal:Signal = new Signal(Sound,String);
      
      public const errorSignal:Signal = new Signal(String,String);
      
      public function MusicLoader()
      {
         this._sounds = {};
         this._loadingSounds = {};
         super();
      }
      
      public function isMusicLoaded(param1:String) : Boolean
      {
         var _loc2_:LoadingSound = null;
         if(this._sounds.hasOwnProperty(param1))
         {
            _loc2_ = this._loadingSounds[param1];
            return _loc2_.isLoaded;
         }
         return false;
      }
      
      public function loadMusic(param1:String, param2:String = null) : LoadingSound
      {
         if(param2 === null)
         {
            param2 = param1;
         }
         var _loc3_:LoadingSound = new LoadingSound();
         _loc3_.completeSignal.add(this.onMusicLoadComplete);
         _loc3_.progressSignal.add(this.onProgress);
         _loc3_.errorSignal.add(this.onError);
         _loc3_.load(param1,param2);
         this._loadingSounds[_loc3_.id] = _loc3_;
         this._sounds[_loc3_.id] = _loc3_.sound;
         return _loc3_;
      }
      
      public function getLoadingSound(param1:String) : LoadingSound
      {
         var _loc2_:LoadingSound = null;
         if(this._sounds.hasOwnProperty(param1))
         {
            _loc2_ = this._loadingSounds[param1];
            return _loc2_;
         }
         return null;
      }
      
      public function getSound(param1:String) : Sound
      {
         var _loc2_:LoadingSound = this.getLoadingSound(param1);
         if(_loc2_ !== null)
         {
            return _loc2_.sound;
         }
         return null;
      }
      
      public function getProgressOfLoad(param1:String) : Number
      {
         var _loc2_:LoadingSound = this.getLoadingSound(param1);
         if(_loc2_ !== null)
         {
            return _loc2_.progress;
         }
         return 0;
      }
      
      private function onProgress(param1:LoadingSound) : void
      {
         var _loc2_:Number = param1.progress;
         this.progressSignal.dispatch(_loc2_,param1.id);
      }
      
      private function onMusicLoadComplete(param1:LoadingSound) : void
      {
         this.completeSignal.dispatch(param1.sound,param1.id);
      }
      
      private function onError(param1:LoadingSound, param2:String) : void
      {
         this.errorSignal.dispatch(param1.id,param2);
      }
   }
}
