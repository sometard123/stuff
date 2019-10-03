package ninjakiwi.monkeyTown.btdModule.entities
{
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.bloons.TrappedBloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class BloonPull extends Entity
   {
      
      public static var store:Vector.<TrappedBloon> = new Vector.<TrappedBloon>();
       
      
      private var vec:Vector2;
      
      public function BloonPull()
      {
         this.vec = new Vector2();
         super();
      }
      
      public static function getTrapped(param1:Bloon) : TrappedBloon
      {
         var _loc2_:TrappedBloon = null;
         for each(_loc2_ in store)
         {
            if(_loc2_.bloon == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function initialise(param1:Tower) : void
      {
         var tile:Vector.<Bloon> = null;
         var t:GameSpeedTimer = null;
         var bloon:Bloon = null;
         var distance2:Number = NaN;
         var tower:Tower = param1;
         var tiles:Vector.<Vector.<Bloon>> = tower.level.collisionGrid.getCellsInRange(tower.x,tower.y,tower.def.rangeOfVisibility);
         var range2:Number = Math.pow(tower.def.rangeOfVisibility,2);
         for each(tile in tiles)
         {
            for each(bloon in tile)
            {
               if(!(bloon.isInTunnel || bloon.immunity == Bloon.IMMUNITY_ALL))
               {
                  distance2 = (bloon.x - tower.x) * (bloon.x - tower.x) + (bloon.y - tower.y) * (bloon.y - tower.y);
                  if(distance2 <= range2)
                  {
                     this.addBloon(tower,bloon);
                  }
               }
            }
         }
         t = new GameSpeedTimer(5,1);
         t.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            var _loc3_:TrappedBloon = null;
            for each(_loc3_ in BloonPull.store)
            {
               _loc3_.ejectTime = 0.01;
            }
            t.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
         });
      }
      
      public function addBloon(param1:Tower, param2:Bloon) : TrappedBloon
      {
         var _loc3_:TrappedBloon = null;
         _loc3_ = new TrappedBloon();
         _loc3_.bloon = param2;
         _loc3_.immunity = param2.immunity;
         _loc3_.originX = param2.x;
         _loc3_.originY = param2.y;
         this.vec.x = 50 + (param1.def.rangeOfVisibility - 50) * Rndm.random();
         this.vec.y = 0;
         this.vec.rotateBy(Rndm.random() * Math.PI * 2);
         _loc3_.toX = param1.x + this.vec.x;
         _loc3_.toY = param1.y + this.vec.y;
         param2.isMoving = false;
         BloonPull.store.push(_loc3_);
         return _loc3_;
      }
      
      override public function process(param1:Number) : void
      {
         var _loc4_:TrappedBloon = null;
         var _loc5_:TrappedBloon = null;
         var _loc2_:Vector.<TrappedBloon> = BloonPull.store;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Vector.<TrappedBloon> = new Vector.<TrappedBloon>();
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.bloon.type == -1)
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               if(_loc4_.pathTime <= 0.8 && _loc4_.ejectTime <= 0)
               {
                  _loc4_.pathTime = _loc4_.pathTime + param1;
                  _loc4_.bloon.x = _loc4_.originX + (_loc4_.toX - _loc4_.originX) * (_loc4_.pathTime / 0.8);
                  _loc4_.bloon.y = _loc4_.originY + (_loc4_.toY - _loc4_.originY) * (_loc4_.pathTime / 0.8);
               }
               else
               {
                  _loc4_.bloon.x = _loc4_.toX;
                  _loc4_.bloon.y = _loc4_.toY;
                  if(Rndm.random() < 0.03)
                  {
                     _loc4_.dir.x = Rndm.random() * 2 - 1;
                     _loc4_.dir.y = Rndm.random() * 2 - 1;
                  }
                  _loc4_.toX = _loc4_.toX + _loc4_.dir.x;
                  _loc4_.toY = _loc4_.toY + _loc4_.dir.y;
               }
               if(_loc4_.ejectTime <= 0.8 && _loc4_.ejectTime > 0)
               {
                  _loc4_.ejectTime = _loc4_.ejectTime + param1;
                  _loc4_.bloon.x = _loc4_.toX + (_loc4_.originX - _loc4_.toX) * (_loc4_.ejectTime / 0.8);
                  _loc4_.bloon.y = _loc4_.toY + (_loc4_.originY - _loc4_.toY) * (_loc4_.ejectTime / 0.8);
               }
               else if(_loc4_.ejectTime > 0)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         for each(_loc5_ in _loc3_)
         {
            _loc5_.bloon.isMoving = true;
            _loc5_.bloon.immunity = _loc5_.immunity;
            _loc2_.splice(_loc2_.indexOf(_loc5_),1);
         }
      }
   }
}
