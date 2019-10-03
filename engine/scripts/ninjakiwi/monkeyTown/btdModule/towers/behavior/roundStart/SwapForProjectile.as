package ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart
{
   import assets.projectile.GrilledPineappleBomb;
   import assets.projectile.PineappleBomb;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SwapForProjectile extends BehaviorRoundStart
   {
       
      
      private var projectile_:ProjectileDef;
      
      private var lifespan_:Number = 0;
      
      public function SwapForProjectile()
      {
         super();
      }
      
      public function set projectile(param1:ProjectileDef) : void
      {
         if(this.projectile_ != param1)
         {
            this.projectile_ = param1;
            dispatchEvent(new PropertyModEvent("projectile"));
         }
      }
      
      public function get projectile() : ProjectileDef
      {
         return this.projectile_;
      }
      
      public function Projectile(param1:ProjectileDef) : SwapForProjectile
      {
         this.projectile = param1;
         return this;
      }
      
      public function set lifespan(param1:Number) : void
      {
         if(this.lifespan_ != param1)
         {
            this.lifespan_ = param1;
            dispatchEvent(new PropertyModEvent("lifespan"));
         }
      }
      
      public function get lifespan() : Number
      {
         return this.lifespan_;
      }
      
      public function Lifespan(param1:Number) : SwapForProjectile
      {
         this.lifespan = param1;
         return this;
      }
      
      override public function execute(param1:Tower) : void
      {
         var newProjectile:Projectile = null;
         var tower:Tower = param1;
         newProjectile = Pool.get(Projectile);
         newProjectile.initialise(this.projectile,tower.level,tower.buffs,null);
         newProjectile.owner = tower;
         newProjectile.x = tower.x;
         newProjectile.y = tower.y;
         newProjectile.lifespan = this.lifespan;
         newProjectile.rotation = tower.rotation;
         tower.level.addProjectile(newProjectile);
         var timerFrame:GameSpeedTimer = null;
         if(newProjectile.def.display == PineappleBomb)
         {
            newProjectile.lifespan = 0.6 * 3;
            newProjectile.clip.gotoAndStop(3);
            timerFrame = new GameSpeedTimer(0.6,2);
            timerFrame.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
            {
               newProjectile.clip.gotoAndStop(newProjectile.clip.frameIndex - 1);
            });
            timerFrame.start();
         }
         else if(newProjectile.def.display == GrilledPineappleBomb)
         {
            newProjectile.lifespan = 0.6;
            newProjectile.clip.gotoAndStop(2);
            timerFrame = new GameSpeedTimer(0.6,2);
            timerFrame.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
            {
               newProjectile.clip.gotoAndStop(newProjectile.clip.frameIndex - 1);
            });
            timerFrame.start();
         }
         else
         {
            newProjectile.clip.stop();
         }
         var ts:String = tower.rootID;
         tower.level.removeTower(tower);
         tower.destroy();
      }
   }
}
