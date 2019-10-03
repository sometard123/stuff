package ninjakiwi.monkeyTown.btdModule.entities
{
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class Bee extends Entity
   {
      
      protected static var rotationVector:Vector2 = new Vector2(26,-15);
      
      public static var bees:Vector.<ninjakiwi.monkeyTown.btdModule.entities.Bee> = new Vector.<ninjakiwi.monkeyTown.btdModule.entities.Bee>();
       
      
      protected var clip:Clip;
      
      protected var tower:Tower = null;
      
      public var target:Bloon = null;
      
      protected var popTimer:GameSpeedTimer;
      
      protected var distTemp:Vector2;
      
      protected var visible:Boolean = true;
      
      protected var offsetSpawn:Vector2;
      
      protected var offsetReturn:Vector2;
      
      public function Bee()
      {
         this.clip = new Clip();
         this.popTimer = new GameSpeedTimer(0.5);
         this.distTemp = new Vector2();
         this.offsetSpawn = new Vector2();
         this.offsetReturn = new Vector2();
         super();
      }
      
      public function initialise(param1:Tower, param2:Entity) : void
      {
         var b:ninjakiwi.monkeyTown.btdModule.entities.Bee = null;
         var i:int = 0;
         var t:Bloon = null;
         var tower:Tower = param1;
         var inTarget:Entity = param2;
         this.tower = tower;
         z = 2;
         if(tower.def.id == "Beekeeper")
         {
            this.offsetSpawn.x = 15;
            this.offsetSpawn.y = -15;
            this.offsetReturn.x = 26;
            this.offsetReturn.y = -15;
         }
         else if(tower.def.id == "BeekeeperPro")
         {
            this.offsetSpawn.x = -27;
            this.offsetSpawn.y = -5;
            this.offsetReturn.x = -27;
            this.offsetReturn.y = 8;
         }
         this.initClip();
         var newTarget:Bloon = null;
         i = tower.targetsByPriority.length - 1;
         loop0:
         while(i >= 0)
         {
            t = tower.targetsByPriority[i];
            do
            {
               for each(b in bees)
               {
               }
               if(t.type != -1 && t.iced == false && t.type != Bloon.LEAD && !t.isInTunnel)
               {
                  newTarget = t;
                  break loop0;
               }
               break;
            }
            while(b.target != t);
            
            i--;
         }
         this.target = newTarget;
         Bloon.eventDispatcher.addEventListener(BloonEvent.REMOVE,function(param1:BloonEvent):void
         {
            if(param1.bloon == target)
            {
               target = null;
               Bloon.eventDispatcher.removeEventListener(BloonEvent.REMOVE,arguments.callee);
            }
         });
         rotationVector.x = this.offsetSpawn.x;
         rotationVector.y = this.offsetSpawn.y;
         rotationVector.rotateBy(tower.rotation);
         x = tower.x + rotationVector.x;
         y = tower.y + rotationVector.y;
         var count:int = 0;
         for each(b in bees)
         {
            if(b.tower == tower)
            {
               count++;
            }
         }
         bees.push(this);
         this.popTimer.addEventListener(GameSpeedTimer.COMPLETE,this.popTarget);
         if(newTarget == null || count >= 6)
         {
            this.destroy();
         }
         else
         {
            this.distTemp.x = inTarget.x - x;
            this.distTemp.y = inTarget.y - y;
            tower.rotation = this.distTemp.rotation;
         }
      }
      
      protected function initClip() : void
      {
         this.clip.initialise(assets.projectile.Bee,64);
      }
      
      override public function destroy() : void
      {
         bees.splice(bees.indexOf(this),1);
         this.tower.level.cull(this);
         super.destroy();
      }
      
      public function popTarget(param1:Event) : void
      {
         if(this.target != null && this.target.type != -1)
         {
            this.target.damage(1,1,this.tower);
         }
         if(this.target == null || this.target.type == -1)
         {
            this.popTimer.removeEventListener(GameSpeedTimer.COMPLETE,this.popTarget);
            return;
         }
         this.popTimer.reset();
         this.popTimer.start();
      }
      
      override public function process(param1:Number) : void
      {
         if(this.target == null || this.target.type == -1 || this.target.iced)
         {
            rotationVector.x = this.offsetReturn.x;
            rotationVector.y = this.offsetReturn.y;
            rotationVector.rotateBy(this.tower.rotation);
            rotationVector.x = rotationVector.x + this.tower.x;
            rotationVector.y = rotationVector.y + this.tower.y;
            x = x + (rotationVector.x - x) / 6;
            y = y + (rotationVector.y - y) / 6;
            this.distTemp.x = rotationVector.x - x;
            this.distTemp.y = rotationVector.y - y;
            if(this.distTemp.magnitude <= 5)
            {
               this.destroy();
            }
            rotation = this.distTemp.rotation;
            this.target = null;
            return;
         }
         x = x + (this.target.x - x) / 3;
         y = y + (this.target.y - y) / 3;
         this.distTemp.x = this.target.x - x;
         this.distTemp.y = this.target.y - y;
         if(this.distTemp.magnitude <= this.target.radius)
         {
            x = this.target.x;
            y = this.target.y;
            this.visible = !this.target.isInTunnel;
         }
         rotation = this.distTemp.rotation;
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this.visible)
         {
            this.clip.drawRotated(param1,x,y,rotation);
         }
      }
   }
}
