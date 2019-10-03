package ninjakiwi.monkeyTown.btdModule.entities
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AltDisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.DisplayAddonDef;
   
   public class TowerHilight extends Entity
   {
       
      
      private var front:AdditiveEntityFore = null;
      
      private var theZ:Number = 0;
      
      public var tower:Tower = null;
      
      private var towerMC:MovieClip = null;
      
      private var selectEffect:MovieClip = null;
      
      private var scaleContainer:MovieClip;
      
      private var drawContainer:MovieClip;
      
      private var sourceClass:Class = null;
      
      private var addonClips:Vector.<MovieClip> = null;
      
      public function TowerHilight(param1:Class)
      {
         this.scaleContainer = new MovieClip();
         this.drawContainer = new MovieClip();
         super();
         this.drawContainer.scaleX = Main.instance.scale;
         this.drawContainer.scaleY = Main.instance.scale;
         this.selectEffect = new param1();
         z = 9999999;
         this.drawContainer.addChild(this.selectEffect);
         this.scaleContainer.addChild(this.drawContainer);
      }
      
      public function setTower(param1:Tower) : void
      {
         var _loc2_:DisplayAddonDef = null;
         var _loc3_:Class = null;
         var _loc4_:MovieClip = null;
         var _loc5_:AltDisplayAddonDef = null;
         this.tower = param1;
         if(param1 != null)
         {
            if(param1.def == null)
            {
               param1 = null;
               return;
            }
            if(this.towerMC != null)
            {
               this.selectEffect.inner.removeChild(this.towerMC);
               this.towerMC = null;
            }
            if(param1.def.display == null)
            {
               return;
            }
            this.towerMC = new param1.def.display();
            this.addonClips = new Vector.<MovieClip>();
            if(param1.def.displayAddons != null)
            {
               for each(_loc2_ in param1.def.displayAddons)
               {
                  _loc3_ = _loc2_.clip;
                  if(_loc2_.alts != null)
                  {
                     for each(_loc5_ in _loc2_.alts)
                     {
                        if(_loc5_.useFor == param1.def.display)
                        {
                           _loc3_ = _loc5_.display;
                           break;
                        }
                     }
                  }
                  _loc4_ = new _loc3_();
                  this.addonClips.push(_loc4_);
                  this.towerMC.addChild(_loc4_);
               }
            }
            this.sourceClass = param1.def.display;
            this.towerMC.stop();
            this.selectEffect.inner.addChild(this.towerMC);
         }
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(this.tower && this.tower.def)
         {
            if(this.sourceClass != this.tower.def.display)
            {
               this.setTower(this.tower);
            }
            this.selectEffect.x = this.tower.x;
            this.selectEffect.y = this.tower.y;
            this.selectEffect.rotation = this.tower.rotation / (Math.PI * 2) * 360;
            if(this.towerMC == null)
            {
               return;
            }
            this.towerMC.gotoAndStop(this.tower.clip.frameIndex + 1);
            _loc2_ = 0;
            for each(_loc3_ in this.addonClips)
            {
               if(this.tower != null)
               {
                  if(this.tower.addonRotation && this.tower.addonRotation[this.tower.addonClips[_loc2_]] != null)
                  {
                     _loc3_.rotation = this.tower.addonRotation[this.tower.addonClips[_loc2_]] / (Math.PI * 2) * 360 - this.selectEffect.rotation;
                  }
                  else if(!this.tower.def.displayAddons[_loc2_].rotate)
                  {
                     _loc3_.rotation = -this.selectEffect.rotation;
                  }
                  else
                  {
                     _loc3_.rotation = 0;
                  }
                  _loc3_.gotoAndStop(this.tower.addonClips[_loc2_].frameIndex + 1);
               }
               _loc2_++;
            }
            param1.draw(this.scaleContainer);
         }
         super.draw(param1);
      }
   }
}
