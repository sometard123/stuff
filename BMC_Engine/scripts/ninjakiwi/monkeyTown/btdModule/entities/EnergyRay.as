package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.effects.VillageEffect;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class EnergyRay extends Entity
   {
      
      public static var target:Dictionary = new Dictionary();
       
      
      private var lightningClipOut:MovieClip;
      
      private var lightningClip:MovieClip = null;
      
      private var litBloons:Vector.<Bloon>;
      
      private var offset:Vector2 = null;
      
      private var dim:Boolean = false;
      
      private var targetX:Number = 0;
      
      private var targetY:Number = 0;
      
      private var owner:Tower = null;
      
      public function EnergyRay()
      {
         this.lightningClipOut = new VillageEffect();
         this.litBloons = new Vector.<Bloon>();
         super();
      }
      
      public function initialise(param1:Tower, param2:Vector2, param3:Bloon) : void
      {
         EnergyRay.target[param1] = param3;
         this.offset = param2;
         this.lightningClip = this.lightningClipOut.inner;
         this.lightningClip.scaleX = Main.instance.scale;
         this.lightningClip.scaleY = Main.instance.scale;
         this.owner = param1;
         z = 55;
      }
      
      override public function process(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this.owner.def == null)
         {
            destroy();
            return;
         }
         if(target[this.owner] != null)
         {
            this.targetX = target[this.owner].x;
            this.targetY = target[this.owner].y;
         }
         if(!this.dim)
         {
            this.lightningClip.graphics.clear();
            this.lightningClip.graphics.lineStyle(2,16777215,1);
            this.lightningClip.graphics.moveTo(this.owner.x + this.offset.x,this.owner.y + this.offset.y);
            _loc2_ = 0.2;
            while(_loc2_ <= 0.8)
            {
               this.lightningClip.graphics.lineTo(this.owner.x + this.offset.x + (this.targetX - (this.owner.x + this.offset.x)) * _loc2_ + Rndm.random() * 40 - 20,this.owner.y + this.offset.y + (this.targetY - (this.owner.y + this.offset.y)) * _loc2_ + Rndm.random() * 40 - 20);
               _loc2_ = _loc2_ + 0.2;
            }
            this.lightningClip.graphics.lineTo(this.targetX,this.targetY);
            if(Math.pow(target[this.owner].x - this.owner.x,2) + Math.pow(target[this.owner].y - this.owner.y,2) > Math.pow(this.owner.def.rangeOfVisibility + 100,2))
            {
               target[this.owner] = null;
               delete target[this.owner];
            }
            if(target[this.owner] == null)
            {
               this.dim = true;
               return;
            }
            if(target[this.owner].type != -1)
            {
               target[this.owner].damage(2,1.5,this.owner);
            }
            if(target[this.owner].type == -1)
            {
               target[this.owner] = null;
               delete target[this.owner];
               this.dim = true;
               return;
            }
            return;
         }
         this.lightningClip.alpha = this.lightningClip.alpha - param1 * 4;
         if(this.lightningClip.alpha <= 0)
         {
            destroy();
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         param1.draw(this.lightningClipOut);
      }
   }
}
