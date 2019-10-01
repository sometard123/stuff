package ninjakiwi.monkeyTown.btdModule.entities
{
   import display.Clip;
   import display.LabelOverCommand;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasRange;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasReloadTime;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class AceAircraft extends Entity
   {
      
      public static const CIRCLE:int = 0;
      
      public static const VERTICAL:int = 1;
      
      public static const HORIZONTAL:int = 2;
       
      
      private var clip:Clip;
      
      private var owner:Tower = null;
      
      private var reloadTimers:Vector.<GameSpeedTimer>;
      
      public var scale:Number = 1;
      
      public var def:TowerDef = null;
      
      public var base:Point;
      
      private var largeRadius:Number = 150;
      
      private var smallRadius:Number = 100;
      
      private var speed:Number = 4;
      
      private var pathPositions:Vector.<Vector2>;
      
      private var pathDirections:Vector.<Number>;
      
      public var pathType:int = 1;
      
      private var onPath:Boolean = false;
      
      private var pathIndex:int = 0;
      
      private var minTurnRadius:Number = 75;
      
      private var deltaRotation:Number;
      
      public function AceAircraft()
      {
         this.clip = new Clip();
         this.base = new Point();
         this.deltaRotation = this.speed / this.minTurnRadius;
         super();
      }
      
      public function Initialise(param1:Tower, param2:Class, param3:TowerDef) : void
      {
         var _loc4_:Weapon = null;
         var _loc5_:HasReloadTime = null;
         var _loc6_:GameSpeedTimer = null;
         this.owner = param1;
         this.def = param3;
         this.clip.initialise(param2,0);
         this.clip.looping = false;
         this.base.x = param1.x;
         this.base.y = param1.y;
         if(this.clip.hasLabel("Idle"))
         {
            this.clip.labelOver["Idle"] = new LabelOverCommand();
            this.clip.labelOver["Idle"].command = LabelOverCommand.gotoAndPlay;
            this.clip.labelOver["Idle"].frameNoTo = 10;
            this.clip.gotoLabel("Idle");
            this.clip.play();
         }
         this.reloadTimers = new Vector.<GameSpeedTimer>();
         for each(_loc4_ in param1.def.weapons)
         {
            _loc5_ = _loc4_ as HasReloadTime;
            if(_loc5_ != null)
            {
               _loc6_ = new GameSpeedTimer(_loc5_.reloadTime);
               this.reloadTimers.push(_loc6_);
            }
         }
         x = this.base.x;
         y = this.base.y;
         this.switchTo(this.pathType);
         z = 2000;
      }
      
      override public function process(param1:Number) : void
      {
         var _loc3_:Vector.<Vector.<Bloon>> = null;
         var _loc4_:Number = NaN;
         var _loc5_:Bloon = null;
         var _loc6_:Vector.<Bloon> = null;
         var _loc7_:Number = NaN;
         var _loc8_:Bloon = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(this.onPath)
         {
            this.processMovementOnPath();
         }
         else
         {
            this.processMovementNotOnPath();
         }
         this.clip.process();
         if(!this.owner.level.isRoundInProgress())
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.reloadTimers.length)
         {
            if(!(this.reloadTimers[_loc2_].running || this.owner.isFrozen))
            {
               if(this.owner.def.weapons[_loc2_].id == "spectreWeapon")
               {
                  _loc3_ = this.owner.level.collisionGrid.getCellsInRange(x,y,(this.owner.def.weapons[_loc2_] as HasRange).range);
                  _loc4_ = 999999999;
                  _loc5_ = null;
                  for each(_loc6_ in _loc3_)
                  {
                     for each(_loc8_ in _loc6_)
                     {
                        if(!_loc8_.isInTunnel)
                        {
                           _loc9_ = _loc8_.x - x;
                           _loc10_ = _loc8_.y - y;
                           _loc11_ = _loc9_ * _loc9_ + _loc10_ * _loc10_;
                           if(_loc11_ < _loc4_)
                           {
                              _loc5_ = _loc8_;
                              _loc4_ = _loc11_;
                           }
                        }
                     }
                  }
                  _loc7_ = (this.owner.def.weapons[_loc2_] as HasRange).range;
                  if(!(_loc5_ == null || _loc4_ > _loc7_ * _loc7_))
                  {
                     this.owner.def.weapons[_loc2_].execute(this.owner,this,_loc5_);
                     this.reloadTimers[_loc2_].reset();
                  }
               }
               else if(this.owner.level.bloons.length > 0)
               {
                  this.owner.def.weapons[_loc2_].execute(this.owner,this,_loc5_);
                  this.reloadTimers[_loc2_].reset();
               }
            }
            _loc2_++;
         }
      }
      
      private function processMovementOnPath() : void
      {
         this.pathIndex++;
         this.pathIndex = this.pathIndex < this.pathPositions.length?int(this.pathIndex):0;
         rotation = this.pathDirections[this.pathIndex];
         var _loc1_:Vector2 = this.pathPositions[this.pathIndex];
         x = _loc1_.x;
         y = _loc1_.y;
      }
      
      private function processMovementNotOnPath() : void
      {
         var _loc7_:Vector2 = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc1_:Number = this.pathDirections[this.pathDirections.length - 1];
         var _loc2_:Vector2 = this.pathPositions[0];
         var _loc3_:Number = Math.pow(_loc2_.x - x,2) + Math.pow(_loc2_.y - y,2);
         var _loc4_:int = 1;
         while(_loc4_ < this.pathPositions.length)
         {
            _loc7_ = this.pathPositions[_loc4_];
            _loc8_ = Math.pow(_loc7_.x - x,2) + Math.pow(_loc7_.y - y,2);
            if(_loc8_ < _loc3_)
            {
               _loc9_ = this.pathDirections[_loc4_];
               while(_loc9_ < rotation - Math.PI)
               {
                  _loc9_ = _loc9_ + 2 * Math.PI;
               }
               while(_loc9_ > rotation + Math.PI)
               {
                  _loc9_ = _loc9_ - 2 * Math.PI;
               }
               _loc10_ = _loc9_ - rotation;
               _loc10_ = _loc10_ < 0?Number(-_loc10_):Number(_loc10_);
               if(_loc10_ < Math.PI / 4)
               {
                  _loc3_ = _loc8_;
                  _loc1_ = _loc9_;
                  _loc2_ = _loc7_;
               }
            }
            _loc4_++;
         }
         var _loc5_:Number = Math.atan2(_loc2_.y - y,_loc2_.x - x);
         while(_loc5_ < rotation - Math.PI)
         {
            _loc5_ = _loc5_ + Math.PI * 2;
         }
         while(_loc5_ > rotation + Math.PI)
         {
            _loc5_ = _loc5_ - Math.PI * 2;
         }
         while(_loc1_ < _loc5_ - Math.PI)
         {
            _loc1_ = _loc1_ + Math.PI * 2;
         }
         while(_loc1_ > _loc5_ + Math.PI)
         {
            _loc1_ = _loc1_ - Math.PI * 2;
         }
         var _loc6_:Number = Math.max(1 - Math.min(1,Math.sqrt(_loc3_) / this.minTurnRadius),0.6);
         _loc5_ = _loc5_ + _loc6_ * (_loc1_ - _loc5_);
         if(_loc5_ > rotation)
         {
            rotation = Math.min(rotation + this.deltaRotation,_loc5_);
         }
         else if(_loc5_ < rotation)
         {
            rotation = Math.max(rotation - this.deltaRotation,_loc5_);
         }
         x = x + Math.cos(rotation) * this.speed;
         y = y + Math.sin(rotation) * this.speed;
         _loc10_ = rotation - _loc5_;
         _loc10_ = _loc10_ < 0?Number(-_loc10_):Number(_loc10_);
         if(_loc3_ < 1.5 && _loc10_ < 0.05)
         {
            this.onPath = true;
            this.pathIndex = this.pathPositions.indexOf(_loc2_);
         }
      }
      
      public function takeoff() : void
      {
      }
      
      public function land() : void
      {
      }
      
      public function switchTo(param1:int) : void
      {
         this.pathType = param1;
         switch(param1)
         {
            case CIRCLE:
               this.createCirclePath();
               break;
            case HORIZONTAL:
               this.createHorizontalPath();
               break;
            case VERTICAL:
               this.createVerticalPath();
         }
      }
      
      private function createCirclePath() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this.onPath = false;
         this.pathPositions = new Vector.<Vector2>();
         this.pathDirections = new Vector.<Number>();
         var _loc1_:Number = this.largeRadius;
         var _loc2_:Number = _loc1_ * Math.PI * 2 / this.speed;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc3_ / _loc2_;
            _loc5_ = _loc4_ * Math.PI * 2;
            this.pathPositions.push(new Vector2(Math.cos(_loc5_) * _loc1_ + this.base.x,Math.sin(_loc5_) * _loc1_ + this.base.y));
            if(_loc3_ != 0)
            {
               this.pathDirections.push(Math.atan2(this.pathPositions[_loc3_].y - this.pathPositions[_loc3_ - 1].y,this.pathPositions[_loc3_].x - this.pathPositions[_loc3_ - 1].x));
            }
            _loc3_++;
         }
         this.pathDirections.unshift(Math.atan2(this.pathPositions[0].y - this.pathPositions[this.pathPositions.length - 1].y,this.pathPositions[0].x - this.pathPositions[this.pathPositions.length - 1].x));
      }
      
      private function createHorizontalPath() : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         this.onPath = false;
         this.pathPositions = new Vector.<Vector2>();
         this.pathDirections = new Vector.<Number>();
         var _loc1_:Number = this.smallRadius;
         var _loc2_:Number = 0.5;
         var _loc3_:Number = Math.tan(_loc2_) * _loc1_;
         var _loc4_:Number = Math.sin(_loc2_) * _loc3_ + Math.cos(_loc2_) * _loc1_;
         var _loc5_:Number = Math.ceil(_loc1_ * 2 * (Math.PI - _loc2_) / this.speed);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc6_ / _loc5_;
            _loc10_ = _loc9_ * 2 * (Math.PI - _loc2_) + _loc2_;
            this.pathPositions.push(new Vector2(Math.cos(_loc10_) * _loc1_ + this.base.x - _loc4_,Math.sin(_loc10_) * _loc1_ + this.base.y));
            if(_loc6_ != 0)
            {
               this.pathDirections.push(Math.atan2(this.pathPositions[_loc6_].y - this.pathPositions[_loc6_ - 1].y,this.pathPositions[_loc6_].x - this.pathPositions[_loc6_ - 1].x));
            }
            _loc6_++;
         }
         _loc5_ = Math.ceil(2 * _loc3_ / this.speed);
         var _loc7_:Vector2 = new Vector2();
         _loc7_.x = Math.cos(-Math.PI / 2 - _loc2_) * _loc3_ + this.base.x;
         _loc7_.y = Math.sin(-Math.PI / 2 - _loc2_) * _loc3_ + this.base.y;
         var _loc8_:Vector2 = new Vector2();
         _loc8_.x = Math.cos(Math.PI / 2 - _loc2_) * _loc3_ + this.base.x;
         _loc8_.y = Math.sin(Math.PI / 2 - _loc2_) * _loc3_ + this.base.y;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc6_ / _loc5_;
            this.pathPositions.push(new Vector2(_loc7_.x + _loc9_ * (_loc8_.x - _loc7_.x),_loc7_.y + _loc9_ * (_loc8_.y - _loc7_.y)));
            this.pathDirections.push(Math.atan2(this.pathPositions[this.pathPositions.length - 1].y - this.pathPositions[this.pathPositions.length - 2].y,this.pathPositions[this.pathPositions.length - 1].x - this.pathPositions[this.pathPositions.length - 2].x));
            _loc6_++;
         }
         _loc5_ = Math.ceil(_loc1_ * 2 * (Math.PI - _loc2_) / this.speed);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc6_ / _loc5_;
            _loc10_ = Math.PI - _loc2_ + -_loc9_ * 2 * (Math.PI - _loc2_);
            this.pathPositions.push(new Vector2(Math.cos(_loc10_) * _loc1_ + this.base.x + _loc4_,Math.sin(_loc10_) * _loc1_ + this.base.y));
            this.pathDirections.push(Math.atan2(this.pathPositions[this.pathPositions.length - 1].y - this.pathPositions[this.pathPositions.length - 2].y,this.pathPositions[this.pathPositions.length - 1].x - this.pathPositions[this.pathPositions.length - 2].x));
            _loc6_++;
         }
         _loc5_ = Math.ceil(2 * _loc3_ / this.speed);
         _loc7_.x = Math.cos(-Math.PI / 2 + _loc2_) * _loc3_ + this.base.x;
         _loc7_.y = Math.sin(-Math.PI / 2 + _loc2_) * _loc3_ + this.base.y;
         _loc8_.x = Math.cos(Math.PI / 2 + _loc2_) * _loc3_ + this.base.x;
         _loc8_.y = Math.sin(Math.PI / 2 + _loc2_) * _loc3_ + this.base.y;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc6_ / _loc5_;
            this.pathPositions.push(new Vector2(_loc7_.x + _loc9_ * (_loc8_.x - _loc7_.x),_loc7_.y + _loc9_ * (_loc8_.y - _loc7_.y)));
            this.pathDirections.push(Math.atan2(this.pathPositions[this.pathPositions.length - 1].y - this.pathPositions[this.pathPositions.length - 2].y,this.pathPositions[this.pathPositions.length - 1].x - this.pathPositions[this.pathPositions.length - 2].x));
            _loc6_++;
         }
         this.pathDirections.unshift(Math.atan2(this.pathPositions[0].y - this.pathPositions[this.pathPositions.length - 1].y,this.pathPositions[0].x - this.pathPositions[this.pathPositions.length - 1].x));
      }
      
      private function createVerticalPath() : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         this.onPath = false;
         this.pathPositions = new Vector.<Vector2>();
         this.pathDirections = new Vector.<Number>();
         var _loc1_:Number = this.smallRadius;
         var _loc2_:Number = 0.5;
         var _loc3_:Number = Math.tan(_loc2_) * _loc1_;
         var _loc4_:Number = Math.sin(_loc2_) * _loc3_ + Math.cos(_loc2_) * _loc1_;
         var _loc5_:Number = Math.ceil(_loc1_ * 2 * (Math.PI - _loc2_) / this.speed);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc6_ / _loc5_;
            _loc10_ = _loc9_ * 2 * (Math.PI - _loc2_) - Math.PI / 2 + _loc2_;
            this.pathPositions.push(new Vector2(Math.cos(_loc10_) * _loc1_ + this.base.x,Math.sin(_loc10_) * _loc1_ + this.base.y + _loc4_));
            if(_loc6_ != 0)
            {
               this.pathDirections.push(Math.atan2(this.pathPositions[_loc6_].y - this.pathPositions[_loc6_ - 1].y,this.pathPositions[_loc6_].x - this.pathPositions[_loc6_ - 1].x));
            }
            _loc6_++;
         }
         _loc5_ = Math.ceil(2 * _loc3_ / this.speed);
         var _loc7_:Vector2 = new Vector2();
         _loc7_.x = Math.cos(Math.PI - _loc2_) * _loc3_ + this.base.x;
         _loc7_.y = Math.sin(Math.PI - _loc2_) * _loc3_ + this.base.y;
         var _loc8_:Vector2 = new Vector2();
         _loc8_.x = Math.cos(-_loc2_) * _loc3_ + this.base.x;
         _loc8_.y = Math.sin(-_loc2_) * _loc3_ + this.base.y;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc6_ / _loc5_;
            this.pathPositions.push(new Vector2(_loc7_.x + _loc9_ * (_loc8_.x - _loc7_.x),_loc7_.y + _loc9_ * (_loc8_.y - _loc7_.y)));
            this.pathDirections.push(Math.atan2(this.pathPositions[this.pathPositions.length - 1].y - this.pathPositions[this.pathPositions.length - 2].y,this.pathPositions[this.pathPositions.length - 1].x - this.pathPositions[this.pathPositions.length - 2].x));
            _loc6_++;
         }
         _loc5_ = Math.ceil(_loc1_ * 2 * (Math.PI - _loc2_) / this.speed);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc6_ / _loc5_;
            _loc10_ = Math.PI / 2 - _loc2_ + -_loc9_ * 2 * (Math.PI - _loc2_);
            this.pathPositions.push(new Vector2(Math.cos(_loc10_) * _loc1_ + this.base.x,Math.sin(_loc10_) * _loc1_ + this.base.y - _loc4_));
            this.pathDirections.push(Math.atan2(this.pathPositions[this.pathPositions.length - 1].y - this.pathPositions[this.pathPositions.length - 2].y,this.pathPositions[this.pathPositions.length - 1].x - this.pathPositions[this.pathPositions.length - 2].x));
            _loc6_++;
         }
         _loc5_ = Math.ceil(2 * _loc3_ / this.speed);
         _loc7_.x = Math.cos(Math.PI + _loc2_) * _loc3_ + this.base.x;
         _loc7_.y = Math.sin(Math.PI + _loc2_) * _loc3_ + this.base.y;
         _loc8_.x = Math.cos(_loc2_) * _loc3_ + this.base.x;
         _loc8_.y = Math.sin(_loc2_) * _loc3_ + this.base.y;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc6_ / _loc5_;
            this.pathPositions.push(new Vector2(_loc7_.x + _loc9_ * (_loc8_.x - _loc7_.x),_loc7_.y + _loc9_ * (_loc8_.y - _loc7_.y)));
            this.pathDirections.push(Math.atan2(this.pathPositions[this.pathPositions.length - 1].y - this.pathPositions[this.pathPositions.length - 2].y,this.pathPositions[this.pathPositions.length - 1].x - this.pathPositions[this.pathPositions.length - 2].x));
            _loc6_++;
         }
         this.pathDirections.unshift(Math.atan2(this.pathPositions[0].y - this.pathPositions[this.pathPositions.length - 1].y,this.pathPositions[0].x - this.pathPositions[this.pathPositions.length - 1].x));
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.drawRotated(param1,x,y,rotation);
      }
      
      public function copy(param1:AceAircraft) : void
      {
         this.pathDirections = param1.pathDirections;
         this.pathPositions = param1.pathPositions;
         this.pathIndex = param1.pathIndex;
         this.pathType = param1.pathType;
         this.onPath = param1.onPath;
         x = param1.x;
         y = param1.y;
         rotation = param1.rotation;
      }
   }
}
