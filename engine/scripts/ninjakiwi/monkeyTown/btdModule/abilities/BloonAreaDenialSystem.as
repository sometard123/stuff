package ninjakiwi.monkeyTown.btdModule.abilities
{
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.BloonAreaDenialSystemDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class BloonAreaDenialSystem extends Ability
   {
       
      
      public function BloonAreaDenialSystem()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var tower:Tower = param1;
         var def:AbilityDef = param2;
         var pulseTimer:GameSpeedTimer = new GameSpeedTimer(2,5);
         pulseTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            var _loc6_:Bloon = null;
            var _loc7_:Projectile = null;
            var _loc2_:Vector.<Bloon> = tower.level.bloons;
            _loc3_ = 1250;
            _loc4_ = 1225;
            var _loc5_:int = 0;
            for each(_loc6_ in _loc2_)
            {
               if(_loc5_ > 100)
               {
                  break;
               }
               if(!_loc6_.isInTunnel)
               {
                  _loc7_ = Pool.get(Projectile);
                  _loc7_.initialise((def as BloonAreaDenialSystemDef).projectile,tower.level,tower.buffs,null);
                  _loc7_.owner = tower;
                  _loc7_.x = tower.x;
                  _loc7_.y = tower.y;
                  _loc7_.lifespan = _loc3_ / _loc4_;
                  _loc7_.velocity.x = _loc6_.x - _loc7_.x;
                  _loc7_.velocity.y = _loc6_.y - _loc7_.y;
                  _loc7_.velocity.magnitude = _loc4_;
                  _loc7_.rotation = _loc7_.velocity.rotation;
                  tower.level.addProjectile(_loc7_);
                  _loc5_++;
               }
            }
         });
         pulseTimer.current = 2;
         pulseTimer.start();
         super.execute(tower,def);
      }
   }
}
