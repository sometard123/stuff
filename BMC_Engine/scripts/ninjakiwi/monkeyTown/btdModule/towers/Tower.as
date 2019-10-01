package ninjakiwi.monkeyTown.btdModule.towers
{
   import assest.towers.BloonsDayDevice;
   import assest.towers.BloonsDayDevicePro;
   import assets.module.CoolDownTimerClip;
   import assets.towers.AirBase;
   import assets.towers.LaserMonkey;
   import assets.towers.MonkeyVillage;
   import assets.towers.PlasmaVision;
   import display.Clip;
   import display.LabelOverCommand;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.abilities.Ability;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SupplyDropDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.DirectUseAbilityButton;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.FootprintScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.ImmunityWhiteZebraSnapFreeze;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.BehaviorRoundOver;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.HealthyBananas;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.Intrest;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitionTimer;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SwapForProjectile;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AltDisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.DisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.modifiers.TowerModifierSet;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.Combinator;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   import ninjakiwi.monkeyTown.btdModule.utils.GameInRoundTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtReticle;
   import ninjakiwi.monkeyTown.btdModule.weapons.HasReloadTime;
   import ninjakiwi.monkeyTown.btdModule.weapons.Surround;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class Tower extends Entity
   {
      
      public static const TARGET_FIRST:int = 0;
      
      public static const TARGET_LAST:int = 1;
      
      public static const TARGET_STRONG:int = 2;
      
      public static const TARGET_CLOSE:int = 3;
      
      public static const EVENT_FIRE:String = "TOWER_FIRE";
      
      public static var nextFreeID:int = 0;
       
      
      public var id:String = null;
      
      public var def:TowerDef;
      
      public var baseDef:TowerDef = null;
      
      public var upgrades:Vector.<UpgradeDef>;
      
      public var upgradePathDef:UpgradePathDef = null;
      
      public var upgradePaths:Vector.<int>;
      
      public var rootID:String = null;
      
      public var effect:MovieClip = null;
      
      public var occupiedSpace:MovieClip = null;
      
      private var spentOn_:Number = 0;
      
      private var spentOnCS:CryptScore;
      
      public var canSell:Boolean = true;
      
      private var popCount_:int = 0;
      
      public var targetMask:int = 0;
      
      public var targetPriority:int = 0;
      
      public var checkingForBloons:Boolean = true;
      
      public var targetsByPriority:Vector.<Bloon>;
      
      public var clip:Clip;
      
      public var addonClips:Vector.<Clip>;
      
      public var tempAddonClips:Vector.<Clip>;
      
      public var addonRotation:Dictionary;
      
      private var reloadTimers:Vector.<GameSpeedTimer>;
      
      public var abilityCooldowns:Dictionary = null;
      
      public var inThrowAnimation:Boolean = false;
      
      public var collisionTestCells:Vector.<Vector.<Bloon>>;
      
      public var pause:Boolean = false;
      
      public var pauseDraw:Boolean = false;
      
      public var pauseDrawAddons:Boolean = false;
      
      public var hideAddon:Boolean = false;
      
      private var loop:Boolean = false;
      
      private var throwSequence:int = 0;
      
      private var ambiant:Boolean = false;
      
      private var instance:Tower = null;
      
      private var game:Game = null;
      
      public var level:Level = null;
      
      public var timer:GameSpeedTimer;
      
      public var selectable:Boolean = true;
      
      public var isFree:Boolean = false;
      
      private var childTowers:Vector.<Tower>;
      
      public var targetingSystem:int = -1;
      
      public var resellable:Boolean = true;
      
      public var hasPopCount:Boolean = true;
      
      public var coolDownTimerGuage:CoolDownTimerClip;
      
      public var directUseAbilityButton:DirectUseAbilityButton;
      
      public var bypassWhiteThawout:Boolean = false;
      
      public var degradeBlackRemainder:Number = 0;
      
      public var pierceLeadRemainder:Number = 0;
      
      private var _buffs:Vector.<Buff> = null;
      
      private var _attackSpeedModifier:Number = 1.0;
      
      public var modifiers:TowerModifierSet;
      
      public var isFrozen:Boolean = false;
      
      public var isProjectileIncoming:Boolean = false;
      
      public var addPopsTo:Tower = null;
      
      public var activeAbilities:Dictionary;
      
      public function Tower()
      {
         this.upgrades = new Vector.<UpgradeDef>();
         this.upgradePaths = Vector.<int>([0,0]);
         this.spentOnCS = new CryptScore();
         this.targetsByPriority = new Vector.<Bloon>();
         this.clip = new Clip();
         this.addonClips = new Vector.<Clip>();
         this.tempAddonClips = new Vector.<Clip>();
         this.addonRotation = new Dictionary();
         this.collisionTestCells = new Vector.<Vector.<Bloon>>();
         this.activeAbilities = new Dictionary(true);
         super();
         this.instance = this;
         this.game = Main.instance.game;
         this.game.addEventListener(LevelEvent.ROUND_START,this.roundStart);
         this.game.addEventListener(LevelEvent.ROUND_OVER,this.roundOver);
         this.modifiers = new TowerModifierSet(this);
      }
      
      public function initialise(param1:TowerDef, param2:Level, param3:Boolean = true) : void
      {
         var weapon:Weapon = null;
         var behavior:BehaviorDef = null;
         var rotate:Boolean = false;
         var weaponRotate:Object = null;
         var currentBuff:Buff = null;
         var buffedWidthScale:Number = NaN;
         var buffedHeightScale:Number = NaN;
         var addon:DisplayAddonDef = null;
         var addonClip:Clip = null;
         var addonClipClass:Class = null;
         var possibleAlt:AltDisplayAddonDef = null;
         var hasReloadTime:HasReloadTime = null;
         var i:int = 0;
         var ability:AbilityDef = null;
         var cooldownTime:Number = NaN;
         var ttt:GameInRoundTimer = null;
         var maskFlag:int = 0;
         var def:TowerDef = param1;
         var level:Level = param2;
         var updateBase:Boolean = param3;
         if(def == null)
         {
            return;
         }
         this.level = level;
         this.modifiers.clear();
         if(this.baseDef && this.upgrades && this.upgrades.length > 0 && updateBase == true)
         {
            this.initialise(Combinator.combine(def,this.upgrades),level,false);
            this.baseDef = def;
            return;
         }
         this.upgradePathDef = Main.instance.towerFactory.getUpgrades(def.id);
         if(this.targetingSystem == -1)
         {
            this.targetingSystem = def.targetingSystem;
         }
         if(this.def != null)
         {
            behavior = this.def.behavior;
            if(behavior != null && behavior.roundOver != null && level.isRoundInProgress())
            {
               if(behavior.roundOver.isCalledOnReInit == true)
               {
                  if(!(behavior.roundOver is Intrest || behavior.roundOver is HealthyBananas))
                  {
                     behavior.roundOver.execute(this);
                  }
               }
            }
            this.removeAreaEffects();
         }
         if(def.weapons)
         {
            rotate = false;
            for each(weaponRotate in def.weapons)
            {
               if(weaponRotate.hasOwnProperty("rotate"))
               {
                  if(weaponRotate.rotate)
                  {
                     rotate = true;
                     break;
                  }
               }
            }
            if(rotation == 0)
            {
               if(rotate || def.id == "MonkeyApprentice" || def.id == "SniperMonkey" || def.id == "MonkeyBuccaneer" || def.id == "DartlingGun" || def.id == "TribalTurtle")
               {
                  rotation = -Math.PI / 2;
               }
            }
         }
         this.def = def;
         if(updateBase)
         {
            this.baseDef = def;
         }
         this.occupiedSpace = new def.occupiedSpace();
         this.occupiedSpace.x = x;
         this.occupiedSpace.y = y;
         var originalSpaceWidth:Number = this.occupiedSpace.width;
         var originalSpaceHeight:Number = this.occupiedSpace.height;
         var j:int = 0;
         while(j < this.def.buffs.length)
         {
            currentBuff = this.def.buffs[j];
            if(currentBuff.buffMethodModuleClass == FootprintScale)
            {
               buffedWidthScale = this.occupiedSpace.width / originalSpaceWidth - (1 - currentBuff.buffValue);
               buffedHeightScale = this.occupiedSpace.height / originalSpaceHeight - (1 - currentBuff.buffValue);
               this.occupiedSpace.width = originalSpaceWidth * buffedWidthScale;
               this.occupiedSpace.height = originalSpaceHeight * buffedHeightScale;
            }
            j++;
         }
         this.clip.initialise(def.display,0,def.id != "RoadSpikes");
         this.clip.stop();
         if(this.clip.hasLabel("Loop"))
         {
            this.loop = true;
            this.clip.labelOver["Loop"] = new LabelOverCommand();
            this.clip.labelOver["Loop"].command = LabelOverCommand.gotoAndPlay;
            this.clip.labelOver["Loop"].frameLabelTo = "Loop";
         }
         else
         {
            this.loop = false;
         }
         if(this.clip.hasLabel("Ambient"))
         {
            this.ambiant = true;
            this.clip.play();
            this.clip.looping = true;
         }
         else
         {
            this.ambiant = false;
         }
         if(this.clip.hasLabel("Throw1"))
         {
            this.throwSequence = 1;
         }
         if(def.display == MonkeyVillage || def.display == AirBase || def.display == BloonsDayDevice || def.display == BloonsDayDevicePro)
         {
            this.clip.play();
            this.clip.looping = true;
         }
         if(this.addonClips.length > 0)
         {
            this.addonClips.splice(0,this.addonClips.length);
         }
         this.addonRotation = new Dictionary();
         if(def.displayAddons != null)
         {
            for each(addon in def.displayAddons)
            {
               addonClip = new Clip();
               addonClipClass = addon.clip;
               if(addon.alts != null)
               {
                  for each(possibleAlt in addon.alts)
                  {
                     if(possibleAlt.useFor == def.display)
                     {
                        addonClipClass = possibleAlt.display;
                        break;
                     }
                  }
               }
               addonClip.initialise(addonClipClass,0);
               if(addon.loop)
               {
                  addonClip.play();
                  addonClip.looping = true;
               }
               else
               {
                  addonClip.stop();
                  addonClip.looping = false;
               }
               this.addonClips.push(addonClip);
            }
         }
         this.reloadTimers = new Vector.<GameSpeedTimer>();
         for each(weapon in def.weapons)
         {
            hasReloadTime = weapon as HasReloadTime;
            if(hasReloadTime != null)
            {
               this.timer = new GameSpeedTimer(hasReloadTime.reloadTime);
               this.reloadTimers.push(this.timer);
            }
         }
         this.scaleAttackSpeed(this._attackSpeedModifier);
         if(def.abilities && def.abilities.length > 0)
         {
            if(this.abilityCooldowns == null)
            {
               this.abilityCooldowns = new Dictionary();
            }
            i = 0;
            while(i < def.abilities.length)
            {
               ability = def.abilities[i];
               cooldownTime = ability.cooldown;
               if(this.abilityCooldowns[ability.id] == null)
               {
                  this.timer = new GameInRoundTimer(cooldownTime);
                  this.timer.stop();
                  this.abilityCooldowns[ability.id] = this.timer;
                  if(ability is SupplyDropDef)
                  {
                     this.timer.start();
                     ttt = new GameInRoundTimer(this.timer.delay + 0.5);
                     ttt.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
                     {
                        ttt.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
                     });
                  }
               }
               else if(this.abilityCooldowns[ability.id].delay != cooldownTime)
               {
                  if(this.abilityCooldowns[ability.id].current > cooldownTime)
                  {
                     this.abilityCooldowns[ability.id].current = cooldownTime;
                  }
                  this.abilityCooldowns[ability.id].delay = cooldownTime;
               }
               i++;
            }
         }
         if(def.behavior != null)
         {
            if(def.behavior.initialise != null)
            {
               def.behavior.initialise.execute(this);
            }
            if(def.behavior.roundStart != null && level.isRoundInProgress())
            {
               def.behavior.roundStart.execute(this);
            }
            else if(def.behavior.roundStart != null && def.behavior.roundStart is SwapForProjectile)
            {
               def.behavior.roundStart.execute(this);
            }
         }
         this.targetMask = 0;
         if(def.targetMask != null)
         {
            for each(maskFlag in def.targetMask)
            {
               this.targetMask = this.targetMask | maskFlag;
            }
         }
         this.applyAreaEffects();
         this.applyDepth();
         dispatchEvent(new PropertyModEvent("def"));
         this.applyBuffs();
      }
      
      private function applyBuffs() : void
      {
         var _loc2_:ProjectileDef = null;
         if(this.def == null)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.def.buffs.length)
         {
            if(this.def.buffs[_loc1_].buffMethodModuleClass == ImmunityWhiteZebraSnapFreeze)
            {
               if(this.upgradePaths[0] >= 2)
               {
                  this.targetMask = this.targetMask & ~Bloon.IMMUNITY_ICE;
                  _loc2_ = (this.def.weapons[0] as Surround).projectile;
                  _loc2_.effectMask.splice(_loc2_.effectMask.indexOf(Bloon.IMMUNITY_ICE),1);
                  this.bypassWhiteThawout = true;
               }
            }
            _loc1_++;
         }
         this.buffs = this.def.buffs;
      }
      
      override public function destroy() : void
      {
         var _loc2_:BehaviorRoundOver = null;
         var _loc3_:BananaEmitionTimer = null;
         if(this.def == null)
         {
            return;
         }
         this.childTowers = null;
         var _loc1_:BehaviorDef = this.def.behavior;
         if(_loc1_ != null && _loc1_.roundOver != null)
         {
            _loc2_ = _loc1_.roundOver;
            if(!(_loc2_ is Intrest || _loc2_ is HealthyBananas))
            {
               _loc2_.execute(this);
            }
         }
         if(_loc1_ != null && _loc1_.destroy != null)
         {
            _loc1_.destroy.execute(this);
         }
         if(BananaEmitter.bankedTowerFunds[this] != null)
         {
            BananaEmitter.bankedTowerFunds[this] = null;
            delete BananaEmitter.bankedTowerFunds[this];
         }
         if(BananaEmitter.towerTimers[this] != null)
         {
            for each(_loc3_ in BananaEmitter.towerTimers[this])
            {
               _loc3_.cancel();
            }
         }
         if(this.def.behavior != null)
         {
            if(this.def.behavior.initialise != null)
            {
               this.def.behavior.initialise.cleanup(this);
            }
            if(this.def.behavior.roundStart != null)
            {
               this.def.behavior.roundStart.cleanup(this);
            }
            if(this.def.behavior.process != null)
            {
               this.def.behavior.process.cleanup(this);
            }
            if(this.def.behavior.roundOver != null)
            {
               this.def.behavior.roundOver.cleanup(this);
            }
            if(this.def.behavior.destroy != null)
            {
               this.def.behavior.destroy.cleanup(this);
            }
         }
         this.game.removeEventListener(LevelEvent.ROUND_START,this.roundStart);
         this.game.removeEventListener(LevelEvent.ROUND_OVER,this.roundOver);
         this.removeAreaEffects();
         this.def = null;
         this.baseDef = null;
         this.reloadTimers = null;
         this.effect = null;
         this._attackSpeedModifier = 1;
         Pool.release(this);
         this.upgrades.splice(0,this.upgrades.length);
         this.spentOn = 0;
         this.popCount = 0;
         rotation = 0;
         this.pause = false;
         this.abilityCooldowns = null;
         z = 0;
         super.destroy();
      }
      
      private function roundStart(param1:Event) : void
      {
         var _loc2_:BehaviorDef = this.def.behavior;
         if(_loc2_ != null && _loc2_.roundStart != null)
         {
            _loc2_.roundStart.execute(this.instance);
         }
      }
      
      private function roundOver(param1:Event) : void
      {
         var _loc2_:BehaviorDef = this.def.behavior;
         if(_loc2_ != null && _loc2_.roundOver != null)
         {
            _loc2_.roundOver.execute(this.instance);
         }
      }
      
      public function applyDepth() : void
      {
         z = 1 + y / Main.mapArea.height * 0.5;
      }
      
      public function applyAreaEffects() : void
      {
         var _loc2_:Tower = null;
         var _loc3_:AreaEffectDef = null;
         var _loc4_:TowerDef = null;
         var _loc5_:Number = NaN;
         if(this.def == null || this.def.areaEffects == null)
         {
            return;
         }
         var _loc1_:Vector.<Tower> = this.level.getTowersInRange(x,y,this.def.rangeOfVisibility);
         for each(_loc2_ in _loc1_)
         {
            if(!(_loc2_ == this || _loc2_.def && _loc2_.def.areaEffects || _loc2_.def == null))
            {
               for each(_loc3_ in this.def.areaEffects)
               {
                  if(_loc3_.upgrade != null)
                  {
                     _loc2_.upgrades.push(_loc3_.upgrade);
                  }
               }
               _loc4_ = Combinator.combine(_loc2_.baseDef,_loc2_.upgrades);
               if(_loc4_ != this.def)
               {
                  _loc5_ = _loc2_.rotation;
                  _loc2_.initialise(_loc4_,this.level,false);
                  _loc2_.rotation = _loc5_;
                  this.level.performUpgradedTowerChecks(_loc2_);
               }
            }
         }
      }
      
      public function removeAreaEffects() : void
      {
         var _loc2_:Tower = null;
         var _loc3_:AreaEffectDef = null;
         var _loc4_:TowerDef = null;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         if(this.def == null || this.def.areaEffects == null)
         {
            return;
         }
         var _loc1_:Vector.<Tower> = this.level.getTowersInRange(x,y,this.def.rangeOfVisibility);
         for each(_loc2_ in _loc1_)
         {
            if(!(_loc2_ == this || _loc2_.def && _loc2_.def.areaEffects || _loc2_.def == null))
            {
               for each(_loc3_ in this.def.areaEffects)
               {
                  if(_loc3_.upgrade != null)
                  {
                     _loc5_ = _loc2_.upgrades.indexOf(_loc3_.upgrade);
                     if(_loc5_ != -1)
                     {
                        _loc2_.upgrades.splice(_loc5_,1);
                     }
                  }
               }
               _loc4_ = Combinator.combine(_loc2_.baseDef,_loc2_.upgrades);
               if(_loc4_ != this.def)
               {
                  _loc6_ = _loc2_.rotation;
                  _loc2_.initialise(_loc4_,this.level,false);
                  _loc2_.rotation = _loc6_;
                  this.level.performUpgradedTowerChecks(_loc2_);
               }
            }
         }
      }
      
      public function addUpgrade(param1:UpgradeDef, param2:Boolean = true) : void
      {
         if(this.upgrades.indexOf(param1) != -1)
         {
            return;
         }
         this.upgrades.push(param1);
         if(param2)
         {
            this.initialise(Combinator.combine(this.baseDef,this.upgrades),this.level,false);
         }
      }
      
      public function removeUpgrade(param1:UpgradeDef, param2:Boolean = true) : void
      {
         var _loc3_:int = this.upgrades.indexOf(param1);
         if(_loc3_ == -1)
         {
            return;
         }
         this.upgrades.splice(_loc3_,1);
         if(param2)
         {
            this.initialise(Combinator.combine(this.baseDef,this.upgrades),this.level,false);
         }
      }
      
      public function abilityTimer(param1:String) : GameSpeedTimer
      {
         return this.abilityCooldowns[param1];
      }
      
      public function abilityUse(param1:String) : Boolean
      {
         var context:Tower = null;
         var ability:AbilityDef = null;
         var abilityID:String = param1;
         context = this;
         var process:Function = function():Boolean
         {
            var _loc1_:Ability = new ability.ability();
            activeAbilities[ability] = _loc1_;
            if(_loc1_.isReady)
            {
               if(abilityID == "OverclockPick")
               {
                  _loc1_.execute(context,ability);
                  return false;
               }
               abilityCooldowns[abilityID].reset();
               _loc1_.execute(context,ability);
               return true;
            }
            return false;
         };
         var i:int = 0;
         while(i < this.def.abilities.length)
         {
            ability = this.def.abilities[i];
            if(ability.id == abilityID)
            {
               if(ability.ability != null)
               {
                  return process();
               }
            }
            i++;
         }
         return false;
      }
      
      public function set popCount(param1:int) : void
      {
         if(this.popCount_ != param1)
         {
            this.popCount_ = param1;
            dispatchEvent(new PropertyModEvent("popCount"));
         }
      }
      
      public function get popCount() : int
      {
         return this.popCount_;
      }
      
      public function set spentOn(param1:Number) : void
      {
         if(this.spentOn_ != param1)
         {
            this.spentOnCS.value = param1;
            this.spentOn_ = param1;
            dispatchEvent(new PropertyModEvent("spentOn"));
         }
      }
      
      public function get spentOn() : Number
      {
         if(this.spentOn_ != this.spentOnCS.value)
         {
            this.spentOn_ = this.spentOnCS.value;
         }
         return this.spentOn_;
      }
      
      public function get buffs() : Vector.<Buff>
      {
         return this._buffs;
      }
      
      public function set buffs(param1:Vector.<Buff>) : void
      {
         this._buffs = param1;
      }
      
      public function get attackSpeedModifier() : Number
      {
         return this._attackSpeedModifier;
      }
      
      private function readyFire() : void
      {
         var _loc2_:Weapon = null;
         var _loc3_:GameSpeedTimer = null;
         if(this.def == null || this.def.weapons == null)
         {
            return;
         }
         var _loc1_:int = 0;
         for(; _loc1_ < this.def.weapons.length; _loc1_++)
         {
            _loc2_ = this.def.weapons[_loc1_];
            _loc3_ = this.reloadTimers[_loc1_];
            if(!_loc3_.running)
            {
               if(this.targetsByPriority.length == 0 && !this.def.targetAll)
               {
                  if(_loc2_.requiresTarget)
                  {
                     continue;
                  }
               }
               if(this.level.isRoundInProgress())
               {
                  if(!_loc2_.proxied)
                  {
                     if(_loc1_ == 0)
                     {
                        this.checkingForBloons = false;
                        if(this.inThrowAnimation)
                        {
                           this.fire(_loc2_);
                        }
                        if(!this.ambiant)
                        {
                           if(this.throwSequence != 0)
                           {
                              if(!this.clip.hasLabel("Throw" + String(this.throwSequence)))
                              {
                                 this.throwSequence = 1;
                              }
                              this.clip.gotoLabel("Throw" + String(this.throwSequence));
                              this.clip.play();
                              this.throwSequence++;
                           }
                           else if(!this.loop)
                           {
                              this.clip.gotoAndPlay(0);
                           }
                        }
                        this.inThrowAnimation = true;
                     }
                     else
                     {
                        this.fire(_loc2_);
                     }
                     _loc3_.reset();
                     _loc3_.speedModifier = this._attackSpeedModifier;
                  }
               }
            }
         }
      }
      
      private function checkFireFrame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Weapon = null;
         if((!this.clip.hasLabel("Throw") || this.clip.currentLabel == "Throw") && this.inThrowAnimation)
         {
            _loc1_ = 0;
            if(_loc1_ < this.def.weapons.length)
            {
               _loc2_ = this.def.weapons[_loc1_];
               this.fire(_loc2_);
               this.inThrowAnimation = false;
            }
         }
      }
      
      private function fire(param1:Weapon) : void
      {
         this.checkingForBloons = true;
         var _loc2_:int = this.def.weapons.indexOf(param1);
         if(this.def.weaponOffsets && this.def.weaponOffsets.length > _loc2_ && this.def.weaponOffsets[_loc2_] && this.def.display != LaserMonkey && this.def.display != PlasmaVision)
         {
            param1.execute(this,this,this.targetsByPriority.length > 0?this.targetsByPriority[this.targetsByPriority.length - 1]:null,this.def.weaponOffsets[_loc2_]);
         }
         else
         {
            param1.execute(this,this,this.targetsByPriority.length > 0?this.targetsByPriority[this.targetsByPriority.length - 1]:null);
         }
         this.dispatchEvent(new Event(EVENT_FIRE));
      }
      
      override public function process(param1:Number) : void
      {
         if(this.pause || this.isFrozen)
         {
            this.clip.process();
            this.processAddonClips();
            this.processTemporaryClips();
            this.modifiers.update(param1);
            return;
         }
         if(this.loop && this.targetsByPriority.length == 0 && this.clip.frameIndex == this.clip.frameCount - 1)
         {
            this.clip.gotoAndStop(0);
         }
         else if(this.loop && this.targetsByPriority.length != 0 && this.clip.currentLabel != "Loop")
         {
            this.clip.gotoLabel("Loop");
            this.clip.play();
         }
         this.readyFire();
         this.checkFireFrame();
         if(this.def != null && this.def.behavior != null && this.def.behavior.process != null)
         {
            this.def.behavior.process.process(this,param1);
         }
         this.clip.process();
         this.processAddonClips();
         this.processTemporaryClips();
         this.modifiers.update(param1);
      }
      
      private function processAddonClips() : void
      {
         var _loc2_:Clip = null;
         var _loc1_:int = this.addonClips.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.addonClips[_loc1_];
            _loc2_.process();
            _loc1_--;
         }
      }
      
      private function processTemporaryClips() : void
      {
         var _loc2_:Clip = null;
         var _loc1_:int = this.tempAddonClips.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.tempAddonClips[_loc1_];
            if(_loc2_.markForRemoval)
            {
               this.removeTemporaryAnimation(_loc2_);
            }
            else
            {
               _loc2_.process();
            }
            _loc1_--;
         }
      }
      
      private function drawAddon(param1:BitmapData, param2:Clip, param3:int) : void
      {
         if(!this.def.displayAddons[param3].rotate)
         {
            param2.quickDraw(param1,x,y);
         }
         else if(this.addonRotation[param2] == null)
         {
            param2.drawRotated(param1,x,y,rotation);
         }
         else
         {
            param2.drawRotated(param1,x,y,this.addonRotation[param2]);
         }
      }
      
      private function drawTemporaryClip(param1:BitmapData, param2:Clip) : void
      {
         param2.quickDraw(param1,x,y);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         var _loc2_:Clip = null;
         var _loc4_:int = 0;
         if(this.pauseDraw)
         {
            return;
         }
         if(this.def == null)
         {
            return;
         }
         var _loc3_:int = 0;
         for each(_loc2_ in this.addonClips)
         {
            if(this.def.displayAddons !== null && this.def.displayAddons.length > _loc3_ && this.def.displayAddons[_loc3_].z < -1)
            {
               if(this.hideAddon && _loc3_ == 3)
               {
                  continue;
               }
               this.drawAddon(param1,_loc2_,_loc3_);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         for each(_loc2_ in this.addonClips)
         {
            if(this.def.displayAddons[_loc3_].z < 0 && this.def.displayAddons[_loc3_].z >= -1)
            {
               if(this.hideAddon && _loc3_ == 3)
               {
                  continue;
               }
               this.drawAddon(param1,_loc2_,_loc3_);
            }
            _loc3_++;
         }
         if(!this.pauseDrawAddons)
         {
            if(rotation == 0)
            {
               if(this.effect != null)
               {
                  this.clip.drawWithEffect(param1,x,y,this.effect,rotation,true);
               }
               else
               {
                  this.clip.quickDraw(param1,x,y);
               }
            }
            else if(this.effect != null)
            {
               this.clip.drawWithEffect(param1,x,y,this.effect,rotation,true);
            }
            else
            {
               this.clip.drawRotated(param1,x,y,rotation);
            }
         }
         _loc3_ = 0;
         for each(_loc2_ in this.addonClips)
         {
            if(this.def.displayAddons[_loc3_].z >= 0 && this.def.displayAddons[_loc3_].z < 2)
            {
               this.drawAddon(param1,_loc2_,_loc3_);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         for each(_loc2_ in this.addonClips)
         {
            if(this.def.displayAddons[_loc3_].z >= 2)
            {
               this.drawAddon(param1,_loc2_,_loc3_);
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < this.tempAddonClips.length)
         {
            _loc2_ = this.tempAddonClips[_loc4_];
            this.drawTemporaryClip(param1,_loc2_);
            _loc4_++;
         }
      }
      
      public function addChildTower(param1:Tower) : void
      {
         if(this.childTowers == null)
         {
            this.childTowers = new Vector.<Tower>();
         }
         this.childTowers.push(param1);
         this.applyPlatformEffects(param1);
         this.canSell = false;
      }
      
      public function ifRemovedChildTower(param1:Tower) : Boolean
      {
         if(this.childTowers == null)
         {
            return false;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.childTowers.length)
         {
            if(param1 == this.childTowers[_loc2_])
            {
               this.childTowers.splice(_loc2_,1);
               this.removePlatformEffects(param1);
               if(this.childTowers.length == 0)
               {
                  this.canSell = true;
               }
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function hasChildTowers() : Boolean
      {
         if(this.childTowers == null)
         {
            return false;
         }
         return this.childTowers.length > 0;
      }
      
      public function applyPlatformEffects(param1:Tower) : void
      {
         var _loc2_:AreaEffectDef = null;
         var _loc3_:Number = NaN;
         if(this.def == null || this.def.platformEffects == null)
         {
            return;
         }
         if(param1.def && param1.def.areaEffects)
         {
            return;
         }
         for each(_loc2_ in this.def.platformEffects)
         {
            if(_loc2_.upgrade != null)
            {
               param1.upgrades.push(_loc2_.upgrade);
            }
         }
         _loc3_ = param1.rotation;
         param1.initialise(Combinator.combine(param1.baseDef,param1.upgrades),this.level,false);
         param1.rotation = _loc3_;
         this.level.performUpgradedTowerChecks(param1);
      }
      
      public function removePlatformEffects(param1:Tower) : void
      {
         var _loc2_:AreaEffectDef = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(this.def == null || this.def.areaEffects == null)
         {
            return;
         }
         if(param1.def && param1.def.areaEffects)
         {
            return;
         }
         for each(_loc2_ in this.def.platformEffects)
         {
            if(_loc2_.upgrade != null)
            {
               _loc4_ = param1.upgrades.indexOf(_loc2_.upgrade);
               if(_loc4_ != -1)
               {
                  param1.upgrades.splice(_loc4_,1);
               }
            }
         }
         _loc3_ = param1.rotation;
         param1.initialise(Combinator.combine(param1.baseDef,param1.upgrades),this.level,false);
         param1.rotation = _loc3_;
         this.level.performUpgradedTowerChecks(param1);
      }
      
      public function getNextUpgradeCost(param1:int) : Number
      {
         if(this.upgradePathDef != null)
         {
            return this.upgradePathDef.upgrades[param1][this.upgradePaths[param1]].cost;
         }
         return 0;
      }
      
      public function upgradePath(param1:int) : void
      {
         var _loc2_:UpgradeDef = null;
         var _loc3_:int = 0;
         var _loc4_:UpgradeDef = null;
         if(this.upgradePathDef != null)
         {
            this.upgradePaths[param1]++;
            _loc2_ = this.upgradePathDef.upgrades[param1][this.upgradePaths[param1] - 1];
            if(_loc2_.assign)
            {
               _loc3_ = 0;
               while(_loc3_ < this.upgradePaths[param1] - 1)
               {
                  _loc4_ = this.upgradePathDef.upgrades[param1][_loc3_];
                  this.removeUpgrade(_loc4_,false);
                  _loc3_++;
               }
               this.initialise(_loc2_.assign,this.level);
            }
            else
            {
               this.addUpgrade(_loc2_,true);
            }
            Main.instance.game.level.sigUpgradePurchaseSignal.dispatch(_loc2_);
            if(this.baseDef.id == "AircraftCarrier")
            {
               rotation = 0;
            }
         }
      }
      
      public function aimAtReticle(param1:Number, param2:Number) : void
      {
         FireAtReticle.SetLocation(this,param1,param2);
         var _loc3_:Vector2 = new Vector2();
         _loc3_.x = param1 - this.x;
         _loc3_.y = param2 - this.y;
         this.rotation = _loc3_.rotation;
      }
      
      public function scaleAttackSpeed(param1:Number) : void
      {
         param1 = Math.max(0,param1);
         this._attackSpeedModifier = this._attackSpeedModifier * param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.reloadTimers.length)
         {
            this.reloadTimers[_loc2_].speedModifier = this._attackSpeedModifier;
            _loc2_++;
         }
      }
      
      public function unScaleAttackSpeed(param1:Number) : void
      {
         if(this._attackSpeedModifier == 0 && param1 == 0)
         {
            this._attackSpeedModifier = 1;
         }
         else
         {
            this._attackSpeedModifier = this._attackSpeedModifier / param1;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.reloadTimers.length)
         {
            this.reloadTimers[_loc2_].speedModifier = this._attackSpeedModifier;
            _loc2_++;
         }
      }
      
      public function freeze(param1:Boolean) : void
      {
         this.isFrozen = param1;
      }
      
      public function addTemporaryAnimation(param1:Clip) : void
      {
         this.tempAddonClips.push(param1);
      }
      
      public function removeTemporaryAnimation(param1:Clip) : void
      {
         var _loc2_:int = this.tempAddonClips.indexOf(param1);
         if(_loc2_ !== -1)
         {
            this.tempAddonClips.splice(_loc2_,1);
         }
      }
   }
}
