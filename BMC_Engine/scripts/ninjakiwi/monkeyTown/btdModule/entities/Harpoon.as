package ninjakiwi.monkeyTown.btdModule.entities
{
   import assests.effects.BuccaneerHarpoonInitialBlast;
   import assests.effects.BuccaneerHarpoonSkullBlast;
   import assets.sound.GrapplingHookRetract;
   import assets.sounds.ExplosionHuge;
   import display.BloonClip;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class Harpoon extends Entity
   {
       
      
      private var tower:Tower = null;
      
      private var harpoonClip:Clip;
      
      private var harpoonX:Number = 0;
      
      private var harpoonY:Number = 0;
      
      private var bloonClip:BloonClip = null;
      
      private var bloonX:Number = 0;
      
      private var bloonY:Number = 0;
      
      private var bloonType:int = 0;
      
      private var bloonOriginX:Number = 0;
      
      private var bloonOriginY:Number = 0;
      
      private var animationTimer:GameSpeedTimer;
      
      private var splitTimeAt:Number = 0.1;
      
      private var angle:Number = 0;
      
      private var rope:MovieClip;
      
      private var bloonRotation:Number = 0;
      
      private var from:Vector2;
      
      private var bType:int = 0;
      
      public function Harpoon()
      {
         this.harpoonClip = new Clip();
         this.animationTimer = new GameSpeedTimer(3);
         this.rope = new MovieClip();
         this.from = new Vector2();
         super();
      }
      
      public function initialise(param1:Tower, param2:Bloon) : void
      {
         var rot:Vector2 = null;
         var mc:Effect = null;
         var retractTimer:GameSpeedTimer = null;
         var tower:Tower = param1;
         var bloon:Bloon = param2;
         this.tower = tower;
         this.harpoonClip.initialise(assets.projectile.Harpoon,64);
         this.bloonClip = new BloonClip();
         this.bloonClip.setFrame(bloon.type,bloon.health);
         this.bloonX = bloon.x;
         this.bloonY = bloon.y;
         this.bloonOriginX = bloon.x;
         this.bloonOriginY = bloon.y;
         this.bloonType = bloon.type;
         this.bloonRotation = bloon.rotation;
         this.bType = bloon.type;
         bloon.destroy();
         var to:Vector2 = new Vector2(bloon.x - tower.x,bloon.y - tower.y);
         this.angle = to.rotation;
         tower.rotation = this.angle + Math.PI / 2;
         tower.pause = true;
         tower.hideAddon = true;
         rot = new Vector2(-6,-44);
         rot.rotateBy(tower.rotation);
         mc = new Effect();
         mc.initialise(BuccaneerHarpoonInitialBlast,3);
         mc.x = tower.x + rot.x;
         mc.y = tower.y + rot.y;
         tower.level.addEntity(mc);
         rot = new Vector2(-6,-72);
         rot.rotateBy(tower.rotation);
         this.from.x = tower.x + rot.x;
         this.from.y = tower.y + rot.y;
         this.animationTimer.start();
         this.animationTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            var _loc3_:Effect = null;
            tower.pause = false;
            tower.hideAddon = false;
            new MaxSound(ExplosionHuge).play();
            _loc3_ = new Effect();
            _loc3_.initialise(BuccaneerHarpoonSkullBlast,3);
            _loc3_.x = from.x;
            _loc3_.y = from.y;
            tower.level.addEntity(_loc3_);
            destroy();
            animationTimer.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
         });
         retractTimer = new GameSpeedTimer(this.splitTimeAt);
         retractTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            new MaxSound(GrapplingHookRetract).play();
            retractTimer.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
         });
         z = 1;
      }
      
      override public function process(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this.animationTimer.current < this.splitTimeAt)
         {
            _loc2_ = this.animationTimer.current / this.splitTimeAt;
            this.harpoonX = this.from.x + (this.bloonX - this.from.x) * _loc2_;
            this.harpoonY = this.from.y + (this.bloonY - this.from.y) * _loc2_;
         }
         if(this.animationTimer.current > this.splitTimeAt)
         {
            _loc2_ = (this.animationTimer.current - this.splitTimeAt) / (this.animationTimer.delay - this.splitTimeAt);
            this.bloonX = this.bloonOriginX + (this.from.x - this.bloonOriginX) * _loc2_;
            this.bloonY = this.bloonOriginY + (this.from.y - this.bloonOriginY) * _loc2_;
            this.harpoonX = this.bloonX;
            this.harpoonY = this.bloonY;
         }
         this.rope.graphics.clear();
         this.rope.graphics.lineStyle(2,0);
         this.rope.graphics.moveTo(this.tower.x,this.tower.y);
         this.rope.graphics.lineTo(this.harpoonX,this.harpoonY);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         param1.draw(this.rope);
         if(Bloon.isHugeClass(this.bloonType))
         {
            this.bloonClip.drawRotated(param1,this.bloonX,this.bloonY,this.bloonRotation);
         }
         else
         {
            this.bloonClip.quickDraw(param1,this.bloonX,this.bloonY);
         }
         this.harpoonClip.drawRotated(param1,this.harpoonX,this.harpoonY,this.angle);
      }
   }
}
