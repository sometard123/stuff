package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.gui.PopCash;
   import assets.projectile.MediumExplosion;
   import assets.towers.Bloontrap;
   import assets.towers.BloontrapBuild;
   import assets.towers.BloontrapExplode;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.btdModule.analytics.GameInfoTracking;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.CreateBloonTrap;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class BloonTrap extends Entity
   {
      
      private static var explosion:ProjectileDef = new ProjectileDef().Display(MediumExplosion).Pierce(40).Radius(60).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.ZEBRA])).ShowPop(false));
       
      
      public var tile:Tile;
      
      public var tileProgress:Number = 0;
      
      public var radius:Number = 32;
      
      public var radius2:Number;
      
      public var clip:Clip;
      
      public var rbeCount:Number = 0;
      
      public var maxRBE:Number = 250;
      
      public var velocity:Vector2;
      
      public var owner:Tower = null;
      
      public var cash:Number = 0;
      
      public var explodeTime:Number = 0;
      
      public var pauseDraw:Boolean = true;
      
      public function BloonTrap()
      {
         this.radius2 = this.radius * this.radius;
         this.clip = new Clip();
         this.velocity = new Vector2(20,0);
         super();
      }
      
      public function initialise(param1:Tile, param2:Number, param3:Tower) : void
      {
         var clipEffect:ClipEffect = null;
         var randomPoint:Vector2 = null;
         var tile:Tile = param1;
         var tileProgress:Number = param2;
         var owner:Tower = param3;
         this.owner = owner;
         this.clip.initialise(Bloontrap,0);
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.click);
         var trackPoints:Vector.<Vector2> = owner.level.getTrackPointsInRadius(new Vector2(owner.x,owner.y),owner.def.rangeOfVisibility);
         if(trackPoints.length != 0)
         {
            randomPoint = trackPoints[int(Rndm.random() * trackPoints.length)];
            x = randomPoint.x;
            y = randomPoint.y;
         }
         else
         {
            x = owner.x + Math.random() * 100 - 50;
            y = owner.y + Math.random() * 100 - 50;
         }
         rotation = Math.random() * Math.PI * 2;
         clipEffect = new ClipEffect();
         clipEffect.x = x;
         clipEffect.y = y;
         clipEffect.rotation = rotation;
         clipEffect.initialise(BloontrapBuild);
         Main.instance.game.level.addEntity(clipEffect);
         clipEffect.addEventListener(ClipEffect.DONE,function(param1:Event):void
         {
            pauseDraw = false;
            clipEffect.removeEventListener(ClipEffect.DONE,arguments.callee);
         });
         this.explodeTime = 0;
      }
      
      public function click(param1:MouseEvent) : void
      {
         var _loc2_:Vector2 = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(Main.instance.game.inGameMenu.inPlayArea() == false)
         {
            return;
         }
         if(this.rbeCount >= this.maxRBE)
         {
            _loc2_ = this.owner.level.getMousePos();
            _loc3_ = Math.pow(_loc2_.x - x,2) + Math.pow(_loc2_.y - y,2);
            if(_loc3_ < this.radius2)
            {
               _loc4_ = this.cash * 2;
               this.addCash(_loc4_);
               this.destroy();
            }
         }
      }
      
      private function addCash(param1:Number) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc2_:PopCash = new PopCash();
         _loc2_.x = x;
         _loc2_.y = y;
         _loc2_.mouseEnabled = false;
         _loc2_.mouseChildren = false;
         _loc2_.label.text = "$" + String(int(param1));
         Main.instance.game.inGameMenu.addChild(_loc2_);
         this.owner.level.addCash(param1);
         Main.instance.game.gameInfoTracking.cashEarned(param1,GameInfoTracking.CASH_TYPE_BLOON_TRAP);
      }
      
      public function completePath() : void
      {
         this.destroy();
      }
      
      override public function destroy() : void
      {
         if(CreateBloonTrap.hasTrap[this.owner] != null)
         {
            delete CreateBloonTrap.hasTrap[this.owner];
         }
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.click);
         super.destroy();
      }
      
      public function get isInTunnel() : Boolean
      {
         if(this.tile == null)
         {
            return false;
         }
         if(this.tile.transitionType == Tile.teleport)
         {
            return true;
         }
         if(this.tile.transitionType == Tile.underpass)
         {
            return true;
         }
         return false;
      }
      
      override public function process(param1:Number) : void
      {
         var _loc2_:Bloon = null;
         var _loc3_:Number = NaN;
         var _loc4_:Projectile = null;
         if(this.rbeCount < this.maxRBE)
         {
            for each(_loc2_ in this.owner.level.bloons)
            {
               if(!(_loc2_.isInTunnel || _loc2_.isHuge))
               {
                  _loc3_ = Math.pow(_loc2_.x - x,2) + Math.pow(_loc2_.y - y,2);
                  if(_loc3_ < this.radius2)
                  {
                     this.rbeCount = this.rbeCount + _loc2_.rbe;
                     this.cash = this.cash + _loc2_.getFullCashValue();
                     Game.bloonsPoppedThisGame = Game.bloonsPoppedThisGame + _loc2_.getPopValue();
                     _loc2_.destroy();
                     this.clip.gotoLabel("Fire");
                     this.clip.play();
                     if(this.rbeCount >= this.maxRBE)
                     {
                        this.clip.stop();
                        break;
                     }
                  }
               }
            }
         }
         else
         {
            if(this.clip.currentLabel == "Fire")
            {
               this.clip.initialise(BloontrapExplode,0);
               this.clip.gotoLabel("Loop");
               this.clip.looping = true;
               this.clip.play();
               z = 999;
               Main.instance.game.level.sortDrawList = true;
            }
            this.explodeTime = this.explodeTime + param1;
            if(this.explodeTime >= 5)
            {
               _loc4_ = Pool.get(Projectile);
               _loc4_.initialise(explosion,this.owner.level,this.owner.buffs,null);
               _loc4_.owner = this.owner;
               _loc4_.x = x;
               _loc4_.y = y;
               _loc4_.lifespan = 0.1;
               this.owner.level.addProjectile(_loc4_);
               this.addCash(this.cash);
               this.destroy();
            }
         }
         this.clip.process();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this.pauseDraw)
         {
            return;
         }
         if(!this.isInTunnel)
         {
            this.clip.quickDraw(param1,x,y);
         }
      }
   }
}
