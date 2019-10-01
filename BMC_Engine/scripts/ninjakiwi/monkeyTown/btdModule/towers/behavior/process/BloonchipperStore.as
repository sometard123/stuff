package ninjakiwi.monkeyTown.btdModule.towers.behavior.process
{
   import fl.motion.BezierSegment;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.bloons.TrappedBloon;
   import ninjakiwi.monkeyTown.btdModule.entities.BloonPull;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class BloonchipperStore extends BehaviorProcess
   {
      
      public static var store:Dictionary = new Dictionary();
      
      public static var hasSuckedStore:Dictionary = new Dictionary();
       
      
      private var maxBloons_:int = 10;
      
      private var damage_:int = 1;
      
      private var chipTime_:Number = 1;
      
      private var vec:Vector2;
      
      public function BloonchipperStore()
      {
         this.vec = new Vector2();
         super();
      }
      
      public static function returnAll(param1:Tower) : void
      {
         var _loc2_:TrappedBloon = null;
         while(store[param1] != null && store[param1].length > 0)
         {
            _loc2_ = store[param1][0];
            _loc2_.bloon.isMoving = true;
            _loc2_.bloon.immunity = _loc2_.immunity;
            store[param1].splice(store[param1].indexOf(_loc2_),1);
         }
      }
      
      public function set maxBloons(param1:int) : void
      {
         if(this.maxBloons_ != param1)
         {
            this.maxBloons_ = param1;
            dispatchEvent(new PropertyModEvent("maxBloons"));
         }
      }
      
      public function get maxBloons() : int
      {
         return this.maxBloons_;
      }
      
      public function MaxBloons(param1:int) : BloonchipperStore
      {
         this.maxBloons = param1;
         return this;
      }
      
      public function set damage(param1:int) : void
      {
         if(this.damage_ != param1)
         {
            this.damage_ = param1;
            dispatchEvent(new PropertyModEvent("damage"));
         }
      }
      
      public function get damage() : int
      {
         return this.damage_;
      }
      
      public function Damage(param1:int) : BloonchipperStore
      {
         this.damage = param1;
         return this;
      }
      
      public function set chipTime(param1:Number) : void
      {
         if(this.chipTime_ != param1)
         {
            this.chipTime_ = param1;
            dispatchEvent(new PropertyModEvent("chipTime"));
         }
      }
      
      public function get chipTime() : Number
      {
         return this.chipTime_;
      }
      
      public function ChipTime(param1:Number) : BloonchipperStore
      {
         this.chipTime = param1;
         return this;
      }
      
      public function addBloon(param1:Tower, param2:Bloon) : TrappedBloon
      {
         if(store[param1] == null)
         {
            store[param1] = new Vector.<TrappedBloon>();
         }
         if(hasSuckedStore[param1] == null)
         {
            hasSuckedStore[param1] = new Vector.<uint>();
         }
         var _loc3_:TrappedBloon = BloonPull.getTrapped(param2);
         if(_loc3_ == null)
         {
            _loc3_ = new TrappedBloon();
            _loc3_.bloon = param2;
            _loc3_.originX = param2.x;
            _loc3_.originY = param2.y;
         }
         else
         {
            BloonPull.store.splice(BloonPull.store.indexOf(_loc3_),1);
         }
         _loc3_.ejectTime = 0;
         _loc3_.pathTime = 0;
         _loc3_.fromX = param2.x;
         _loc3_.fromY = param2.y;
         _loc3_.chipEvery = this.chipTime;
         if(param2.isMOAB)
         {
            _loc3_.damage = 200;
            _loc3_.popCount = 3;
            if(this.chipTime < 1)
            {
               _loc3_.chipEvery = 0.8;
            }
         }
         _loc3_.immunity = param2.immunity;
         param2.isMoving = false;
         param2.immunity = Bloon.IMMUNITY_ALL;
         store[param1].push(_loc3_);
         hasSuckedStore[param1].push(param2.lifetimeID);
         return _loc3_;
      }
      
      public function canSuck(param1:Tower, param2:Bloon) : Boolean
      {
         if(hasSuckedStore[param1] == null)
         {
            return true;
         }
         if(param2.immunity == Bloon.IMMUNITY_ALL)
         {
            return false;
         }
         if(store[param1] == null)
         {
            if(store[param1].length >= this.maxBloons)
            {
               return false;
            }
         }
         var _loc3_:Vector.<uint> = hasSuckedStore[param1];
         if(_loc3_.indexOf(param2.lifetimeID) != -1)
         {
            return false;
         }
         return true;
      }
      
      override public function process(param1:Tower, param2:Number) : void
      {
         var _loc5_:TrappedBloon = null;
         var _loc6_:TrappedBloon = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Bloon = null;
         var _loc10_:TrappedBloon = null;
         var _loc11_:int = 0;
         var _loc3_:Vector.<TrappedBloon> = BloonchipperStore.store[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Vector.<TrappedBloon> = new Vector.<TrappedBloon>();
         for each(_loc5_ in _loc3_)
         {
            if(_loc5_.bloon.type == -1)
            {
               _loc4_.push(_loc5_);
            }
            else
            {
               if(_loc5_.pathTime <= 0.8 && _loc5_.ejectTime <= 0)
               {
                  _loc5_.pathTime = _loc5_.pathTime + param2;
                  _loc5_.bloon.x = _loc5_.fromX + (param1.x - _loc5_.fromX) * (_loc5_.pathTime / 0.8);
                  _loc5_.bloon.y = _loc5_.fromY + (param1.y - _loc5_.fromY) * (_loc5_.pathTime / 0.8);
               }
               else
               {
                  _loc5_.bloon.x = param1.x;
                  _loc5_.bloon.y = param1.y;
               }
               if(_loc5_.ejectTime <= 0.8 && _loc5_.ejectTime > 0)
               {
                  _loc5_.ejectTime = _loc5_.ejectTime + param2;
                  _loc5_.bloon.x = _loc5_.ejectPath.getValue(_loc5_.ejectTime / 0.8).x;
                  _loc5_.bloon.y = _loc5_.ejectPath.getValue(_loc5_.ejectTime / 0.8).y;
               }
               else if(_loc5_.ejectTime > 0)
               {
                  _loc4_.push(_loc5_);
               }
               else
               {
                  _loc5_.chipTime = _loc5_.chipTime + param2;
                  if(_loc5_.chipTime >= _loc5_.chipEvery)
                  {
                     _loc7_ = param1.level.bloons.length;
                     _loc5_.bloon.damage(_loc5_.damage,1,param1,false);
                     _loc8_ = _loc7_;
                     while(_loc8_ < param1.level.bloons.length)
                     {
                        _loc9_ = param1.level.bloons[_loc8_];
                        _loc10_ = this.addBloon(param1,_loc9_);
                        _loc10_.originX = _loc5_.originX;
                        _loc10_.originY = _loc5_.originY;
                        _loc10_.ejectTime = _loc10_.ejectTime + param2 * 5;
                        this.vec.x = 250;
                        this.vec.y = 0;
                        this.vec.rotateBy(param1.rotation);
                        _loc10_.ejectPath = new BezierSegment(new Point(param1.x,param1.y),new Point(param1.x - this.vec.x,param1.y - this.vec.y),new Point(_loc5_.originX,_loc5_.originY),new Point(_loc5_.originX,_loc5_.originY));
                        _loc8_++;
                     }
                     _loc5_.chipTime = 0;
                     if(_loc5_.bloon.type == -1)
                     {
                        _loc4_.push(_loc5_);
                     }
                     else
                     {
                        _loc5_.popCount--;
                        if(_loc5_.popCount <= 0)
                        {
                           _loc5_.ejectTime = _loc5_.ejectTime + param2;
                           this.vec.x = 250;
                           this.vec.y = 0;
                           this.vec.rotateBy(param1.rotation);
                           _loc5_.ejectPath = new BezierSegment(new Point(param1.x,param1.y),new Point(param1.x - this.vec.x,param1.y - this.vec.y),new Point(_loc5_.originX,_loc5_.originY),new Point(_loc5_.originX,_loc5_.originY));
                        }
                     }
                  }
               }
            }
         }
         for each(_loc6_ in _loc4_)
         {
            _loc6_.bloon.isMoving = true;
            _loc6_.bloon.immunity = _loc6_.immunity;
            if(hasSuckedStore[param1] != null)
            {
               _loc11_ = hasSuckedStore[param1].indexOf(_loc6_.bloon.lifetimeID);
               if(_loc11_ != -1)
               {
                  hasSuckedStore[param1].splice(_loc11_,1);
               }
            }
            _loc3_.splice(_loc3_.indexOf(_loc6_),1);
         }
      }
   }
}
