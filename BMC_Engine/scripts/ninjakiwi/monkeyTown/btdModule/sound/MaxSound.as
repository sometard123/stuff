package ninjakiwi.monkeyTown.btdModule.sound
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.common.audio.AudioState;
   import org.osflash.signals.Signal;
   
   public class MaxSound
   {
      
      public static var sigSoundMuteChanged:Signal = new Signal();
      
      private static var counts:Dictionary = new Dictionary();
      
      private static var natives:Dictionary = new Dictionary();
      
      private static var channels:Vector.<SoundChannel> = new Vector.<SoundChannel>();
      
      private static var canPlay:Dictionary = new Dictionary();
      
      private static var _isAudable:Boolean = true;
       
      
      private var nativeSound:Sound = null;
      
      private var soundClass:Class = null;
      
      private var channel:SoundChannel = null;
      
      private var timer:Timer = null;
      
      public function MaxSound(param1:Class)
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
         if(counts[param1] == null)
         {
            counts[param1] = 0;
         }
         if(canPlay[param1] == null)
         {
            canPlay[param1] = true;
         }
      }
      
      public static function toggleMute() : void
      {
         var _loc1_:SoundChannel = null;
         var _loc2_:Sound = null;
         isAudable = !isAudable;
         if(!isAudable)
         {
            for each(_loc1_ in channels)
            {
               _loc1_.stop();
            }
            channels.splice(0,channels.length);
            for each(_loc2_ in natives)
            {
               counts[Class(getDefinitionByName(getQualifiedClassName(_loc2_)))] = 0;
            }
         }
         Main.instance.profile.sfxOn = isAudable;
         Main.instance.profile.save();
         sigSoundMuteChanged.dispatch();
         AudioState.sfxIsMuted = Main.instance.profile.sfxOn;
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
         sigSoundMuteChanged.dispatch();
      }
      
      public function play(param1:Number = 1, param2:Number = 0) : void
      {
         if(!isAudable)
         {
            return;
         }
         if(counts[this.soundClass] >= 5 || !canPlay[this.soundClass])
         {
            return;
         }
         this.channel = this.nativeSound.play(0,param2);
         if(this.channel == null)
         {
            return;
         }
         channels.push(this.channel);
         counts[this.soundClass]++;
         this.channel.addEventListener(Event.SOUND_COMPLETE,this.freeUpSound);
         canPlay[this.soundClass] = false;
         this.timer = new Timer(param1 * 0.01 * 1000,1);
         this.timer.start();
         this.timer.addEventListener(TimerEvent.TIMER,this.startPlaying);
      }
      
      public function stop() : void
      {
         if(this.channel == null)
         {
            return;
         }
         this.channel.stop();
         this.freeUpSound();
         canPlay[this.soundClass] = true;
         this.timer.removeEventListener(TimerEvent.TIMER,this.startPlaying);
         this.channel = null;
      }
      
      private function freeUpSound(param1:Event = null) : void
      {
         if(this.channel == null)
         {
            return;
         }
         counts[this.soundClass]--;
         channels.splice(channels.indexOf(this.channel),1);
         this.channel.removeEventListener(Event.SOUND_COMPLETE,this.freeUpSound);
      }
      
      private function startPlaying(param1:Event = null) : void
      {
         canPlay[this.soundClass] = true;
         this.timer.removeEventListener(TimerEvent.TIMER,arguments.callee);
      }
   }
}
