package treefortress.sound
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import org.osflash.signals.Signal;
   
   public class SoundInstance
   {
       
      
      public var manager:SoundManager;
      
      public var type:String;
      
      public var url:String;
      
      public var sound:Sound;
      
      public var channel:SoundChannel;
      
      public var soundCompleted:Signal;
      
      public var loops:int;
      
      public var allowMultiple:Boolean;
      
      public var oldChannels:Vector.<SoundChannel>;
      
      protected var _loopsRemaining:int;
      
      protected var _muted:Boolean;
      
      protected var _volume:Number;
      
      protected var _pan:Number;
      
      protected var _masterVolume:Number;
      
      protected var _enableSeamlessLoops:Boolean;
      
      protected var pauseTime:Number;
      
      protected var _isPlaying:Boolean;
      
      protected var _soundTransform:SoundTransform;
      
      var currentTween:SoundTween;
      
      public function SoundInstance(param1:Sound = null, param2:String = null)
      {
         super();
         this.sound = param1;
         this.type = param2;
         this.manager = SoundAS;
         this.pauseTime = 0;
         this._volume = 1;
         this._pan = 0;
         this._masterVolume = 1;
         this._soundTransform = new SoundTransform();
         this.soundCompleted = new Signal(SoundInstance);
         this.oldChannels = new Vector.<SoundChannel>(0);
      }
      
      public function get enableSeamlessLoops() : Boolean
      {
         return this._enableSeamlessLoops;
      }
      
      public function play(param1:Number = 1, param2:Number = 0, param3:int = 0, param4:Boolean = true, param5:Boolean = false) : SoundInstance
      {
         this.loops = param3;
         this._enableSeamlessLoops = param5;
         param3 = param3 < 0?int(int.MAX_VALUE):int(param3);
         this._loopsRemaining = 0;
         if(param5 == false)
         {
            this._loopsRemaining = param3;
            param3 = 0;
         }
         this.allowMultiple = param4;
         if(param4)
         {
            if(this.channel)
            {
               this.oldChannels.push(this.channel);
            }
            this.channel = this.sound.play(param2,param3);
         }
         else
         {
            if(this.channel)
            {
               this.stopChannel(this.channel);
            }
            this.channel = this.sound.play(param2,param3);
         }
         if(this.channel)
         {
            this.channel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
            this._isPlaying = true;
         }
         this.pauseTime = 0;
         this.volume = param1;
         this.mute = this.mute;
         return this;
      }
      
      public function get fade() : SoundTween
      {
         return this.currentTween;
      }
      
      public function pause() : SoundInstance
      {
         if(!this.channel)
         {
            return this;
         }
         this._isPlaying = false;
         this.pauseTime = this.channel.position;
         this.stopChannel(this.channel);
         this.stopOldChannels();
         return this;
      }
      
      public function resume(param1:Boolean = false) : SoundInstance
      {
         if(this.isPaused || param1)
         {
            this.play(this._volume,this.pauseTime,this.loops,this.allowMultiple);
         }
         return this;
      }
      
      public function stop() : SoundInstance
      {
         this.pauseTime = 0;
         this.stopChannel(this.channel);
         this.channel = null;
         this.stopOldChannels();
         this._isPlaying = false;
         return this;
      }
      
      public function get mute() : Boolean
      {
         return this._muted;
      }
      
      public function set mute(param1:Boolean) : void
      {
         this._muted = param1;
         if(this.channel)
         {
            this.channel.soundTransform = !!this._muted?new SoundTransform(0):this.soundTransform;
            this.updateOldChannels();
         }
      }
      
      public function fadeTo(param1:Number, param2:Number = 1000, param3:Boolean = true) : SoundInstance
      {
         this.currentTween = this.manager.addTween(this.type,-1,param1,param2,param3);
         return this;
      }
      
      public function fadeFrom(param1:Number, param2:Number, param3:Number = 1000, param4:Boolean = true) : SoundInstance
      {
         this.currentTween = this.manager.addTween(this.type,param1,param2,param3,param4);
         return this;
      }
      
      public function get isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function get mixedVolume() : Number
      {
         return this._volume * this._masterVolume;
      }
      
      public function get isPaused() : Boolean
      {
         return this.channel && this.sound && this.pauseTime > 0 && this.pauseTime < this.sound.length;
      }
      
      public function get position() : Number
      {
         return !!this.channel?Number(this.channel.position):Number(0);
      }
      
      public function set position(param1:Number) : void
      {
         if(this.channel)
         {
            this.stopChannel(this.channel);
         }
         this.channel = this.sound.play(param1,this.loops);
         this.channel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      public function set volume(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 1 || isNaN(this.volume))
         {
            param1 = 1;
         }
         this._volume = param1;
         this.soundTransform.volume = this.mixedVolume;
         if(!this._muted && this.channel)
         {
            this.channel.soundTransform = this.soundTransform;
            this.updateOldChannels();
         }
      }
      
      public function get pan() : Number
      {
         return this._pan;
      }
      
      public function set pan(param1:Number) : void
      {
         if(param1 < -1)
         {
            param1 = -1;
         }
         else if(param1 > 1 || isNaN(this.volume))
         {
            param1 = 1;
         }
         this._pan = this.soundTransform.pan = param1;
         if(!this._muted && this.channel)
         {
            this.channel.soundTransform = this.soundTransform;
            this.updateOldChannels();
         }
      }
      
      public function get masterVolume() : Number
      {
         return this._masterVolume;
      }
      
      public function set masterVolume(param1:Number) : void
      {
         if(this._masterVolume == param1)
         {
            return;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 1)
         {
            param1 = 1;
         }
         this._masterVolume = param1;
         this.volume = this._volume;
      }
      
      public function clone() : SoundInstance
      {
         var _loc1_:SoundInstance = new SoundInstance(this.sound,this.type);
         return _loc1_;
      }
      
      public function destroy() : void
      {
         this.soundCompleted.removeAll();
         try
         {
            this.sound.close();
         }
         catch(e:Error)
         {
         }
         this.sound = null;
         this._soundTransform = null;
         this.stopChannel(this.channel);
         this.channel = null;
         this.fade.end(false);
      }
      
      protected function onSoundComplete(param1:Event) : void
      {
         var _loc2_:SoundChannel = param1.target as SoundChannel;
         _loc2_.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
         if(_loc2_ == this.channel)
         {
            this.channel = null;
            this.pauseTime = 0;
            if(this._enableSeamlessLoops == false)
            {
               if(this.loops == -1)
               {
                  this.play(this._volume,0,-1,this.allowMultiple);
               }
               else if(this._loopsRemaining--)
               {
                  this.play(this._volume,0,this._loopsRemaining,this.allowMultiple);
               }
               else
               {
                  this._isPlaying = false;
                  this.soundCompleted.dispatch(this);
               }
            }
            else
            {
               this.soundCompleted.dispatch(this);
            }
         }
         var _loc3_:int = this.oldChannels.length;
         while(_loc3_--)
         {
            if(_loc2_.position == this.sound.length)
            {
               this.stopChannel(_loc2_);
               this.oldChannels.splice(_loc3_,1);
            }
         }
      }
      
      public function get loopsRemaining() : int
      {
         return this._loopsRemaining;
      }
      
      protected function stopChannel(param1:SoundChannel) : void
      {
         if(!param1)
         {
            return;
         }
         param1.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
         try
         {
            param1.stop();
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      protected function stopOldChannels() : void
      {
         if(!this.oldChannels.length)
         {
            return;
         }
         var _loc1_:int = this.oldChannels.length;
         while(_loc1_--)
         {
            this.stopChannel(this.oldChannels[_loc1_]);
         }
         this.oldChannels.length = 0;
      }
      
      protected function updateOldChannels() : void
      {
         if(!this.channel)
         {
            return;
         }
         var _loc1_:int = this.oldChannels.length;
         while(_loc1_--)
         {
            this.oldChannels[_loc1_].soundTransform = this.channel.soundTransform;
         }
      }
      
      public function get soundTransform() : SoundTransform
      {
         if(!this._soundTransform)
         {
            this._soundTransform = new SoundTransform(this.mixedVolume,this._pan);
         }
         return this._soundTransform;
      }
      
      public function set soundTransform(param1:SoundTransform) : void
      {
         if(param1.volume > 0)
         {
            this._muted = false;
         }
         else if(param1.volume == 0)
         {
            this._muted = true;
         }
         this.channel.soundTransform = param1;
         this.updateOldChannels();
      }
   }
}
