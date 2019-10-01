package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.effects.LightningEffect;
   import assets.sound.LightningBoltApprentice;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.PurgeRegenChanceLightning;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class Lightning extends Entity
   {
       
      
      private var lightningClipOut:MovieClip;
      
      private var lightningClip:MovieClip = null;
      
      private var litBloons:Vector.<Bloon>;
      
      private var owner:Tower = null;
      
      public function Lightning()
      {
         this.lightningClipOut = new LightningEffect();
         this.litBloons = new Vector.<Bloon>();
         super();
      }
      
      public function initialise(param1:Tower, param2:Bloon) : void
      {
         var p2:Vector2 = null;
         var p3:Vector2 = null;
         var tower:Tower = param1;
         var target:Bloon = param2;
         new MaxSound(LightningBoltApprentice).play();
         this.owner = tower;
         this.lightningClip = this.lightningClipOut.inner;
         this.lightningClip.graphics.lineStyle(5.28,16777215,1);
         this.lightningClip.scaleX = Main.instance.scale;
         this.lightningClip.scaleY = Main.instance.scale;
         this.lightningClip.graphics.moveTo(tower.x,tower.y);
         p2 = new Vector2(tower.x + (target.x - tower.x) * 0.33,tower.y + (target.y - tower.y) * 0.33);
         p2.x = p2.x + (Rndm.random() * 20 - 10);
         p2.y = p2.y + (Rndm.random() * 20 - 10);
         this.lightningClip.graphics.lineTo(p2.x,p2.y);
         p3 = new Vector2(tower.x + (target.x - tower.x) * 0.66,tower.y + (target.y - tower.y) * 0.66);
         p3.x = p3.x + (Rndm.random() * 20 - 10);
         p3.y = p3.y + (Rndm.random() * 20 - 10);
         this.lightningClip.graphics.lineTo(p3.x,p3.y);
         this.lightningClip.graphics.lineTo(target.x,target.y);
         var c:int = 0;
         while(c < 3)
         {
            this.path(target,4);
            c++;
         }
         var lifespan:GameSpeedTimer = new GameSpeedTimer(1);
         lifespan.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            destroy();
         });
         lifespan.start();
         z = 55;
      }
      
      private function drawLightning(param1:Number, param2:Number, param3:Number, param4:Number, param5:int) : void
      {
         this.lightningClip.graphics.lineStyle(param5 * param5 * 0.33,16777215,1);
         this.lightningClip.graphics.moveTo(param1,param2);
         var _loc6_:Vector2 = new Vector2(param3 - param1,param4 - param2);
         var _loc7_:Number = _loc6_.magnitude;
         var _loc8_:Number = 15 * param5;
         var _loc9_:int = _loc7_ / _loc8_;
         _loc6_.magnitude = 1;
         var _loc10_:int = 1;
         while(_loc10_ < _loc9_)
         {
            this.lightningClip.graphics.lineTo(param1 + _loc6_.x * _loc10_ * _loc8_ + Math.random() * 2.5 * _loc8_ - _loc8_,param2 + _loc6_.y * _loc10_ * _loc8_ + Math.random() * 2.5 * _loc8_ - _loc8_);
            _loc10_++;
         }
         this.lightningClip.graphics.lineTo(param3,param4);
      }
      
      public function path(param1:Bloon, param2:int) : void
      {
         var i:int = 0;
         var buff:Buff = null;
         var from:Bloon = param1;
         var depth:int = param2;
         var purgeRegenChance:Number = 0;
         if(from.isRegen)
         {
            i = 0;
            while(i < this.owner.buffs.length)
            {
               buff = this.owner.buffs[i];
               if(PurgeRegenChanceLightning == buff.buffMethodModuleClass)
               {
                  purgeRegenChance = purgeRegenChance + buff.buffValue;
               }
               i++;
            }
         }
         if(this.litBloons.indexOf(from) == -1)
         {
            if(from.type != -1)
            {
               from.damage(1,1,this.owner);
               if(purgeRegenChance != 0)
               {
                  if(Rndm.float(0,1) < purgeRegenChance)
                  {
                     from.purgeRegen();
                  }
               }
            }
            this.litBloons.push(from);
         }
         if(depth <= 0)
         {
            return;
         }
         var lifespan:GameSpeedTimer = new GameSpeedTimer(0.05);
         lifespan.extra = {
            "from":from,
            "x":from.x,
            "y":from.y
         };
         lifespan.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            var _loc2_:Number = (param1.target as GameSpeedTimer).extra.x;
            var _loc3_:Number = (param1.target as GameSpeedTimer).extra.y;
            var _loc4_:Bloon = closestBloon(_loc2_,_loc3_);
            if(_loc4_ == null)
            {
               return;
            }
            drawLightning(_loc2_,_loc3_,_loc4_.x,_loc4_.y,depth);
            path(_loc4_,--depth);
            var _loc5_:int = 0;
            while(_loc5_ < 3)
            {
               path(_loc4_,--depth);
               _loc5_++;
            }
         });
         lifespan.start();
      }
      
      public function closestBloon(param1:Number, param2:Number) : Bloon
      {
         if(this.owner == null || this.owner.level == null || this.owner.level.bloons == null || this.owner.level.bloons.length == 0)
         {
            return null;
         }
         var _loc3_:Vector.<Bloon> = this.owner.level.collisionGrid.getTargetsInRange(new Vector2(param1,param2),200,this.owner.targetMask,-1,this.litBloons);
         if(_loc3_.length == 0)
         {
            return null;
         }
         return _loc3_[int(_loc3_.length * Rndm.random())];
      }
      
      override public function process(param1:Number) : void
      {
         this.lightningClip.alpha = this.lightningClip.alpha - param1;
      }
      
      override public function draw(param1:BitmapData) : void
      {
         param1.draw(this.lightningClipOut);
      }
   }
}
