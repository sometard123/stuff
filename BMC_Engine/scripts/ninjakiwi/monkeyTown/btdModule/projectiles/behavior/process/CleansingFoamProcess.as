package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.weapons.SpikeSpread;
   
   public class CleansingFoamProcess extends BehaviorProcess
   {
      
      private static var effect:Dictionary = new Dictionary();
      
      private static var tVec:Vector2 = new Vector2();
       
      
      public function CleansingFoamProcess()
      {
         super();
      }
      
      override public function execute(param1:Projectile, param2:Number) : void
      {
         var xDist:Number = NaN;
         var xDistSquared:Number = NaN;
         var yDist:Number = NaN;
         var yDistSquared:Number = NaN;
         var movementThresholdSquared:Number = NaN;
         var destroyTimer:GameSpeedTimer = null;
         var projectile:Projectile = param1;
         var timeStep:Number = param2;
         projectile.clip.play();
         if(SpikeSpread.spikeTo[projectile] == null)
         {
            return;
         }
         if(SpikeSpread.spikeTo[projectile].delay > 0)
         {
            SpikeSpread.spikeTo[projectile].delay = SpikeSpread.spikeTo[projectile].delay - timeStep;
            return;
         }
         projectile.x = projectile.x + (SpikeSpread.spikeTo[projectile].to.x - projectile.x) / 5;
         projectile.y = projectile.y + (SpikeSpread.spikeTo[projectile].to.y - projectile.y) / 5;
         if(projectile.effectMask == Bloon.IMMUNITY_ALL)
         {
            if(projectile.clip.currentLabel != "Loop")
            {
               projectile.clip.gotoLabel("Loop");
               projectile.clip.play();
            }
            tVec.x = SpikeSpread.spikeTo[projectile].to.x - projectile.x;
            tVec.y = SpikeSpread.spikeTo[projectile].to.y - projectile.y;
            projectile.rotation = tVec.rotation;
            xDist = SpikeSpread.spikeTo[projectile].to.x - projectile.x;
            xDistSquared = xDist * xDist;
            yDist = SpikeSpread.spikeTo[projectile].to.y - projectile.y;
            yDistSquared = yDist * yDist;
            movementThresholdSquared = 9;
            if(xDistSquared + yDistSquared < movementThresholdSquared)
            {
               projectile.clip.gotoLabel("Bubble");
               projectile.setEffectMask();
               destroyTimer = new GameSpeedTimer(8.5);
               destroyTimer.extra = {"projectile":projectile};
               destroyTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
               {
                  var _loc2_:Projectile = (param1.target as GameSpeedTimer).extra.projectile;
                  Main.instance.game.level.removeProjectile(_loc2_);
                  _loc2_.destroy();
               });
            }
         }
         projectile.clip.looping = true;
      }
   }
}
