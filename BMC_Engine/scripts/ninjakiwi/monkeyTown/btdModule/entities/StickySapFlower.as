package ninjakiwi.monkeyTown.btdModule.entities
{
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class StickySapFlower extends Entity
   {
       
      
      private var clip:Clip = null;
      
      private var owner:Tower = null;
      
      private var _abilityDef:AbilityDef = null;
      
      public function StickySapFlower()
      {
         super();
      }
      
      public function initialise(param1:Tower, param2:AbilityDef) : void
      {
         this.owner = param1;
         param1.pause = false;
         this._abilityDef = param2;
         this.clip = param1.clip;
         this.clip.stop();
         if(this.clip.hasLabel("full"))
         {
            this.clip.gotoLabel("full");
         }
         if(this._abilityDef.cooldown == 0)
         {
            this._abilityDef.cooldown = 1;
         }
         param1.timer.addEventListener(GameSpeedTimer.COMPLETE,this.onComplete);
         Game.GAME_RESTART_RESET_SIGNAL.remove(this.destroy);
         Game.GAME_RESTART_RESET_SIGNAL.add(this.destroy);
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
         if(this.owner.timer.current / this._abilityDef.cooldown > 0.6)
         {
            if(this.clip.hasLabel("halffull"))
            {
               this.clip.gotoLabel("halffull");
            }
         }
         else if(this.owner.timer.current / this._abilityDef.cooldown > 0.3)
         {
            if(this.clip.hasLabel("few"))
            {
               this.clip.gotoLabel("few");
            }
         }
      }
      
      private function onComplete(param1:Event) : void
      {
         if(this.clip.hasLabel("full"))
         {
            this.clip.gotoLabel("full");
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.owner.timer.hasEventListener(GameSpeedTimer.COMPLETE))
         {
            this.owner.timer.removeEventListener(GameSpeedTimer.COMPLETE,this.onComplete);
         }
         Game.GAME_RESTART_RESET_SIGNAL.remove(this.destroy);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         super.draw(param1);
      }
   }
}
