package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class FireAtMouseSpread extends Standard implements HasSpread
   {
      
      private static var angleTempVect:Vector2 = new Vector2();
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var spread_:Number = 0;
      
      private var tmpRotation:Vector2;
      
      public function FireAtMouseSpread()
      {
         this.tmpRotation = new Vector2();
         super();
      }
      
      public function set spread(param1:Number) : void
      {
         if(this.spread_ != param1)
         {
            this.spread_ = param1;
            dispatchEvent(new PropertyModEvent("spread"));
         }
      }
      
      public function get spread() : Number
      {
         return this.spread_;
      }
      
      public function Spread(param1:Number) : FireAtMouseSpread
      {
         this.spread = param1;
         return this;
      }
      
      public function Range(param1:Number) : FireAtMouseSpread
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : FireAtMouseSpread
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : FireAtMouseSpread
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : FireAtMouseSpread
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : FireAtMouseSpread
      {
         proxied = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc8_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:Vector2 = null;
         var _loc13_:Projectile = null;
         var _loc5_:Vector2 = new Vector2();
         if(param1.targetingSystem == TowerDef.TARGETS_MOUSE)
         {
            _loc12_ = param1.level.getMousePos();
            _loc5_.x = _loc12_.x;
            _loc5_.y = _loc12_.y;
         }
         else if(param1.targetingSystem == TowerDef.TARGETS_RETICLE)
         {
            _loc5_ = FireAtReticle.GetLocation(param1);
         }
         var _loc6_:Number = 0.3;
         var _loc7_:int = 3;
         if(param3 != null)
         {
            angleTempVect.x = _loc5_.x - param2.x;
            angleTempVect.y = _loc5_.y - param2.y;
         }
         else
         {
            angleTempVect.x = 0;
            angleTempVect.y = -1;
         }
         _loc8_ = angleTempVect.rotation - _loc6_ / 2;
         var _loc9_:Number = _loc6_ / (_loc7_ - 1);
         var _loc10_:Projectile = null;
         _loc11_ = 0;
         while(_loc11_ < _loc7_)
         {
            _loc13_ = Pool.get(Projectile);
            _loc13_.initialise(projectile,param1.level,param1.buffs,this,param1,0,this.extraPiercePrecision);
            _loc13_.owner = param1;
            _loc13_.x = param2.x;
            _loc13_.y = param2.y;
            _loc13_.lifespan = range / power;
            _loc13_.velocity.x = power;
            _loc13_.velocity.y = 0;
            _loc13_.velocity.rotateBy(_loc8_ + _loc9_ * _loc11_);
            _loc13_.rotation = _loc13_.velocity.rotation;
            _loc13_.velocity.rotateBy(Rndm.random() * this.spread - this.spread / 2);
            if(param4)
            {
               this.tmpRotation.x = param4.x;
               this.tmpRotation.y = param4.y;
               this.tmpRotation.rotateBy(_loc13_.rotation);
               _loc13_.x = _loc13_.x + this.tmpRotation.x;
               _loc13_.y = _loc13_.y + this.tmpRotation.y;
            }
            param1.level.addProjectile(_loc13_);
            _loc10_ = _loc13_;
            _loc11_++;
         }
         if(_loc10_ != null)
         {
            this.extraPiercePrecision = _loc10_.pierceRemainder;
         }
      }
   }
}
