package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.towers.WhirpoolSink;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class Whirpool extends Entity
   {
       
      
      protected const destroyTimer:GameSpeedTimer = new GameSpeedTimer(15);
      
      private var clip:Clip = null;
      
      private var owner:Tower = null;
      
      public function Whirpool()
      {
         super();
      }
      
      public function initialise(param1:Tower) : void
      {
         this.owner = param1;
         param1.pause = false;
         this.clip = new Clip();
         this.clip.initialise(WhirpoolSink,0);
         this.clip.looping = true;
         this.destroyTimer.addEventListener(GameSpeedTimer.COMPLETE,this.onDestroyTimer);
         Game.GAME_RESTART_RESET_SIGNAL.remove(this.destroy);
         Game.GAME_RESTART_RESET_SIGNAL.add(this.destroy);
         z = 10;
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
         this.clip.process();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.drawScaled(param1,this.owner.x,this.owner.y,this.owner.rotation,this.owner.def.rangeOfVisibility * 0.014);
      }
      
      private function onDestroyTimer(param1:Event) : void
      {
         this.destroy();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.clip = null;
         if(this.owner.def.behavior != null && this.owner.def.behavior.roundOver != null)
         {
            this.owner.def.behavior.roundOver.execute(this.owner);
         }
         this.owner.pause = true;
         if(this.destroyTimer.hasEventListener(GameSpeedTimer.COMPLETE))
         {
            this.destroyTimer.removeEventListener(GameSpeedTimer.COMPLETE,this.onDestroyTimer);
         }
         Game.GAME_RESTART_RESET_SIGNAL.remove(this.destroy);
      }
   }
}
