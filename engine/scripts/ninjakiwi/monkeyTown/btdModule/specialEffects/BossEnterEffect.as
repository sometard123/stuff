package ninjakiwi.monkeyTown.btdModule.specialEffects
{
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import org.osflash.signals.Signal;
   
   public class BossEnterEffect extends MovieClip
   {
      
      public static const BOSS_ENTER_ANIMATION_QUEUE:Signal = new Signal();
      
      private static const ANIM_BOSS_ENTER:String = "BossEnter";
       
      
      private var _enterAnimation:MovieClip = null;
      
      private var _enterSound:MaxSound = null;
      
      public function BossEnterEffect(param1:MovieClip, param2:Class)
      {
         super();
         this._enterAnimation = param1;
         this._enterAnimation.gotoAndStop(1);
         this._enterAnimation.visible = false;
         addChild(this._enterAnimation);
         this._enterSound = new MaxSound(param2);
         this._enterAnimation.addEventListener(ANIM_BOSS_ENTER,this.onBossEntry);
      }
      
      public function reset() : void
      {
         this._enterAnimation.visible = false;
         this._enterAnimation.gotoAndStop(1);
      }
      
      public function clean() : void
      {
         this.reset();
         this._enterAnimation.removeEventListener(ANIM_BOSS_ENTER,this.onBossEntry);
         removeChild(this._enterAnimation);
         this._enterAnimation = null;
         BOSS_ENTER_ANIMATION_QUEUE.removeAll();
      }
      
      public function onBossEntry(... rest) : void
      {
         BOSS_ENTER_ANIMATION_QUEUE.dispatch();
      }
      
      public function startEffect(param1:int, param2:int) : void
      {
         this.reset();
         this._enterAnimation.x = param1;
         this._enterAnimation.y = param2;
         this._enterAnimation.visible = true;
         this._enterAnimation.gotoAndPlay(1);
         this._enterSound.play();
      }
   }
}
