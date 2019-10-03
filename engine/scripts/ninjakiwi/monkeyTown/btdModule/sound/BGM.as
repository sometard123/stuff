package ninjakiwi.monkeyTown.btdModule.sound
{
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.common.audio.AudioState;
   import org.osflash.signals.Signal;
   
   public class BGM
   {
      
      public static var sigMusicMuteChanged:Signal = new Signal();
      
      private static var maxVol:Number = 0.4;
      
      private static var channel:SoundChannel = null;
      
      private static var queued:Sound;
      
      public static var _isAudable:Boolean = true;
      
      private static var natives:Dictionary = new Dictionary();
       
      
      private var nativeSound:Sound = null;
      
      private var soundClass:Class = null;
      
      private var fader:Number;
      
      public function BGM(param1:Class)
      {
         super();
         this.soundClass = param1;
         if(natives[param1] == null)
         {
            this.nativeSound = new param1();
            natives[param1] = this.nativeSound;
         }
         else
         {
            this.nativeSound = natives[param1];
         }
      }
      
      public static function toggleMute() : void
      {
         isAudable = !isAudable;
         if(channel != null)
         {
            if(isAudable)
            {
               channel.soundTransform = new SoundTransform(maxVol);
            }
            else
            {
               channel.soundTransform = new SoundTransform(0);
            }
         }
         Main.instance.profile.bgmOn = isAudable;
         Main.instance.profile.save();
         sigMusicMuteChanged.dispatch();
         AudioState.musicIsMuted = isAudable;
      }
      
      public static function get isAudable() : Boolean
      {
         return _isAudable;
      }
      
      public static function set isAudable(param1:Boolean) : void
      {
         if(_isAudable == param1)
         {
            return;
         }
         _isAudable = param1;
         sigMusicMuteChanged.dispatch();
      }
      
      private function fadeOut() : void
      {
         this.fader = maxVol;
         var _loc1_:Timer = new Timer(1000 / 30,30);
         _loc1_.start();
         _loc1_.addEventListener(TimerEvent.TIMER,this.continueFade);
         _loc1_.addEventListener(TimerEvent.TIMER_COMPLETE,this.completeFade);
      }
      
      private function continueFade(param1:TimerEvent) : void
      {
         this.fader = this.fader - maxVol / 30;
         if(isAudable)
         {
            channel.soundTransform = new SoundTransform(this.fader);
         }
      }
      
      private function completeFade(param1:TimerEvent) : void
      {
         param1.target.removeEventListener(TimerEvent.TIMER,this.continueFade);
         param1.target.removeEventListener(TimerEvent.TIMER_COMPLETE,this.completeFade);
         channel.stop();
         this.startSound(queued);
         queued = null;
      }
      
      public function play() : void
      {
         if(channel != null)
         {
            if(!queued)
            {
               this.fadeOut();
            }
            queued = this.nativeSound;
            return;
         }
         this.startSound(this.nativeSound);
      }
      
      private function startSound(param1:Sound) : void
      {
         channel = param1.play(0,999999,new SoundTransform(maxVol));
         if(channel == null)
         {
            return;
         }
         if(isAudable)
         {
            channel.soundTransform = new SoundTransform(maxVol);
         }
         else
         {
            channel.soundTransform = new SoundTransform(0);
         }
      }
   }
}
