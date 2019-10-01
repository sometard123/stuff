package ninjakiwi.monkeyTown.btdModule.weapons
{
   import assets.towers.EngineerSentryBuild;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.entities.ClipEffect;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class CreateSentry extends Standard
   {
       
      
      private var rotate_:Boolean = true;
      
      private var offsetTemp:Vector2;
      
      private var sentry_:String = null;
      
      public function CreateSentry(param1:String = null)
      {
         this.offsetTemp = new Vector2();
         super(param1);
      }
      
      public function Range(param1:Number) : CreateSentry
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : CreateSentry
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : CreateSentry
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : CreateSentry
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : CreateSentry
      {
         proxied = param1;
         return this;
      }
      
      public function RequiresTarget(param1:Boolean) : CreateSentry
      {
         requiresTarget = param1;
         return this;
      }
      
      public function set rotate(param1:Boolean) : void
      {
         if(this.rotate_ != param1)
         {
            this.rotate_ = param1;
            dispatchEvent(new PropertyModEvent("rotate"));
         }
      }
      
      public function get rotate() : Boolean
      {
         return this.rotate_;
      }
      
      public function Rotate(param1:Boolean) : CreateSentry
      {
         this.rotate = param1;
         return this;
      }
      
      public function set sentry(param1:String) : void
      {
         if(this.sentry_ != param1)
         {
            this.sentry_ = param1;
            dispatchEvent(new PropertyModEvent("sentry"));
         }
      }
      
      public function get sentry() : String
      {
         return this.sentry_;
      }
      
      public function Sentry(param1:String) : CreateSentry
      {
         this.sentry = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var sentryTower:Tower = null;
         var ocupied:MovieClip = null;
         var effect:ClipEffect = null;
         var j:int = 0;
         var upgrades:Vector.<UpgradeDef> = null;
         var areaEffect:AreaEffectDef = null;
         var tower:Tower = param1;
         var spawnFrom:Entity = param2;
         var target:Entity = param3;
         var offset:Vector2 = param4;
         if(tower.baseDef.id == "Sprockets")
         {
            this.Sentry("SentrySprockets");
         }
         var sentryDef:TowerDef = Main.instance.towerFactory.getBaseTower(this.sentry);
         sentryTower = new Tower();
         sentryTower.baseDef = sentryDef;
         sentryTower.id = this.sentry;
         this.offsetTemp.fromPolar(Rndm.random() * 2 * Math.PI,Rndm.random() * (tower.def.rangeOfVisibility - 40) + 40);
         sentryTower.x = tower.x + this.offsetTemp.x;
         sentryTower.y = tower.y + this.offsetTemp.y;
         sentryTower.targetPriority = tower.targetPriority;
         ocupied = new sentryDef.occupiedSpace();
         var container:MovieClip = new MovieClip();
         container.addChild(ocupied);
         ocupied.x = sentryTower.x;
         ocupied.y = sentryTower.y;
         var validSpotFound:Boolean = false;
         var i:int = 0;
         while(i < 30)
         {
            if(tower.level.isPlaceable(container))
            {
               validSpotFound = true;
               break;
            }
            this.offsetTemp.fromPolar(Rndm.random() * 2 * Math.PI,Rndm.random() * (tower.def.rangeOfVisibility - 40) + 40);
            sentryTower.x = tower.x + this.offsetTemp.x;
            sentryTower.y = tower.y + this.offsetTemp.y;
            ocupied.x = sentryTower.x;
            ocupied.y = sentryTower.y;
            i++;
         }
         if(false == validSpotFound)
         {
            j = 0;
            while(j < 30)
            {
               if(tower.level.terrainSet.isInPlayArea(container))
               {
                  validSpotFound = true;
                  break;
               }
               this.offsetTemp.fromPolar(Rndm.random() * 2 * Math.PI,Rndm.random() * (tower.def.rangeOfVisibility - 40) + 40);
               sentryTower.x = tower.x + this.offsetTemp.x;
               sentryTower.y = tower.y + this.offsetTemp.y;
               ocupied.x = sentryTower.x;
               ocupied.y = sentryTower.y;
               j++;
            }
         }
         var areaEffects:Vector.<AreaEffectDef> = Main.instance.game.level.getAreaEffects(sentryTower.x,sentryTower.y,null);
         if(areaEffects != null)
         {
            upgrades = sentryTower.upgrades;
            for each(areaEffect in areaEffects)
            {
               if(areaEffect.upgrade != null)
               {
                  if(upgrades == null)
                  {
                     upgrades = new Vector.<UpgradeDef>();
                  }
                  if(upgrades.indexOf(areaEffect.upgrade) == -1)
                  {
                     upgrades.push(areaEffect.upgrade);
                  }
               }
            }
            sentryTower.upgrades = upgrades;
         }
         sentryTower.initialise(sentryDef,tower.level);
         effect = new ClipEffect();
         effect.initialise(EngineerSentryBuild);
         effect.x = sentryTower.x;
         effect.y = sentryTower.y;
         effect.z = tower.z;
         effect.addEventListener(ClipEffect.DONE,function(param1:Event):void
         {
            sentryTower.pause = false;
            sentryTower.pauseDraw = false;
            effect.removeEventListener(ClipEffect.DONE,arguments.callee);
         });
         tower.level.addEntity(effect);
         sentryTower.pause = true;
         sentryTower.pauseDraw = true;
         tower.level.addTower(sentryTower);
         var destroyTimer:GameSpeedTimer = new GameSpeedTimer(28);
         destroyTimer.extra = {"sentryTower":sentryTower};
         destroyTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            var _loc2_:Tower = (param1.target as GameSpeedTimer).extra.sentry;
            tower.level.removeTower(sentryTower);
            sentryTower.destroy();
         });
      }
   }
}
