package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   
   public class Target extends BehaviorProcess
   {
       
      
      private var toTarget:Vector2;
      
      private var turnTime_:Number = 0.3;
      
      private var seekAngle_:Number = 1.5707963267948966;
      
      private var seekTarget_:Boolean = false;
      
      public function Target()
      {
         this.toTarget = new Vector2();
         super();
      }
      
      public function set turnTime(param1:Number) : void
      {
         if(this.turnTime_ != param1)
         {
            this.turnTime_ = param1;
            dispatchEvent(new PropertyModEvent("turnTime"));
         }
      }
      
      public function get turnTime() : Number
      {
         return this.turnTime_;
      }
      
      public function TurnTime(param1:Number) : Target
      {
         this.turnTime_ = param1;
         return this;
      }
      
      public function set seekAngle(param1:Number) : void
      {
         if(this.seekAngle_ != param1)
         {
            this.seekAngle_ = param1;
            dispatchEvent(new PropertyModEvent("turnTime"));
         }
      }
      
      public function get seekAngle() : Number
      {
         return this.seekAngle_;
      }
      
      public function SeekAngle(param1:Number) : Target
      {
         this.seekAngle_ = param1;
         return this;
      }
      
      public function set seekTarget(param1:Boolean) : void
      {
         if(this.seekTarget_ != param1)
         {
            this.seekTarget_ = param1;
            dispatchEvent(new PropertyModEvent("SeekTarget"));
         }
      }
      
      public function get seekTarget() : Boolean
      {
         return this.seekTarget_;
      }
      
      public function SeekTarget(param1:Boolean) : Target
      {
         this.seekTarget_ = param1;
         return this;
      }
      
      override public function execute(param1:Projectile, param2:Number) : void
      {
         var _loc4_:Vector.<Vector.<Bloon>> = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Vector.<Bloon> = null;
         var _loc8_:Bloon = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc3_:Bloon = null;
         if(this.seekTarget && param1.target && param1.target.hitPreviously(param1))
         {
            param1.target = null;
         }
         if(this.seekTarget && param1.target)
         {
            _loc3_ = param1.target;
            this.toTarget.x = _loc3_.x - param1.x;
            this.toTarget.y = _loc3_.y - param1.y;
            _loc6_ = param1.velocity.angleBetween(this.toTarget);
            if(_loc3_ != null && (_loc3_.hitPreviously(param1) || _loc3_.isInTunnel || _loc3_.type == -1))
            {
               _loc3_ = null;
            }
         }
         if(_loc3_ == null)
         {
            _loc4_ = param1.level.collisionGrid.getCellsInRange(param1.x,param1.y,900);
            _loc5_ = 999999999;
            _loc6_ = 0;
            for each(_loc7_ in _loc4_)
            {
               for each(_loc8_ in _loc7_)
               {
                  if(!(_loc8_.hitPreviously(param1) || _loc8_.isInTunnel || _loc8_.type == -1))
                  {
                     _loc9_ = (_loc8_.x - param1.x) * (_loc8_.x - param1.x) + (_loc8_.y - param1.y) * (_loc8_.y - param1.y);
                     if(_loc9_ < _loc5_)
                     {
                        this.toTarget.x = _loc8_.x - param1.x;
                        this.toTarget.y = _loc8_.y - param1.y;
                        _loc10_ = param1.velocity.angleBetween(this.toTarget);
                        if(Math.abs(_loc10_) <= this.seekAngle_)
                        {
                           _loc3_ = _loc8_;
                           _loc5_ = _loc9_;
                           _loc6_ = _loc10_;
                        }
                     }
                  }
               }
            }
         }
         if(_loc3_)
         {
            _loc11_ = _loc6_ / (this.turnTime_ / param2);
            if(!isNaN(_loc11_))
            {
               param1.velocity.rotation = param1.velocity.rotation + _loc6_ / (this.turnTime_ / param2);
            }
         }
         param1.x = param1.x + param1.velocity.x * param2;
         param1.y = param1.y + param1.velocity.y * param2;
         param1.rotation = param1.velocity.rotation;
      }
   }
}
