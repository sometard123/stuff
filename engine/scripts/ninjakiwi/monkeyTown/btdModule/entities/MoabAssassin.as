package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.projectile.MOABAssassinPower;
   import assets.projectile.NuclearExplosion;
   import display.BloonClip;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class MoabAssassin extends Entity
   {
       
      
      private var tower:Tower = null;
      
      private var harpoonClip:Clip;
      
      private var harpoonX:Number = 0;
      
      private var harpoonY:Number = 0;
      
      private var bloonClip:BloonClip = null;
      
      private var bloonX:Number = 0;
      
      private var bloonY:Number = 0;
      
      private var bloonOriginX:Number = 0;
      
      private var bloonOriginY:Number = 0;
      
      private var animationTimer:GameSpeedTimer;
      
      private var splitTimeAt:Number = 0.1;
      
      private var angle:Number = 0;
      
      private var rope:MovieClip;
      
      private var bloonRotation:Number = 0;
      
      private var bloonType:int = 0;
      
      public function MoabAssassin()
      {
         this.harpoonClip = new Clip();
         this.animationTimer = new GameSpeedTimer(0.4);
         this.rope = new MovieClip();
         super();
      }
      
      public function initialise(param1:Tower, param2:Bloon) : void
      {
         var tower:Tower = param1;
         var bloon:Bloon = param2;
         this.tower = tower;
         this.harpoonClip.initialise(MOABAssassinPower,64);
         this.bloonX = bloon.x;
         this.bloonY = bloon.y;
         this.bloonOriginX = bloon.x;
         this.bloonOriginY = bloon.y;
         this.bloonRotation = bloon.rotation;
         this.bloonType = bloon.type;
         if(bloon.type == Bloon.BOSS)
         {
            bloon.damage(750,1,null,true);
         }
         else if(bloon.isBoss)
         {
            bloon.damage(375,1,null,true);
         }
         else
         {
            this.bloonClip = new BloonClip();
            this.bloonClip.setFrame(bloon.type,bloon.health);
            bloon.degrade(1,1,tower,false);
         }
         var to:Vector2 = new Vector2(bloon.x - tower.x,bloon.y - tower.y);
         this.angle = to.rotation;
         this.animationTimer.start();
         this.animationTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            var _loc4_:Projectile = null;
            var _loc3_:ProjectileDef = new ProjectileDef().Display(NuclearExplosion).Pierce(40).Radius(60).DamageEffect(new DamageEffectDef().Damage(3).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.ZEBRA])));
            _loc4_ = Pool.get(Projectile);
            _loc4_.initialise(_loc3_,tower.level,tower.buffs,null);
            _loc4_.owner = tower;
            _loc4_.x = bloonOriginX;
            _loc4_.y = bloonOriginY;
            tower.level.addProjectile(_loc4_);
            _loc4_.lifespan = 0.1;
            destroy();
            animationTimer.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
         });
         z = 1;
      }
      
      override public function process(param1:Number) : void
      {
         var _loc2_:Number = this.animationTimer.current / this.animationTimer.delay;
         this.harpoonX = this.tower.x + (this.bloonX - this.tower.x) * _loc2_;
         this.harpoonY = this.tower.y + (this.bloonY - this.tower.y) * _loc2_;
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this.bloonClip == null)
         {
            return;
         }
         if(this.bloonType < Bloon.MOAB)
         {
            this.bloonClip.quickDraw(param1,this.bloonX,this.bloonY);
         }
         else
         {
            this.bloonClip.drawRotated(param1,this.bloonX,this.bloonY,this.bloonRotation);
         }
         this.harpoonClip.drawRotated(param1,this.harpoonX,this.harpoonY,this.angle);
      }
   }
}
