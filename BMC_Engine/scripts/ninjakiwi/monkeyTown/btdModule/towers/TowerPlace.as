package ninjakiwi.monkeyTown.btdModule.towers
{
   import assets.effects.CantPlaceEffect;
   import assets.effects.Place;
   import assets.towerPlace.Ace;
   import assets.towerPlace.AceUnder;
   import assets.towers.Meerkat;
   import assets.towers.MeerkatHead;
   import assets.towers.MeerkatHeadPro;
   import assets.towers.MeerkatMound;
   import assets.towers.TribalCoconutArm;
   import assets.towers.TribalSpearArm;
   import assets.towers.TribalWaterRipple;
   import display.Frame;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.StageQuality;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.ingame.RangeCombo;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BaseAttackCooldownScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.FootprintScale;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.BloonberryInit;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.DisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.Combinator;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   import org.osflash.signals.Signal;
   
   public class TowerPlace extends Entity
   {
      
      public static var blockTowerPlacing:Boolean;
      
      public static var waterClipUpgrade:UpgradeDef = new UpgradeDef().Add(new AddDef().DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(TribalWaterRipple).Z(-4).Loop(true)])));
      
      public static const towerPlacedSignal:Signal = new Signal(Tower);
      
      public static const USE_TOWERPLACE_FIX:Boolean = false;
       
      
      public var def:TowerDef;
      
      public var towerPickerDef:TowerPickerDef;
      
      private var clip:MovieClip;
      
      private var clip2:MovieClip;
      
      private var occupiedSpace:MovieClip = null;
      
      private var range:RangeCombo;
      
      private var rangeTrasform:Matrix;
      
      private var placeEffect:MovieClip;
      
      private var cantPlaceEffect:MovieClip;
      
      private var cantPlaceColorTransform:ColorTransform;
      
      private var placeSound:MaxSound;
      
      public function TowerPlace()
      {
         this.range = new RangeCombo();
         this.rangeTrasform = new Matrix();
         this.placeEffect = new assets.effects.Place();
         this.cantPlaceEffect = new CantPlaceEffect();
         this.cantPlaceColorTransform = new ColorTransform(0,0,0,1,255);
         this.placeSound = new MaxSound(assets.sounds.Place);
         super();
      }
      
      public function initialise(param1:TowerDef, param2:TowerPickerDef) : void
      {
         var _loc5_:Buff = null;
         var _loc6_:MeerkatMound = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Boolean = false;
         var _loc12_:Object = null;
         this.occupiedSpace = new param1.occupiedSpace();
         var _loc3_:int = 0;
         while(_loc3_ < param1.buffs.length)
         {
            _loc5_ = param1.buffs[_loc3_];
            if(_loc5_.buffMethodModuleClass == FootprintScale)
            {
               this.occupiedSpace.width = this.occupiedSpace.width * _loc5_.buffValue;
               this.occupiedSpace.height = this.occupiedSpace.height * _loc5_.buffValue;
            }
            _loc3_++;
         }
         this.range.visible = true;
         this.range.initialise(param1);
         this.def = param1;
         this.towerPickerDef = param2;
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         if(param1.id == "Meerkat" || param1.id == "MeerkatPro")
         {
            rotation = -Math.PI / 2;
            this.clip = new MovieClip();
            Main.instance.addChild(this.clip);
            _loc6_ = new MeerkatMound();
            _loc6_.rotation = 90;
            this.clip.addChild(_loc6_);
            this.clip.addChild(new Meerkat());
            if(param1.id == "Meerkat")
            {
               this.clip.addChild(new MeerkatHead());
            }
            else
            {
               this.clip.addChild(new MeerkatHeadPro());
            }
            this.clip2 = new MovieClip();
            Main.instance.addChild(this.clip2);
            _loc6_ = new MeerkatMound();
            _loc6_.rotation = 90;
            this.clip2.addChild(_loc6_);
            this.clip2.addChild(new Meerkat());
            if(param1.id == "Meerkat")
            {
               this.clip2.addChild(new MeerkatHead());
            }
            else
            {
               this.clip2.addChild(new MeerkatHeadPro());
            }
         }
         else if(param1.id == "MonkeyAce")
         {
            Main.instance.addChild(this.clip = new AceUnder());
            Main.instance.addChild(this.clip2 = new Ace());
         }
         else if(param1.id == "TribalTurtle" || param1.id == "TribalTurtlePro")
         {
            this.clip = new MovieClip();
            _loc7_ = new TribalSpearArm();
            _loc7_.stop();
            this.clip.addChild(_loc7_);
            _loc8_ = new TribalCoconutArm();
            _loc8_.stop();
            this.clip.addChild(_loc8_);
            this.clip.addChild(new param1.display());
            this.clip2 = new MovieClip();
            _loc7_ = new TribalSpearArm();
            _loc7_.stop();
            this.clip2.addChild(_loc7_);
            _loc8_ = new TribalCoconutArm();
            _loc8_.stop();
            this.clip2.addChild(_loc8_);
            this.clip2.addChild(new param1.display());
            Main.instance.addChild(this.clip);
            Main.instance.addChild(this.clip2);
         }
         else
         {
            Main.instance.addChild(this.clip = new param1.display());
            Main.instance.addChild(this.clip2 = new param1.display());
            this.clip.stop();
            this.clip2.stop();
         }
         if(param1.id == "BloonberryBush" || param1.id == "BloonberryBushPro")
         {
            _loc9_ = 10;
            _loc10_ = (param1.behavior.initialise as BloonberryInit).projectile.pierce;
            this.clip.gotoAndStop(int(this.clip.totalFrames - 1 - _loc9_ / _loc10_ * (this.clip.totalFrames - 1)) + 1);
            this.clip2.gotoAndStop(this.clip.currentFrame);
         }
         var _loc4_:GlowFilter = new GlowFilter(0,0.3);
         _loc4_.knockout = true;
         this.clip.filters = [_loc4_];
         this.clip.mouseEnabled = false;
         this.clip2.mouseEnabled = false;
         this.clip.mouseChildren = false;
         this.clip2.mouseChildren = false;
         if(param1.weapons)
         {
            _loc11_ = false;
            for each(_loc12_ in param1.weapons)
            {
               if(_loc12_.hasOwnProperty("rotate"))
               {
                  if(_loc12_.rotate)
                  {
                     _loc11_ = true;
                     break;
                  }
               }
            }
            if(_loc11_ || param1.id == "MonkeyApprentice" || param1.id == "BeekeeperPro" || param1.id == "Beekeeper" || param1.id == "DartMonkey" || param1.id == "SniperMonkey" || param1.id == "MonkeyBuccaneer" || param1.id == "DartlingGun" || param1.id == "TribalTurtle" || param1.id == "TribalTurtlePro")
            {
               rotation = -Math.PI / 2;
            }
         }
         if(param1.id == "RoadSpikes" || param1.id == "BloonberryBush")
         {
            rotation = Math.random() * Math.PI * 2;
         }
         z = 99999;
      }
      
      override public function destroy() : void
      {
         Main.instance.removeChild(this.clip);
         Main.instance.removeChild(this.clip2);
         rotation = 0;
         this.def = null;
         this.towerPickerDef = null;
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.range.visible = false;
         Pool.release(this);
         this.range.destroy();
         super.destroy();
      }
      
      private function mouseUp(param1:MouseEvent) : void
      {
         if(Main.instance.game.inGameMenu.inPlayArea() == true && TowerPlace.blockTowerPlacing == false)
         {
            this.place();
         }
      }
      
      private function place() : void
      {
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc4_:Tower = null;
         var _loc5_:int = 0;
         if(USE_TOWERPLACE_FIX)
         {
            if(Frame.stage !== null)
            {
               _loc1_ = Frame.stage.quality;
               Frame.stage.quality = StageQuality.LOW;
            }
         }
         x = Main.instance.mouseX;
         y = Main.instance.mouseY;
         this.occupiedSpace.x = x;
         this.occupiedSpace.y = y;
         var _loc2_:int = TowerAvailabilityManager.instance.getNumberOfFreeTowers(this.def.id);
         if(Main.instance.game.level.isPlaceable(this.occupiedSpace,this.def.isBoat,this.def.canPlaceOnTrack,this.def.isBoat && this.def.isLand) && (Main.instance.game.level.canAfford(this.towerPickerDef.cost) || _loc2_ > 0))
         {
            _loc3_ = String(Tower.nextFreeID++);
            _loc4_ = Main.instance.game.level.createTower(_loc3_,this.def,x,y,rotation);
            _loc5_ = Main.instance.game.level.calcCostMods(this.towerPickerDef.cost,x,y,_loc4_);
            if(_loc2_ > 0)
            {
               _loc5_ = 0;
               _loc4_.isFree = true;
            }
            _loc4_.spentOn = _loc5_;
            this.applyBuffs(_loc4_);
            Main.instance.game.level.removeCash(_loc4_.spentOn);
            this.destroy();
            Main.instance.game.inGameMenu.placeUp(_loc4_);
            TowerPlace.towerPlacedSignal.dispatch(_loc4_);
         }
         if(USE_TOWERPLACE_FIX)
         {
            if(Frame.stage !== null && Frame.stage.quality !== StageQuality.LOW)
            {
               Frame.stage.quality = _loc1_;
            }
         }
      }
      
      private function applyBuffs(param1:Tower) : void
      {
         var _loc4_:Buff = null;
         var _loc5_:int = 0;
         var _loc6_:Weapon = null;
         if(null == param1.def)
         {
            return;
         }
         var _loc2_:Vector.<Buff> = param1.def.buffs;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(BaseAttackCooldownScale == _loc4_.buffMethodModuleClass)
            {
               _loc5_ = 0;
               while(_loc5_ < param1.def.weapons.length)
               {
                  _loc6_ = param1.def.weapons[_loc5_];
                  if(_loc6_.isBaseWeapon && _loc6_.hasOwnProperty("reloadTime"))
                  {
                     _loc6_["reloadTime"] = _loc6_["reloadTime"] * _loc4_.buffValue;
                  }
                  _loc5_++;
               }
            }
            _loc3_++;
         }
      }
      
      override public function process(param1:Number) : void
      {
         var _loc2_:Vector.<AreaEffectDef> = null;
         var _loc3_:Vector.<UpgradeDef> = null;
         var _loc4_:AreaEffectDef = null;
         x = Main.instance.mouseX;
         y = Main.instance.mouseY;
         this.occupiedSpace.x = x;
         this.occupiedSpace.y = y;
         this.range.x = x;
         this.range.y = y;
         if(this.def.areaEffects != null)
         {
            this.range.initialise(this.def);
         }
         else
         {
            _loc2_ = Main.instance.game.level.getAreaEffects(x,y,null);
            if(_loc2_ != null)
            {
               _loc3_ = null;
               for each(_loc4_ in _loc2_)
               {
                  if(_loc4_.upgrade != null)
                  {
                     if(_loc3_ == null)
                     {
                        _loc3_ = new Vector.<UpgradeDef>();
                     }
                     if(_loc3_.indexOf(_loc4_.upgrade) == -1)
                     {
                        _loc3_.push(_loc4_.upgrade);
                     }
                  }
               }
               if(_loc3_ != null)
               {
                  this.range.initialise(Combinator.combine(this.def,_loc3_));
               }
               else
               {
                  this.range.initialise(this.def);
               }
            }
            else
            {
               this.range.initialise(this.def);
            }
         }
         if(Main.instance.game.level.isPlaceable(this.occupiedSpace,this.def.isBoat,this.def.canPlaceOnTrack,this.def.isBoat && this.def.isLand))
         {
            this.range.colorTransform = null;
         }
         else
         {
            this.range.colorTransform = this.cantPlaceColorTransform;
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this.def == null)
         {
            return;
         }
         this.occupiedSpace.x = x;
         this.occupiedSpace.y = y;
         this.clip.rotation = rotation * 180 / Math.PI;
         this.clip2.rotation = rotation * 180 / Math.PI;
         this.clip.x = x;
         this.clip2.x = x;
         this.clip.y = y;
         this.clip2.y = y;
      }
   }
}
