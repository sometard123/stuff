package ninjakiwi.monkeyTown.btdModule.weapons
{
   import assets.projectile.GrilledPineappleBomb;
   import assets.projectile.PineappleBomb;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class Surround extends Standard
   {
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var lifespan_:Number = 1;
      
      private var _pierceOverage:Number = 0;
      
      public function Surround(param1:String = null)
      {
         super(param1);
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
      
      public function Lifespan(param1:Number) : Surround
      {
         this.lifespan = param1;
         return this;
      }
      
      public function Range(param1:Number) : Surround
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : Surround
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : Surround
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : Surround
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : Surround
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : Surround
      {
         isBaseWeapon = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var newProjectile:Projectile = null;
         var tower:Tower = param1;
         var spawnFrom:Entity = param2;
         var target:Entity = param3;
         var offset:Vector2 = param4;
         newProjectile = Pool.get(Projectile);
         this._pierceOverage = this._pierceOverage + (projectile.pierce - int(projectile.pierce));
         var extraPierce:int = 0;
         if(this._pierceOverage >= 1)
         {
            extraPierce = int(this._pierceOverage);
            this._pierceOverage = this._pierceOverage - extraPierce;
         }
         newProjectile.initialise(projectile,tower.level,tower.buffs,this,tower,extraPierce,this.extraPiercePrecision);
         newProjectile.owner = tower;
         newProjectile.x = spawnFrom.x;
         newProjectile.y = spawnFrom.y;
         this.extraPiercePrecision = newProjectile.pierceRemainder;
         newProjectile.lifespan = this.lifespan;
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
            newProjectile.clip.gotoAndStop(1);
            timerFrame = new GameSpeedTimer(0.6,1);
            timerFrame.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
            {
               newProjectile.clip.gotoAndStop(newProjectile.clip.frameIndex - 1);
            });
            timerFrame.start();
         }
      }
   }
}
