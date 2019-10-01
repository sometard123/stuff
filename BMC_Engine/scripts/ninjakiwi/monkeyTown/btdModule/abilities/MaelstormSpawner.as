package ninjakiwi.monkeyTown.btdModule.abilities
{
   import assets.projectile.BladeMaelstrom;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class MaelstormSpawner
   {
       
      
      public var tower:Tower = null;
      
      private var timer:GameSpeedTimer;
      
      public function MaelstormSpawner()
      {
         this.timer = new GameSpeedTimer(1 / 30,60);
         super();
         this.timer.addEventListener(GameSpeedTimer.COMPLETE,this.process);
      }
      
      public function process(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Projectile = null;
         if(this.tower.scene == null)
         {
            this.timer.removeEventListener(GameSpeedTimer.COMPLETE,this.process);
         }
         var _loc2_:ProjectileDef = new ProjectileDef().Display(BladeMaelstrom).Pierce(99999).Radius(5).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         _loc3_ = 1000;
         _loc4_ = 400;
         _loc5_ = Pool.get(Projectile);
         _loc5_.initialise(_loc2_,this.tower.level,this.tower.buffs,null);
         _loc5_.owner = this.tower;
         _loc5_.x = this.tower.x;
         _loc5_.y = this.tower.y;
         _loc5_.lifespan = _loc3_ / _loc4_;
         _loc5_.velocity.x = _loc4_;
         _loc5_.velocity.y = 0;
         _loc5_.velocity.rotation = this.timer.repeat / this.timer.initialRepeat * Math.PI * 2 * 2;
         this.tower.level.addProjectile(_loc5_);
         _loc5_ = Pool.get(Projectile);
         _loc5_.initialise(_loc2_,this.tower.level,this.tower.buffs,null);
         _loc5_.owner = this.tower;
         _loc5_.x = this.tower.x;
         _loc5_.y = this.tower.y;
         _loc5_.lifespan = _loc3_ / _loc4_;
         _loc5_.velocity.x = _loc4_;
         _loc5_.velocity.y = 0;
         _loc5_.velocity.rotation = this.timer.repeat / this.timer.initialRepeat * Math.PI * 2 * 2 + Math.PI;
         this.tower.level.addProjectile(_loc5_);
      }
   }
}
