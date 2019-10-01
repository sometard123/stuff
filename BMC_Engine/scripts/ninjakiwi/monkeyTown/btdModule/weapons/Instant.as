package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class Instant extends Standard
   {
       
      
      public var extraPiercePrecision:Number = 0;
      
      private var tempAngle:Vector2;
      
      private var _pierceOverage:Number = 0;
      
      public function Instant(param1:String = null)
      {
         this.tempAngle = new Vector2();
         super(param1);
      }
      
      public function Range(param1:Number) : Instant
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : Instant
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : Instant
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : Instant
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : Instant
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : Instant
      {
         isBaseWeapon = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc10_:Bloon = null;
         var _loc5_:Bloon = null;
         var _loc6_:int = param1.targetsByPriority.length - 1;
         while(_loc6_ >= 0)
         {
            _loc10_ = param1.targetsByPriority[_loc6_];
            if(_loc10_.type != -1)
            {
               _loc5_ = _loc10_;
               break;
            }
            _loc6_--;
         }
         if(_loc5_ == null)
         {
            param1.clip.gotoAndStop(0);
            return;
         }
         var _loc7_:Projectile = Pool.get(Projectile);
         this._pierceOverage = this._pierceOverage + (projectile.pierce - int(projectile.pierce));
         var _loc8_:int = 0;
         if(this._pierceOverage >= 1)
         {
            _loc8_ = int(this._pierceOverage);
            this._pierceOverage = this._pierceOverage - _loc8_;
         }
         _loc7_.initialise(projectile,param1.level,param1.buffs,this,param1,0,this.extraPiercePrecision);
         _loc7_.owner = param1;
         this.extraPiercePrecision = _loc7_.pierceRemainder;
         var _loc9_:Bloon = _loc5_ as Bloon;
         _loc9_.handleCollision(_loc7_);
         _loc7_.destroy();
         this.tempAngle.x = _loc5_.x - param1.x;
         this.tempAngle.y = _loc5_.y - param1.y;
         param1.rotation = this.tempAngle.rotation;
      }
   }
}
