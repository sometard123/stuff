package ninjakiwi.monkeyTown.btdModule.bloons
{
   import assets.projectile.IceShard;
   import assets.sound.CeramicBloonHit;
   import assets.sound.FrozenBloonHit;
   import assets.sound.MetalBloonHit;
   import assets.sound.MoabDamage1;
   import assets.sound.MoabDamage2;
   import assets.sound.MoabDamage3;
   import assets.sound.MoabDestroyedBig;
   import assets.sound.MoabDestroyedMed;
   import assets.sound.MoabDestroyedShort;
   import assets.sounds.Pop1;
   import assets.sounds.Pop2;
   import assets.sounds.Pop3;
   import assets.sounds.Pop4;
   import display.BloonClip;
   import flash.display.BitmapData;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.bloons.bossBloons.BossConstants;
   import ninjakiwi.monkeyTown.btdModule.effects.Burst;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.BigBloonSabotage;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorData;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.StraightTile;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.BurnEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.GlueEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.IceEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.StunEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.WindEffectDef;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   import ninjakiwi.monkeyTown.btdModule.weapons.Spread;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import org.osflash.signals.Signal;
   
   public class Bloon extends Entity
   {
      
      public static const INVALID:int = -1;
      
      public static const RED:int = 0;
      
      public static const BLUE:int = 1;
      
      public static const GREEN:int = 2;
      
      public static const YELLOW:int = 3;
      
      public static const PINK:int = 4;
      
      public static const BLACK:int = 5;
      
      public static const WHITE:int = 6;
      
      public static const ZEBRA:int = 7;
      
      public static const LEAD:int = 8;
      
      public static const RAINBOW:int = 9;
      
      public static const CERAMIC:int = 10;
      
      public static const MOAB:int = 11;
      
      public static const BFB:int = 12;
      
      public static const BOSS:int = 13;
      
      public static const DDT:int = 14;
      
      public static const BOSS_BLOONARIUS:int = 15;
      
      public static const BOSS_VORTEX:int = 16;
      
      public static const BOSS_BLASTAPOPOULOS:int = 17;
      
      public static const BOSS_DREADBLOON:int = 18;
      
      public static const BLOON_COUNT:int = 15; //number of bloon types?
      
      public static var burstsThisProcess:int = 0;
      
      public static const allBloonTypes:Vector.<int> = Vector.<int>([RED,BLUE,GREEN,YELLOW,PINK,BLACK,WHITE,ZEBRA,LEAD,RAINBOW,CERAMIC,MOAB,BFB,BOSS,DDT,BOSS_BLOONARIUS,BOSS_VORTEX,BOSS_BLASTAPOPOULOS,BOSS_DREADBLOON]);
      
      public static var eventDispatcher:EventDispatcher = new EventDispatcher();
      
      public static const baseSpeed:Number = 70;
      
      public static var difficultySpeedModifier:Number = 0;
      
      public static var baseSpeedModifier:Number = 1;
      
      protected static const maxDeltaRotation:Number = 0.12;
      
      public static const IMMUNITY_NONE:int = 0;
      
      public static const IMMUNITY_NO_DETECTION:int = 1;
      
      public static const IMMUNITY_ICE:int = 2;
      
      public static const IMMUNITY_GLUE:int = 4;
      
      public static const IMMUNITY_SPLOSION:int = 8;
      
      public static const IMMUNITY_WIND:int = 16;
      
      public static const IMMUNITY_LEAD:int = 32;
      
      public static const IMMUNITY_MOAB:int = 64;
      
      public static const IMMUNITY_BFB:int = 128;
      
      public static const IMMUNITY_ZOMG:int = 256;
      
      public static const IMMUNITY_ALL:int = 65535;
      
      public static const IMMUNITY_WITHOUT_NO_DETECTION:int = 4294967293;
      
      public static var postBossDestroyed:Boolean = false;
      
      protected static const maxHealthByTypeDefault:Vector.<int> = Vector.<int>([1,1,1,1,1,1,1,1,1,1,10,200,700,4000,300,6000,6000,6000,6000]);
      
      protected static var maxHealthMOABMultiplierCity1:Number = 0.66;
      
      protected static var maxHealthMOABMultiplierCity2:Number = 0.8;
      
      protected static var maxHealthByType:Vector.<int> = Vector.<int>([1,1,1,1,1,1,1,1,1,1,10,200 * maxHealthMOABMultiplierCity1,700 * maxHealthMOABMultiplierCity1,4000 * maxHealthMOABMultiplierCity1,300 * maxHealthMOABMultiplierCity1,6000,6000,6000,6000]);
      
      protected static const popsByType:Vector.<int> = Vector.<int>([1,2,3,4,5,11,11,23,23,47,95,381,1525,6101,381,6101,6101,6101,6101]);
      
      public static const speedMultiplierByType:Vector.<Number> = Vector.<Number>([1,1.4,1.8,3.2,3.5,1.8,2,1.8,1,2.2,2.5,1,0.25,0.18,3.5,0.1,0.18,0.14,0.14]);
      
      public static const baseImmunitiesByType:Vector.<int> = Vector.<int>([IMMUNITY_NONE,IMMUNITY_NONE,IMMUNITY_NONE,IMMUNITY_NONE,IMMUNITY_NONE,IMMUNITY_SPLOSION,IMMUNITY_ICE,IMMUNITY_ICE | IMMUNITY_SPLOSION,IMMUNITY_LEAD,IMMUNITY_NONE,IMMUNITY_NONE,IMMUNITY_GLUE | IMMUNITY_ICE | IMMUNITY_MOAB,IMMUNITY_GLUE | IMMUNITY_ICE | IMMUNITY_BFB,IMMUNITY_GLUE | IMMUNITY_ICE | IMMUNITY_ZOMG,IMMUNITY_SPLOSION | IMMUNITY_LEAD,IMMUNITY_NONE,IMMUNITY_NONE,IMMUNITY_NONE,IMMUNITY_SPLOSION | IMMUNITY_LEAD]);
      
      public static const isMOABFlags:Vector.<Boolean> = Vector.<Boolean>([false,false,false,false,false,false,false,false,false,false,false,true,true,true,true,false,false,false,false]);
      
      public static const isBossFlags:Vector.<Boolean> = Vector.<Boolean>([false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true,true]);
      
      public static const rbeByType:Vector.<int> = Vector.<int>([1,2,3,4,5,11,11,23,23,47,104,616,3164,16656,16656,16656,16656,16656,16656]);
      
      protected static const childTypeByType:Vector.<int> = Vector.<int>([-1,RED,BLUE,GREEN,YELLOW,PINK,PINK,BLACK,BLACK,ZEBRA,RAINBOW,CERAMIC,MOAB,BFB,CERAMIC,-1,-1,-1,-1]);
      
      protected static const childCountByType:Vector.<int> = Vector.<int>([1,1,1,1,1,2,2,2,2,2,2,4,4,4,6,0,0,0,0]);
      
      public static const targetRangeAddonsByType:Vector.<Number> = Vector.<Number>([0,0,0,0,0,0,0,0,0,0,0,60,110,140,140,BossConstants.BLOONARIUS_RADIUS,BossConstants.VORTEX_RADIUS,BossConstants.BLASTAPOPOULOS_RADIUS,BossConstants.DREADBLOON_RADIUS]);
      
      public static const popSounds:Vector.<MaxSound> = Vector.<MaxSound>([new MaxSound(Pop1),new MaxSound(Pop2),new MaxSound(Pop3),new MaxSound(Pop4)]);
      
      public static const WAVE_OF_DIFFICULTY_INCREASE:int = 31;
      
      public static const MOAB_HEALTH_INCREASE_PER_ROUND_PERCENT:Number = 0.25;
      
      public static const SPEED_INCREASE_PER_ROUND_PERCENT:Number = 0.05;
      
      public static const CERAMIC_HEALTH_AFTER_DIFFICULTY_INCREASE:int = 38;
      
      public static var sandstormActive:Boolean = false;
      
      public static var sandstormSpeedScale:Number = 1;
      
      protected static var zomgDestroySound:MaxSound = new MaxSound(MoabDestroyedBig);
      
      protected static var bfbDestroySound:MaxSound = new MaxSound(MoabDestroyedMed);
      
      protected static var moabDestroySound:MaxSound = new MaxSound(MoabDestroyedShort);
      
      public static var ceramicHitSound:MaxSound = new MaxSound(CeramicBloonHit);
      
      public static var frozenHitSound:MaxSound = new MaxSound(FrozenBloonHit);
      
      public static var leadHitSound:MaxSound = new MaxSound(MetalBloonHit);
      
      protected static var moabHitSounds:Vector.<MaxSound> = Vector.<MaxSound>([new MaxSound(MoabDamage1),new MaxSound(MoabDamage2),new MaxSound(MoabDamage3)]);
      
      public static var counter:uint = 0;
      
      public static const TUTORIAL_TYPE_INVALID:int = -1;
      
      public static const TUTORIAL_TYPE_BOOST_1:int = 1;
      
      public static const TUTORIAL_TYPE_BOOST_2:int = 2;
      
      public static const TUTORIAL_TYPE_RHS_1:int = 3;
      
      public static const TUTORIAL_TYPE_RHS_2:int = 4;
      
      public static const tutorialBloonSpawned:Signal = new Signal(int);
      
      public static var cashChanceModifier:Number = 1;
       
      
      public var sabotaged:Boolean = false;
      
      public var damageMultipler:Number = 1.0; //?
      
      protected var _tile:Tile;
      
      public var tileProgress:Number = 0;
      
      public var progressStep:Number;
      
      public var overallProgress:Number = 0;
      
      public var clip:BloonClip;
      
      public var type:int = -1;
      
      public var maxHealth:int;
      
      public var health:int;
      
      public var extraDamagePrecision:Number = 0;
      
      public var isMOAB:Boolean = false;
      
      public var isBoss:Boolean = false;
      
      public var isHuge:Boolean = false; //huge means is either moab or boss
      
      public var isMoving:Boolean = true;
      
      public var isMovingBackward:Boolean = false;
      
      public var isShielded:Boolean = false; //for dreadbloon only
      
      public var rbe:int;
      
      public var immunity:int = 0;
      
      public var isCamo:Boolean = false;
      
      public var isRegen:Boolean = false;
      
      protected var regenCeiling:int = 0;
      
      protected var regenCountDown:Number = 3;
      
      protected var regenInterval:Number = 3;
      
      public var isChild:Boolean = false;
      
      public var radius:Number = 0;
      
      public var collisionCellIndex:int = -1;
      
      public var squareDistanceFromTestTower:Number = 0;
      
      public var targetAddon:Number = 0;
      
      public var childrenRangeThisFrame:Vector.<Bloon>;
      
      protected const windLayer:int = 3;
      
      protected var moabLayer:int = 1200;
      
      public var iced:Boolean = false;
      
      protected var iceCountdown:Number = 0;
      
      protected var permaFrostSpeedScale:Number = 1;
      
      protected var viralIce:Boolean = false;
      
      public var viralDepth:int = 0;
      
      protected var iceShards:Boolean = false;
      
      protected var freezeLayers:int = 1;
      
      protected var arcticWind:Number = 1;
      
      protected var arcticWindCountdown:int = 0;
      
      public var icedBy:Tower = null;
      
      public var glueTower:Tower = null;
      
      protected var glued:Boolean = false;
      
      protected var glueCountdown:Number = 0;
      
      protected var glueCorrosionInterval:Number = 0;
      
      protected var glueCorrosionCountDown:Number = 0;
      
      protected var glueSpeedScale:Number = 1;
      
      protected var glueSoak:Boolean = false;
      
      protected var glueCash:Number = 1;
      
      public var glueEffectDef:GlueEffectDef = null;
      
      protected var stunned:Boolean = false;
      
      protected var stunInherited:Boolean = false;
      
      protected var stunCountDown:Number = 0;
      
      protected var burnTower:Tower = null;
      
      protected var burning:Boolean = false;
      
      protected var burnCountDown:Number = 0;
      
      protected var burnInterval:Number = 0;
      
      protected var burnLifeSpan:Number = 0;
      
      protected var burnCash:Number = 0;
      
      public var cashAwarded:Vector.<Boolean>;
      
      public var layersPoppedThisFrame:Vector.<int>;
      
      protected var wasWhite:Boolean = false;
      
      public var id:uint = 0;
      
      public var lifetimeID:uint = 4.294967295E9;
      
      public var parentIDs:Vector.<uint>;
      
      public var level:Level = null;
      
      public var alreadyAdded:Boolean = false;
      
      protected var _popCountToAddFromSplit:int = 0;
      
      public var cashPerPopScale:Number = 1;
      
      protected var _timeStamp:Number = -1;
      
      public var movementDirection:Vector2;
      
      public var windDirectionSpeedScale:Number = 1.0;
      
      protected var lastPosition:Vector2;
      
      public function Bloon()
      {
         this.clip = Pool.get(BloonClip);
         this.childrenRangeThisFrame = new Vector.<Bloon>();
         this.cashAwarded = Bloon.defaultBoolVector(false);
         this.layersPoppedThisFrame = Bloon.defaultIntVector();
         this.parentIDs = new Vector.<uint>();
         this.movementDirection = new Vector2();
         this.lastPosition = new Vector2();
         super();
      }
      
      public static function defaultBoolVector(param1:Boolean = false) : Vector.<Boolean> //probably has to do with rewarding cash
      {
         var _loc2_:Vector.<Boolean> = new Vector.<Boolean>();
         var _loc3_:int = 0;
         while(_loc3_ < BLOON_COUNT)
         {
            _loc2_.push(param1);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function defaultIntVector() : Vector.<int>
      {
         var _loc1_:Vector.<int> = new Vector.<int>();
         var _loc2_:int = 0;
         while(_loc2_ < BLOON_COUNT)
         {
            _loc1_.push(0);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function calculateCashChance() : Number
      {
         var _loc1_:BTDGameRequest = Main.instance.game.gameRequest;
         var _loc2_:Number = calculateBaseCashChance();
         if(_loc1_ && _loc1_.isBloonBeacon)
         {
            _loc2_ = calculateBloonBeaconCashChance();
         }
         return _loc2_;
      }
      
      public static function calculateBloonBeaconCashChance() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = Main.instance.game.level.roundIndex;
         var _loc3_:Number = calculateSlidingCashNerfFactor();
         if(_loc2_ > 13 + _loc3_)
         {
            _loc1_ = 0.1 * cashChanceModifier;
         }
         else if(_loc2_ > 11 + _loc3_)
         {
            _loc1_ = 0.5 * cashChanceModifier;
         }
         else if(_loc2_ > 7 + _loc3_)
         {
            _loc1_ = 0.75 * cashChanceModifier;
         }
         else if(_loc2_ > 5 + _loc3_)
         {
            _loc1_ = cashChanceModifier;
         }
         else
         {
            _loc1_ = 1.1 * cashChanceModifier;
         }
         _loc1_ = _loc1_ * Constants.BLOON_BEACON_CASH_MODIFIER.value;
         return _loc1_;
      }
      
      public static function calculateSlidingCashNerfFactor() : Number
      {
         var _loc1_:Number = 6 - Main.instance.game.gameRequest.difficulty * 0.15;
         _loc1_ = Math.round(_loc1_);
         return _loc1_;
      }
      
      public static function calculateBaseCashChance() : Number
      {
         var _loc1_:int = Main.instance.game.level.roundIndex;
         if(Main.instance.lastGameRequest.bossAttack !== null)
         {
            _loc1_ = _loc1_ * 2;
         }
         var _loc2_:Number = calculateSlidingCashNerfFactor(); //changing cash from bloons
         if(RoundGeneratorData.isHardcore)
         {
            if(_loc1_ > 26 + _loc2_)
            {
               return 0.05 * cashChanceModifier;
            }
            if(_loc1_ > 21 + _loc2_)
            {
               return 0.2 * cashChanceModifier;
            }
            if(_loc1_ > 14 + _loc2_)
            {
               return 0.5 * cashChanceModifier;
            }
            return cashChanceModifier * 1;
         }
         if(_loc1_ > 26 + _loc2_)
         {
            return 0.05 * cashChanceModifier;
         }
         if(_loc1_ > 21 + _loc2_)
         {
            return 0.2 * cashChanceModifier;
         }
         if(_loc1_ > 14 + _loc2_)
         {
            return 0.65 * cashChanceModifier;
         }
         if(_loc1_ > 10 + _loc2_)
         {
            return cashChanceModifier;
         }
         return cashChanceModifier * 1.1;
      }
      
      public static function setMOABHealthModifier(param1:Number) : void //probably scaling moab health based on city, param1 is city multiplier?
      {
         maxHealthByType = maxHealthByTypeDefault.slice(); 
         var _loc2_:int = MOAB;
         while(_loc2_ <= DDT)
         {
            maxHealthByType[_loc2_] = maxHealthByType[_loc2_] * param1;
            _loc2_++;
         }
      }
      
      public static function furtherScaleMOABHealth(param1:Number) : void //similar to setMOABHealthModifier
      {
         var _loc2_:int = MOAB;
         while(_loc2_ <= DDT)
         {
            maxHealthByType[_loc2_] = maxHealthByType[_loc2_] * param1;
            _loc2_++;
         }
      }
      
      public static function isMOABClass(param1:int) : Boolean
      {
         return isMOABFlags[param1];
      }
      
      public static function isBossClass(param1:int) : Boolean
      {
         return isBossFlags[param1];
      }
      
      public static function isHugeClass(param1:int) : Boolean
      {
         return isMOABFlags[param1] || isBossFlags[param1];
      }
      
      public function initialise(param1:Level, param2:int, param3:Tile, param4:Number, param5:Boolean = false, param6:Boolean = false, param7:Number = -1) : void
      {
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         this.level = param1;
         this.id = counter++;
         this.lifetimeID = this.id;
         this.isRegen = param5;
         this.damageMultipler = 1;
         this.overallProgress = 0;
         this.extraDamagePrecision = 0;
         this._timeStamp = param7;
         this.wasWhite = false;
         this.tile = param3;
         this.tileProgress = param4;
         this.windDirectionSpeedScale = 1;
         param3.updateBloonPosition(this);
         this.collisionCellIndex = param1.collisionGrid.getCellIndex(x,y);
         this.parentIDs.splice(0,this.parentIDs.length);
         this.clip.camoVisible = this.isCamo = param6 && param2 < MOAB;
         this.clip.regenVisible = this.isRegen = param5 && param2 < MOAB;
         if(param2 == DDT)
         {
            this.isCamo = true;
            this.clip.camoVisible = true;
            this.clip.setFrame(param2,this.health);
         }
         if(Level.camoDisabled)
         {
            this.isCamo = false;
            this.clip.camoVisible = false;
            this.clip.setFrame(param2,this.health);
         }
         this.resetStatusEffects();
         this.regenCeiling = param2;
         this.setType(param2);
         if(this.isBoss)
         {
            this.sabotaged = false;
         }
         else
         {
            this.sabotaged = param1.sabotageBloons;
         }
         var _loc8_:int = 0;
         while(_loc8_ < BLOON_COUNT)
         {
            this.cashAwarded[_loc8_] = false;
            _loc8_++;
         }
         if(param2 == BLACK || param2 == WHITE)
         {
            _loc11_ = WHITE + 1;
            while(_loc11_ < BLOON_COUNT)
            {
               this.cashAwarded[_loc11_] = true;
               _loc11_++;
            }
         }
         else
         {
            _loc12_ = param2 + 1;
            while(_loc12_ < BLOON_COUNT)
            {
               this.cashAwarded[_loc12_] = true;
               _loc12_++;
            }
         }
         var _loc9_:Vector2 = param3.wayPoints[0];
         var _loc10_:Vector2 = param3.wayPoints[1];
         rotation = Math.atan2(_loc10_.y - _loc9_.y,_loc10_.x - _loc9_.x);
      }
      
      public function setType(param1:int) : void //freeplay changes
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         this.type = param1;
         this.isMOAB = isMOABFlags[param1];
         this.isBoss = isBossFlags[param1];
         this.isHuge = this.isMOAB || this.isBoss; //yeah, huge means either moab or boss
         this.health = this.maxHealth = maxHealthByType[param1];
         this.extraDamagePrecision = 0;
         var _loc2_:int = Main.instance.game.waveIndex + 1;
         this.progressStep = baseSpeed * (speedMultiplierByType[param1] + difficultySpeedModifier);
         this.progressStep = this.progressStep * baseSpeedModifier;
         if(_loc2_ >= WAVE_OF_DIFFICULTY_INCREASE)
         {
            _loc3_ = _loc2_ - WAVE_OF_DIFFICULTY_INCREASE;
            _loc4_ = 1 + SPEED_INCREASE_PER_ROUND_PERCENT * (_loc3_ + 1);
            this.progressStep = this.progressStep * _loc4_;
            if(param1 == CERAMIC)
            {
               this.health = this.maxHealth = CERAMIC_HEALTH_AFTER_DIFFICULTY_INCREASE;
            }
            else if(this.isMOAB)
            {
               this.health = this.maxHealth = this.health * (1 + MOAB_HEALTH_INCREASE_PER_ROUND_PERCENT * (_loc3_ + 1));
            }
         }
         if(this.isMOAB)
         {
            this.progressStep = this.progressStep * BigBloonSabotage.instance.moabSpeedPercent;
         }
         this.rbe = rbeByType[param1];
         this.clip.setFrame(param1,this.health / this.maxHealth);
         this.radius = this.clip.radius;
         this.targetAddon = targetRangeAddonsByType[param1];
         if(param1 == WHITE)
         {
            this.wasWhite = true;
         }
         else if(param1 == ZEBRA)
         {
            this.wasWhite = false;
         }
         this.calculateImmunity();
         if(this.isHuge) //unsure what this is
         {
            z = this.moabLayer + this.zOffset;
         }
         else if(this.tile)
         {
            z = this.tile.layer + this.zOffset;
         }
         else
         {
            z = this.zOffset;
         }
      }
      
      public function get zOffset() : Number //tard what
      {
         return this.id * -1.0e-6 - 0.001;
      }
      
      protected function calculateImmunity() : void
      {
         if(this.type == -1)
         {
            return;
         }
         this.immunity = baseImmunitiesByType[this.type];
         if(this.isCamo)
         {
            this.immunity = this.immunity | IMMUNITY_NO_DETECTION;
         }
         if(this.glueCountdown != 0)
         {
            this.immunity = this.immunity | IMMUNITY_GLUE;
         }
      }
      
      public function resetStatusEffects() : void
      {
         this.resetIce();
         this.permaFrostSpeedScale = 1;
         this.resetGlue();
         this.stunned = false;
         this.clip.stunVisible = false;
         this.burning = false;
         this.clip.burnyStuffVisible = false;
         this.stunCountDown = 0;
      }
      
      public function resetIce() : void
      {
         this.iced = false;
         this.clip.iceVisible = false;
         this.iceCountdown = 0;
         this.viralIce = false;
         this.iceShards = false;
         this.freezeLayers = 1;
         this.viralDepth = 0;
      }
      
      public function resetGlue() : void
      {
         this.glued = false;
         this.glueEffectDef = null;
         this.clip.glueState = 0;
         this.glueCountdown = 0;
         this.glueCorrosionInterval = 0;
         this.glueCorrosionCountDown = 0;
         this.glueSpeedScale = 1;
         this.glueSoak = false;
      }
      
      public function completePath() : void //leaking
      {
         this.level.bloonLeaked(this);
         this.destroy();
      }
      
      override public function process(param1:Number) : void //processes status effects
      {
         var _loc4_:Vector.<Vector.<Bloon>> = null;
         var _loc5_:Vector.<Bloon> = null;
         var _loc6_:Bloon = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(this.level == null)
         {
            return;
         }
         if(this.tile == null || this.type == -1)
         {
            return;
         }
         var _loc2_:Number = Math.max(6.6 * ((Main.instance.game.waveIndex - 85) / (200 - 85)),1);
         if(this.sabotaged)
         {
            _loc2_ = _loc2_ * 0.5;
         }
         if(this.arcticWindCountdown > 0)
         {
            this.arcticWindCountdown--;
            _loc2_ = _loc2_ * this.arcticWind;
            if(this.arcticWindCountdown <= 0)
            {
               this.arcticWindCountdown = 0;
               this.arcticWind = 1;
            }
         }
         if(this.stunned)
         {
            _loc2_ = _loc2_ * 0;
            this.stunCountDown = this.stunCountDown - param1;
            if(this.stunCountDown <= 0)
            {
               this.stunCountDown = 0;
               this.stunned = false;
               this.clip.stunVisible = false;
            }
         }
         if(this.iced)
         {
            _loc2_ = _loc2_ * 0;
            this.iceCountdown = this.iceCountdown - param1;
            if(this.iceCountdown <= 0)
            {
               this.resetIce();
               this.calculateImmunity();
            }
            else if(this.viralIce && this.viralDepth > 0)
            {
               _loc4_ = this.level.collisionGrid.getCellAndAdjacentCells(x,y);
               for each(_loc5_ in _loc4_)
               {
                  for each(_loc6_ in _loc5_)
                  {
                     if(!(_loc6_.iced || _loc6_.isHuge || this.viralDepth <= 0))
                     {
                        _loc7_ = _loc6_.x - x;
                        _loc8_ = _loc6_.y - y;
                        _loc9_ = _loc7_ * _loc7_ + _loc8_ * _loc8_;
                        _loc10_ = this.radius + _loc6_.radius - 20;
                        if(_loc10_ * _loc10_ >= _loc9_)
                        {
                           _loc6_.catchIce(this);
                        }
                     }
                  }
               }
            }
         }
         if(this.glued)
         {
            if(this.type != CERAMIC)
            {
               _loc2_ = _loc2_ * this.glueSpeedScale;
            }
            this.glueCountdown = this.glueCountdown - param1;
            if(this.glueCountdown <= 0)
            {
               this.glueCountdown = 0;
               this.glued = false;
               this.glueEffectDef = null;
               this.clip.glueState = 0;
               this.calculateImmunity();
            }
            if(this.glueCorrosionInterval != 0)
            {
               this.glueCorrosionCountDown = this.glueCorrosionCountDown - param1;
               if(this.glueCorrosionCountDown <= 0)
               {
                  this.glueCorrosionCountDown = this.glueCorrosionInterval;
                  this.damage(1,this.glueCash,this.glueTower);
               }
            }
         }
         if(this.burning)
         {
            this.burnCountDown = this.burnCountDown - param1;
            if(this.burnCountDown <= 0)
            {
               this.burnCountDown = this.burnInterval;
               this.damage(1,this.burnCash,this.burnTower);
            }
            this.burnLifeSpan = this.burnLifeSpan - param1;
            if(this.burnLifeSpan <= 0)
            {
               this.burning = false;
               this.clip.burnyStuffVisible = false;
            }
         }
         if(sandstormActive)
         {
            _loc2_ = _loc2_ * sandstormSpeedScale;
         }
         this.lastPosition.x = x;
         this.lastPosition.y = y;
         if(this.tile == null || this.type == -1)
         {
            return;
         }
         if(this.tile.transitionType == Tile.stickysap)
         {
            _loc2_ = _loc2_ * 0.5;
         }
         if(this.isMoving || this.isMovingBackward) //calculate movement
         {
            this.tileProgress = this.tileProgress + this.progressStep * param1 * _loc2_ * this.permaFrostSpeedScale * this.windDirectionSpeedScale;
            this.overallProgress = this.overallProgress + this.progressStep * param1 * _loc2_ * this.permaFrostSpeedScale * this.windDirectionSpeedScale;
            this.tile.updateBloonPosition(this);
            if(this.type == -1)
            {
               return;
            }
         }
         if(this.isHuge && this.lastPosition.x != x || this.lastPosition.y != y) //if it's a moab/boss and moving, i think it processes moab roatation
         {
            _loc11_ = Math.atan2(y - this.lastPosition.y,x - this.lastPosition.x);
            if(this.isMovingBackward)
            {
               _loc11_ = _loc11_ + Math.PI;
            }
            while(_loc11_ - rotation > Math.PI)
            {
               _loc11_ = _loc11_ - 2 * Math.PI;
            }
            while(_loc11_ - rotation <= -Math.PI)
            {
               _loc11_ = _loc11_ + 2 * Math.PI;
            }
            _loc12_ = maxDeltaRotation;
            if(this.type === Bloon.DDT)
            {
               _loc12_ = _loc12_ * 5;
            }
            if(_loc11_ > rotation)
            {
               rotation = Math.min(_loc11_,rotation + _loc12_);
            }
            else if(_loc11_ < rotation)
            {
               rotation = Math.max(_loc11_,rotation - _loc12_);
            }
         }
         var _loc3_:int = this.collisionCellIndex;
         this.collisionCellIndex = this.level.collisionGrid.getCellIndex(x,y);
         if(this.collisionCellIndex != _loc3_ && this.type != -1 && this.tile != null)
         {
            if(false == this.isBoss || this.collisionCellIndex !== -1)
            {
               this.level.collisionGrid.switchCells(this,_loc3_,this.collisionCellIndex);
            }
         }
         if(this.isRegen)
         {
            if(!this.iced)
            {
               if(this.regenCeiling != this.type) //controls when to regrow
               {
                  this.regenCountDown = this.regenCountDown - param1;
                  if(this.regenCountDown <= 0)
                  {
                     this.regenCountDown = this.regenCountDown + this.regenInterval;
                     this.regenerate();
                  }
               }
            }
         }
      }
      
      public function catchIce(param1:Bloon) : void //sets status effects upon freezing?
      {
         if(this.type == WHITE || this.type == ZEBRA)
         {
            return;
         }
         this.iced = true;
         this.clip.iceVisible = true;
         this.iceCountdown = param1.iceCountdown;
         this.permaFrostSpeedScale = param1.permaFrostSpeedScale;
         this.viralIce = param1.viralIce;
         this.iceShards = param1.iceShards;
         this.icedBy = param1.icedBy;
         this.freezeLayers = param1.freezeLayers;
         this.viralDepth = param1.viralDepth - 1;
         param1.viralDepth = 0;
         this.calculateImmunity();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this.isHuge)
         {
            this.clip.drawRotated(param1,x,y,rotation);
         }
         else
         {
            this.clip.quickDraw(param1,x,y);
         }
      }
      
      public function hitPreviously(param1:Projectile) : Boolean //prevents one projectile from popping the same bloon twice
      {
         var _loc2_:uint = 0;
         if(param1.def.canMultiEffect)
         {
            return false;
         }
         if(param1.hitBloons.indexOf(this.id) != -1)
         {
            return true;
         }
         for each(_loc2_ in this.parentIDs)
         {
            if(param1.hitBloons.indexOf(_loc2_) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function handleCollision(param1:Projectile) : void
      {
         var _loc7_:IceEffectDef = null;
         var _loc8_:GlueEffectDef = null;
         var _loc9_:BurnEffectDef = null;
         var _loc10_:WindEffectDef = null;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Vector2 = null;
         var _loc15_:Vector.<Tile> = null;
         var _loc16_:Tile = null;
         var _loc17_:Vector2 = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:StraightTile = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:int = 0;
         this.layersPoppedThisFrame.length = 0;
         var _loc2_:int = this.type;
         var _loc3_:Tower = param1.owner;
         var _loc4_:DamageEffectDef = param1.buffedDamageEffect;
         var _loc5_:Number = param1.def.popCashScale;
         this.cashPerPopScale = _loc5_;
         if(this.type < Bloon.MOAB)
         {
            _loc7_ = param1.def.iceEffect;
            _loc8_ = param1.def.glueEffect;
            _loc9_ = param1.def.burnEffect;
            _loc10_ = param1.def.windEffect;
         }
         var _loc6_:StunEffectDef = param1.def.stunEffect;
         if(_loc4_ != null)
         {
            _loc11_ = _loc4_.cantBreak == null || _loc4_.cantBreak.indexOf(this.type) == -1;
            _loc12_ = this.iced == false || _loc4_.canBreakIce;
            if(this.type === BOSS_DREADBLOON && this.isShielded)
            {
               _loc11_ = true;
            }
            if(_loc11_ && _loc12_)
            {
               param1.hitBloons.push(this.id);
            }
            else if(this.iced)
            {
               frozenHitSound.play();
               param1.pierce = 0;
            }
            else if(this.type == LEAD || this.type == DDT || this.type == BOSS_DREADBLOON)
            {
               leadHitSound.play();
               param1.pierce = 0;
            }
         }
         else
         {
            param1.hitBloons.push(this.id);
         }
         if(param1.def.removeCamo)
         {
            this.clip.camoVisible = this.isCamo = false;
            this.calculateImmunity();
         }
         if(param1.def.removeRegen && this.isRegen)
         {
            this.clip.regenVisible = this.isRegen = false;
            this.clip.setFrame(this.type,this.health / this.maxHealth);
         }
         if(_loc7_ != null)
         {
            this.icedBy = param1.owner;
            if(_loc7_.lifespan != 0)
            {
               this.iced = true;
               this.clip.iceVisible = true;
               this.iceCountdown = _loc7_.lifespan;
               this.permaFrostSpeedScale = _loc7_.permafrost;
               this.viralIce = _loc7_.viral;
               this.viralDepth = 40;
               this.freezeLayers = _loc7_.freezeLayers;
               this.calculateImmunity();
               if(this.viralIce)
               {
                  ViralIceHack.addEffect(this,param1);
               }
            }
            this.arcticWind = _loc7_.arcticWind;
            this.arcticWindCountdown = 3;
         }
         if(_loc8_ != null)
         {
            this.glueTower = _loc3_;
            this.glueEffectDef = _loc8_;
            this.glued = true;
            this.clip.glueState = 1;
            this.glueCountdown = _loc8_.lifespan;
            this.glueSpeedScale = _loc8_.speedScale;
            this.glueCorrosionInterval = _loc8_.corosionInterval;
            this.glueCorrosionCountDown = this.glueCorrosionInterval;
            this.glueSoak = _loc8_.soak;
            this.glueCash = _loc5_;
            this.calculateImmunity();
            if(this.glueCorrosionInterval != 0 && this.glueCorrosionInterval <= 1)
            {
               this.clip.glueState = 2;
            }
         }
         if(_loc9_ != null)
         {
            _loc13_ = _loc9_.cantBurn == null || _loc9_.cantBurn.indexOf(this.type) == -1;
            if(_loc13_)
            {
               this.burnTower = _loc3_;
               this.clip.burnyStuffVisible = true;
               this.burnLifeSpan = _loc9_.lifespan;
               this.burnInterval = _loc9_.burnInterval;
               if(!this.burning)
               {
                  this.burnCountDown = this.burnInterval;
               }
               this.burning = true;
               this.burnCash = _loc5_;
            }
         }
         if(_loc10_ != null && Math.random() <= _loc10_.chance && this.type != LEAD && this.type < MOAB)
         {
            _loc14_ = new Vector2(x,y);
            _loc15_ = new Vector.<Tile>();
            this.tile.getAllPreviousTiles(_loc15_);
            if(_loc15_.length != 0)
            {
               _loc16_ = _loc15_[Math.floor(Math.random() * _loc15_.length)];
               _loc17_ = _loc16_.wayPoints[0];
               _loc18_ = _loc17_.x - _loc14_.x;
               _loc19_ = _loc17_.y - _loc14_.y;
               _loc20_ = Math.sqrt(_loc18_ * _loc18_ + _loc19_ * _loc19_);
               _loc21_ = new StraightTile();
               _loc21_.isWind = true;
               _loc21_.layer = this.windLayer;
               _loc21_.wayPoints = Vector.<Vector2>([_loc14_,_loc17_]);
               _loc21_.sectionLength = _loc21_.tileLength = _loc20_;
               _loc21_.nextTiles.push(_loc16_);
               this.tile = _loc21_;
               this.tileProgress = 0;
               this.overallProgress = 0;
               this.level.sortDrawList = true;
               if(param1.owner.rootID != "NinjaMonkey")
               {
                  this.resetGlue();
                  this.resetIce();
               }
               this.calculateImmunity();
            }
         }
         if(_loc4_ != null)
         {
            if(_loc11_ && _loc12_)
            {
               _loc22_ = _loc4_.damage;
               _loc23_ = _loc4_.purgeRegenChance;
               if(this.isMOAB)
               {
                  _loc22_ = _loc22_ * _loc4_.moabScale;
               }
               if(this.isBoss)
               {
                  _loc22_ = _loc22_ * _loc4_.bossScale;
               }
               if(this.isHuge)
               {
                  _loc22_ = _loc22_ * _loc4_.hugeScale;
               }
               if(this.type == Bloon.CERAMIC)
               {
                  _loc22_ = _loc22_ * _loc4_.ceramicScale;
                  _loc22_ = _loc22_ + _loc4_.ceramicAdd;
               }
               if(this.isRegen)
               {
                  if(param1.numOfRegenPurged < param1.def.numOfRegenBloonsPurged)
                  {
                     this.purgeRegen();
                     param1.numOfRegenPurged = param1.numOfRegenPurged + 1;
                  }
                  else if(Rndm.float(0,1) < _loc23_)
                  {
                     this.purgeRegen();
                  }
               }
               _loc24_ = int(_loc22_);
               this.extraDamagePrecision = this.extraDamagePrecision + _loc22_ % 1;
               _loc24_ = _loc24_ + int(this.extraDamagePrecision);
               this.extraDamagePrecision = this.extraDamagePrecision % 1;
               if(_loc4_.kill && this.type < MOAB)
               {
                  this.kill(_loc5_,_loc3_,_loc4_.showPop);
               }
               else if(_loc4_.peelLayer && this.type < MOAB)
               {
                  this.degrade(1,_loc5_,_loc3_,_loc4_.showPop);
               }
               else
               {
                  this.damage(_loc24_,_loc5_,_loc3_,_loc4_.showPop);
               }
            }
         }
         if(_loc6_ != null && this.isBoss === false)
         {
            if((_loc6_.cantEffect == null || _loc6_.cantEffect.indexOf(this.type) == -1) && _loc6_.isStunning(param1))
            {
               this.stunned = true;
               this.clip.stunVisible = true;
               this.stunInherited = _loc6_.inherit;
               this.stunCountDown = _loc6_.lifespan;
               if(this.type == BOSS || this.type == DDT)
               {
                  this.stunCountDown = Math.min(this.stunCountDown,0.5);
               }
               else if(this.type == BFB)
               {
                  this.stunCountDown = Math.min(this.stunCountDown,2);
               }
               this.calculateImmunity();
            }
         }
         if(_loc7_ != null)
         {
            this.icedBy = param1.owner;
            this.iceShards = _loc7_.shards;
         }
      }
      
      public function purgeRegen() : void
      {
         this.isRegen = false;
         this.clip.regenVisible = false;
         if(this.type != -1)
         {
            this.clip.setFrame(this.type,this.health / this.maxHealth);
         }
      }
      
      public function damage(param1:int, param2:Number, param3:Tower, param4:Boolean = true) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = this.health;
         var _loc7_:int = param1 * this.damageMultipler;
         if(this.isShielded)
         {
            eventDispatcher.dispatchEvent(new BloonEvent(BloonEvent.DAMAGE_SHIELD,this,_loc7_,0,param3));
            return;
         }
         if(false === this.isBoss)
         {
            while(param1 > 0 && this.type - _loc5_ >= CERAMIC)
            {
               _loc6_--;
               param1--;
               if(_loc6_ <= 0)
               {
                  _loc5_++;
                  _loc6_ = maxHealthByType[this.type - _loc5_];
               }
            }
            _loc5_ = _loc5_ + param1;
         }
         else
         {
            _loc6_ = Math.max(0,this.health - param1);
            if(false == postBossDestroyed && _loc6_ === 0)
            {
               eventDispatcher.dispatchEvent(new BloonEvent(BloonEvent.BOSS_DESTROYED,this,1,0));
               postBossDestroyed = true;
            }
         }
         if(_loc5_ != 0 && false === this.isBoss)
         {
            this.degrade(_loc5_,param2,param3,param4);
         }
         else
         {
            if(this.type == CERAMIC)
            {
               ceramicHitSound.play();
            }
            else if(this.isHuge)
            {
               moabHitSounds[Math.floor(moabHitSounds.length * Math.random())].play(25);
            }
            this.health = _loc6_;
            this.clip.setFrame(this.type,this.health / this.maxHealth);
         }
         eventDispatcher.dispatchEvent(new BloonEvent(BloonEvent.DAMAGE,this,_loc7_,0,param3));
      }
      
      public function kill(param1:Number, param2:Tower, param3:Boolean = true) : void
      {
         this.degrade(this.type + 1,param1,param2,param3);
      }
      
      public function degrade(param1:int, param2:Number, param3:Tower, param4:Boolean = true) : void //popping bloons
      {
         var _loc10_:Burst = null;
         var _loc11_:Boolean = false;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Bloon = null;
         var _loc16_:Number = NaN;
         if(this.type < 0)
         {
            return;
         }
         param1 = param1 > this.type + 1?int(this.type + 1):int(param1);
         if(param4 && burstsThisProcess < 15)
         {
            popSounds[int(Math.random() * 4)].play();
            burstsThisProcess++;
            _loc10_ = Pool.get(Burst);
            _loc10_.initialise(x,y,this.level);
         }
         if(this.type == DDT)
         {
            zomgDestroySound.play();
         }
         else if(this.type == BOSS)
         {
            zomgDestroySound.play();
         }
         else if(this.type == BFB)
         {
            bfbDestroySound.play();
         }
         else if(this.type == MOAB)
         {
            moabDestroySound.play();
         }
         var _loc5_:int = -1;
         var _loc6_:int = this.type;
         var _loc7_:Number = 0;
         var _loc8_:int = 0;
         this.childrenRangeThisFrame.length = 0;
         this.childrenRangeThisFrame.push(this);
         while(param1 > 0)
         {
            _loc11_ = false;
            _loc12_ = 0;
            while(_loc12_ < this.childrenRangeThisFrame.length)
            {
               if(this.childrenRangeThisFrame[_loc12_].type == RED)
               {
                  if(false == this.cashAwarded[RED])
                  {
                     this.cashAwarded[RED] = true;
                     _loc7_++;
                  }
                  _loc8_++;
                  eventDispatcher.dispatchEvent(new BloonEvent(BloonEvent.PRE_DEGRADE,this.childrenRangeThisFrame[_loc12_],1,0));
                  this.childrenRangeThisFrame[_loc12_].destroy();
                  _loc11_ = true;
               }
               _loc12_++;
            }
            if(_loc11_)
            {
               break;
            }
            if(!this.glueSoak)
            {
               this.resetGlue();
               this.calculateImmunity();
            }
            if(this.iced)
            {
               if(this.iceShards)
               {
                  this.shardsPop();
               }
               this.freezeLayers--;
               if(this.freezeLayers == 0)
               {
                  this.resetIce();
                  this.calculateImmunity();
               }
            }
            else
            {
               this.permaFrostSpeedScale = 1;
            }
            if(!this.stunInherited && this.stunned)
            {
               this.stunned = false;
               this.stunCountDown = 0;
               this.clip.stunVisible = false;
            }
            _loc13_ = this.childrenRangeThisFrame.length;
            _loc14_ = 0;
            while(_loc14_ < _loc13_)
            {
               _loc15_ = this.childrenRangeThisFrame[_loc14_];
               if(_loc15_.isRegen)
               {
                  if(_loc15_.regenCeiling == BLACK || _loc15_.regenCeiling == WHITE)
                  {
                     if(_loc15_.type == BLACK || _loc15_.type == WHITE)
                     {
                        _loc15_.regenCountDown = this.regenInterval;
                     }
                  }
                  else if(_loc15_.regenCeiling == _loc15_.type)
                  {
                     _loc15_.regenCountDown = this.regenInterval;
                  }
               }
               if(childCountByType[this.childrenRangeThisFrame[_loc14_].type] != 1)
               {
                  this._popCountToAddFromSplit = 0;
                  _loc7_ = _loc7_ + _loc15_.splitToChildren(this);
                  _loc8_ = _loc8_ + this._popCountToAddFromSplit;
               }
               if(_loc15_.cashAwarded[_loc15_.type] == false)
               {
                  _loc7_++;
                  _loc15_.cashAwarded[_loc15_.type] = true;
               }
               if(_loc15_.type == BLACK || _loc15_.type == WHITE)
               {
                  _loc15_.cashAwarded[BLACK] = true;
                  _loc15_.cashAwarded[WHITE] = true;
               }
               else if(_loc15_.type == LEAD)
               {
                  _loc15_.cashAwarded[ZEBRA] = true;
                  _loc15_.cashAwarded[WHITE] = true;
               }
               _loc6_ = childTypeByType[_loc15_.type];
               if(_loc15_ == this)
               {
                  if(_loc15_.type == DDT)
                  {
                     _loc6_ = Bloon.CERAMIC;
                     _loc15_.isCamo = Level.camoDisabled != true;
                     _loc15_.clip.camoVisible = Level.camoDisabled != true;
                     _loc15_.isRegen = true;
                     _loc15_.regenCeiling = Bloon.CERAMIC;
                     _loc15_.clip.regenVisible = true;
                     _loc15_.clip.setFrame(_loc6_,_loc15_.health);
                  }
                  if(this.isHuge && _loc6_ < MOAB)
                  {
                     this.level.sortDrawList = true;
                  }
               }
               eventDispatcher.dispatchEvent(new BloonEvent(BloonEvent.PRE_DEGRADE,_loc15_,1));
               _loc15_.setType(_loc6_);
               _loc8_++;
               _loc14_++;
            }
            param1--;
         }
         var _loc9_:int = 1;
         while(_loc9_ < this.childrenRangeThisFrame.length)
         {
            _loc16_ = _loc9_ * Math.min(60 / (this.childrenRangeThisFrame.length - 1),20);
            this.childrenRangeThisFrame[_loc9_].tileProgress = this.tileProgress - _loc16_;
            _loc9_++;
         }
         this.postDegrade(param3,_loc8_,_loc7_);
         this.parentIDs.push(this.id);
         this.id = counter++;
      }
      
      protected function postDegrade(param1:Tower, param2:int, param3:int) : void
      {
         if(param1 != null)
         {
            param1.popCount = param1.popCount + param2;
         }
         eventDispatcher.dispatchEvent(new BloonEvent(BloonEvent.POP,this,param2,param3));
      }
      
      public function getFullCashValue() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = this.type;
         while(_loc2_ != -1)
         {
            if(false == this.cashAwarded[_loc2_])
            {
               _loc1_++;
            }
            if(childCountByType[_loc2_] != 1)
            {
               if(false == this.cashAwarded[_loc2_])
               {
                  _loc1_ = _loc1_ + popsByType[childTypeByType[_loc2_]];
               }
            }
            _loc2_ = childTypeByType[_loc2_];
         }
         _loc1_ = Main.instance.game.cashPerPop * this.cashPerPopScale * _loc1_;
         return _loc1_;
      }
      
      public function getPopValue() : int
      {
         return popsByType[this.type];
      }
      
      override public function destroy() : void
      {
         this.type = -1;
         this.level.removeBloon(this);
         this.level = null;
      }
      
      protected function splitToChildren(param1:Bloon) : int
      {
         var _loc9_:int = 0;
         var _loc10_:Bloon = null;
         var _loc11_:int = 0;
         this._popCountToAddFromSplit = 0;
         var _loc2_:int = this.type;
         var _loc3_:uint = childCountByType[_loc2_];
         _loc3_--;
         if(_loc3_ <= 0)
         {
            return 0;
         }
         var _loc4_:int = _loc2_;
         var _loc5_:int = INVALID;
         var _loc6_:Boolean = false;
         if(_loc2_ == ZEBRA)
         {
            _loc5_ = WHITE;
         }
         else if(_loc2_ == DDT)
         {
            _loc5_ = Bloon.CERAMIC;
            _loc6_ = true;
         }
         else
         {
            _loc5_ = childTypeByType[_loc2_];
         }
         var _loc7_:int = Main.instance.game.waveIndex + 1;
         if(_loc7_ >= WAVE_OF_DIFFICULTY_INCREASE || postBossDestroyed)
         {
            if(param1.type < MOAB)
            {
               _loc9_ = 0;
               this._popCountToAddFromSplit = popsByType[childTypeByType[param1.type]]; //cash awarded in freeplay?
               if(false == param1.cashAwarded[param1.type])
               {
                  _loc9_ = this._popCountToAddFromSplit;
               }
               return _loc9_;
            }
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_)
         {
            _loc10_ = Pool.get(Bloon);
            _loc10_.initialise(this.level,_loc5_,this.tile,this.tileProgress,this.isRegen,this.isCamo,this.timeStamp);
            _loc10_.isChild = true;
            this.inheritStats(this,_loc10_);
            if(_loc2_ == ZEBRA)
            {
               _loc10_.wasWhite = true;
            }
            if(_loc6_)
            {
               _loc10_.isCamo = Level.camoDisabled != true;
               _loc10_.clip.camoVisible = Level.camoDisabled != true;
               _loc10_.isRegen = true;
               _loc10_.regenCeiling = Bloon.CERAMIC;
               _loc10_.clip.regenVisible = true;
               _loc10_.clip.setFrame(_loc5_,_loc10_.health);
               _loc10_.calculateImmunity();
            }
            if(_loc2_ == BLACK || _loc2_ == WHITE)
            {
               _loc10_.cashAwarded[BLACK] = true;
               _loc10_.cashAwarded[WHITE] = true;
            }
            else if(_loc2_ == LEAD)
            {
               _loc10_.cashAwarded[ZEBRA] = true;
               _loc10_.cashAwarded[WHITE] = true;
            }
            if(this.cashAwarded[_loc2_])
            {
               _loc11_ = 0;
               while(_loc11_ < BLOON_COUNT)
               {
                  _loc10_.cashAwarded[_loc11_] = true;
                  _loc10_.cashPerPopScale = 0;
                  _loc11_++;
               }
            }
            this.level.addBloon(_loc10_);
            param1.childrenRangeThisFrame.push(_loc10_);
            _loc8_++;
         }
         return 0;
      }
      
      protected function inheritStats(param1:Bloon, param2:Bloon) : void //inherits camo, glue, ice, etc
      {
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         param2.parentIDs.push(param1.id);
         for each(_loc3_ in param1.parentIDs)
         {
            param2.parentIDs.push(_loc3_);
         }
         param2.iced = param1.iced;
         if(param2.type == WHITE)
         {
            _loc4_ = false;
            if(param1.icedBy != null)
            {
               _loc4_ = param1.icedBy.bypassWhiteThawout;
            }
            param2.iced = _loc4_;
         }
         param2.iceCountdown = param1.iceCountdown;
         param2.permaFrostSpeedScale = param1.permaFrostSpeedScale;
         param2.viralIce = param1.viralIce;
         param2.iceShards = param1.iceShards;
         param2.icedBy = param1.icedBy;
         param2.freezeLayers = param1.freezeLayers;
         param2.arcticWind = param1.arcticWind;
         param2.arcticWindCountdown = param1.arcticWindCountdown;
         param2.glued = param1.glued;
         param2.glueCountdown = param1.glueCountdown;
         param2.glueCorrosionInterval = param1.glueCorrosionInterval;
         param2.glueCorrosionCountDown = param1.glueCorrosionCountDown;
         param2.glueSpeedScale = param1.glueSpeedScale;
         param2.glueSoak = param1.glueSoak;
         param2.glueCash = param1.glueCash;
         param2.overallProgress = param1.overallProgress;
         param2.isCamo = param1.isCamo;
         param2.isRegen = param1.isRegen;
         if(this.stunInherited)
         {
            param2.stunned = param1.stunned;
            param2.stunInherited = param1.stunInherited;
            param2.stunCountDown = param1.stunCountDown;
         }
         else
         {
            param2.stunned = false;
            param2.stunCountDown = 0;
         }
         param2.stunInherited = false;
         param2.burning = param1.burning;
         param2.burnCountDown = param1.burnCountDown;
         param2.burnInterval = param1.burnInterval;
         param2.burnLifeSpan = param1.burnLifeSpan;
         param2.burnCash = param1.burnCash;
         param2.clip.bloonVisible = param1.clip.bloonVisible;
         param2.clip.camoVisible = param1.clip.camoVisible;
         param2.clip.glueState = param1.clip.glueState;
         param2.clip.iceVisible = param1.clip.iceVisible;
         if(param2.type == WHITE)
         {
            param2.clip.iceVisible = false;
         }
         param2.clip.regenVisible = param1.clip.regenVisible;
         param2.clip.burnyStuffVisible = param1.clip.burnyStuffVisible;
         param2.clip.stunVisible = param1.clip.stunVisible;
         param2.regenCeiling = param1.regenCeiling;
         param2.regenInterval = param1.regenInterval;
         param2.regenCountDown = param1.regenCountDown;
         param2.wasWhite = param1.wasWhite;
         param2.rotation = param1.rotation;
         param2.clip.setFrame(param2.type,param2.health);
         param2.calculateImmunity();
         if(param1.isBoss)
         {
            param2.sabotaged = this.level.sabotageBloons;
         }
         else
         {
            param2.sabotaged = param1.sabotaged;
         }
      }
      
      public function regenerate() : void
      {
         if(this.type < this.regenCeiling)
         {
            if(this.type == PINK && this.wasWhite)
            {
               this.type++;
            }
            else if(this.type == BLACK)
            {
               if(this.regenCeiling == LEAD)
               {
                  this.type = this.type + 2;
               }
               else
               {
                  this.type = this.type + 1;
               }
            }
            else if(this.type == ZEBRA)
            {
               this.type = this.type + 1;
            }
            this.setType(++this.type);
            if(this.type == this.regenCeiling)
            {
               this.regenCountDown = this.regenInterval;
            }
         }
      }
      
      public function applyStun(param1:StunEffectDef, param2:Boolean = false) : void
      {
         if(param1.cantEffect.indexOf(this.type) == -1 && false == this.isBoss)
         {
            this.stunned = true;
            this.clip.stunVisible = true;
            this.stunInherited = param1.inherit;
            this.stunCountDown = param1.lifespan;
            if(false == param2)
            {
               if(this.type == BOSS || this.type == DDT)
               {
                  this.stunCountDown = Math.min(this.stunCountDown,0.5);
               }
               else if(this.type == BFB)
               {
                  this.stunCountDown = Math.min(this.stunCountDown,2);
               }
            }
            this.calculateImmunity();
         }
      }
      
      public function get isInTunnel() : Boolean
      {
         if(this.tile == null)
         {
            return false;
         }
         if(this.isHuge)
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
         if(!this.isInsideMap)
         {
            return true;
         }
         return false;
      }
      
      protected function get isInsideMap() : Boolean
      {
         if(this.x < Main.mapArea.left || this.x > Main.mapArea.right || this.y < Main.mapArea.top || this.y > Main.mapArea.bottom)
         {
            return false;
         }
         return true;
      }
      
      public function get timeStamp() : Number
      {
         return this._timeStamp;
      }
      
      public function get tile() : Tile
      {
         return this._tile;
      }
      
      public function set tile(param1:Tile) : void
      {
         var _loc2_:int = this._tile != null?int(this._tile.layer):0;
         this._tile = param1;
         if(this.isHuge)
         {
            return;
         }
         if(this._tile != null && _loc2_ != this.tile.layer)
         {
            z = this._tile.layer + this.zOffset;
            this.level.sortDrawList = true;
         }
      }
      
      public function getDistanceToEnd() : Number
      {
         return this.tile.getDistanceToEnd() - this.tileProgress;
      }
      
      public function getDistanceToStart() : Number
      {
         return this.tile.getDistanceToStart() - this.tile.tileLength + this.tileProgress;
      }
      
      protected function shardsPop() : void
      {
         var _loc1_:ProjectileDef = new ProjectileDef().Display(IceShard).Pierce(1).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.BOSS_DREADBLOON])).CanBreakIce(true));
         var _loc2_:Spread = new Spread().Range(70).Power(350).ReloadTime(1.66).Projectile(_loc1_).Angle(Math.PI * 2 * 2 / 3).Count(5).Rotate(false).RandRotate(true);
         _loc2_.execute(this.icedBy,this,null);
      }
   }
}
