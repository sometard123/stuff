package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.projectile.BombAce;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.CubicBezier;
   import ninjakiwi.monkeyTown.btdModule.math.CubicBezierDef;
   import ninjakiwi.monkeyTown.btdModule.math.SmoothPath;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasReloadTime;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class AircraftCarrierAircraft extends Entity
   {
       
      
      private var animationTimer:GameSpeedTimer;
      
      private var clip:Clip;
      
      private var smoothPath:SmoothPath = null;
      
      private var at:Vector2;
      
      private var to:Vector2;
      
      private var weapon:Vector.<Weapon> = null;
      
      private var weaponTimers:Vector.<GameSpeedTimer> = null;
      
      private var tower:Tower = null;
      
      private var offest1:Vector2;
      
      private var offest2:Vector2;
      
      public function AircraftCarrierAircraft()
      {
         this.animationTimer = new GameSpeedTimer(6);
         this.clip = new Clip();
         this.at = new Vector2();
         this.to = new Vector2();
         this.offest1 = new Vector2(0,-8);
         this.offest2 = new Vector2(0,8);
         super();
      }
      
      public function initialise(param1:Tower, param2:Entity, param3:Vector.<Weapon>) : void
      {
         var w:Weapon = null;
         var t:GameSpeedTimer = null;
         var tower:Tower = param1;
         var target:Entity = param2;
         var weapons:Vector.<Weapon> = param3;
         if(target == null)
         {
            return;
         }
         this.weapon = weapons;
         this.tower = tower;
         this.clip.initialise(BombAce,32);
         this.animationTimer.start();
         this.animationTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            destroy();
            animationTimer.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
         });
         this.to.x = -(target.y - tower.y);
         this.to.y = target.x - tower.x;
         this.to.magnitude = 100;
         var rightSideDef:CubicBezierDef = null;
         var leftSideDef:CubicBezierDef = null;
         if(target.y < tower.y)
         {
            rightSideDef = new CubicBezierDef().A(new Vector2(tower.x,tower.y)).B(new Vector2(tower.x + 400,tower.y - 100)).C(new Vector2(target.x + this.to.x,target.y + this.to.y)).D(new Vector2(target.x,target.y));
            leftSideDef = new CubicBezierDef().A(new Vector2(target.x,target.y)).B(new Vector2(target.x - this.to.x,target.y - this.to.y)).C(new Vector2(tower.x - 400,tower.y)).D(new Vector2(tower.x,tower.y));
         }
         else
         {
            rightSideDef = new CubicBezierDef().A(new Vector2(tower.x,tower.y)).B(new Vector2(tower.x + 400,tower.y + 100)).C(new Vector2(target.x - this.to.x,target.y - this.to.y)).D(new Vector2(target.x,target.y));
            leftSideDef = new CubicBezierDef().A(new Vector2(target.x,target.y)).B(new Vector2(target.x + this.to.x,target.y + this.to.y)).C(new Vector2(tower.x - 400,tower.y)).D(new Vector2(tower.x,tower.y));
         }
         var rightSide:CubicBezier = new CubicBezier();
         rightSide.initialise(rightSideDef);
         var leftSide:CubicBezier = new CubicBezier();
         leftSide.initialise(leftSideDef);
         this.smoothPath = new SmoothPath();
         this.smoothPath.initialise(Vector.<CubicBezier>([rightSide,leftSide]));
         this.weaponTimers = new Vector.<GameSpeedTimer>();
         for each(w in weapons)
         {
            t = new GameSpeedTimer((w as HasReloadTime).reloadTime);
            t.start();
            this.weaponTimers.push(t);
         }
         z = 50;
      }
      
      override public function process(param1:Number) : void
      {
         var _loc3_:GameSpeedTimer = null;
         var _loc4_:Vector2 = null;
         if(!this.smoothPath)
         {
            return;
         }
         this.smoothPath.getTransformedValue(this.animationTimer.current / this.animationTimer.delay,this.at,0,0,0);
         this.to.x = this.at.x - x;
         this.to.y = this.at.y - y;
         rotation = this.to.rotation;
         x = this.at.x;
         y = this.at.y;
         var _loc2_:int = 0;
         for each(_loc3_ in this.weaponTimers)
         {
            if(!_loc3_.running)
            {
               _loc4_ = null;
               if(_loc2_ == 1)
               {
                  _loc4_ = this.offest1;
               }
               else if(_loc2_ == 2)
               {
                  _loc4_ = this.offest2;
               }
               this.weapon[_loc2_].execute(this.tower,this,null,_loc4_);
               _loc3_.reset();
            }
            _loc2_++;
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(!this.clip || !param1 || !this.clip.frames)
         {
            return;
         }
         this.clip.drawRotated(param1,x,y,rotation);
      }
   }
}
