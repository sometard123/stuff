package ninjakiwi.monkeyTown.btdModule.towers.def
{
   import assets.base.Tower;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.data.Unique;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.Sacrifice;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class TowerDef extends Unique
   {
      
      public static const CHANGE_TERRAIN_NO:uint = 0;
      
      public static const CHANGE_TERRAIN_TO_WATER:uint = 1;
      
      public static const CHANGE_TERRAIN_TO_LAND:uint = 2;
      
      public static const TARGETS_BLOONS:uint = 0;
      
      public static const TARGETS_MOUSE:uint = 1;
      
      public static const TARGETS_RETICLE:uint = 2;
      
      public static var occupiedSpace_baseof:Class = MovieClip;
      
      public static var display_baseof:Class = Tower;
      
      public static var detail_baseof:Class = MovieClip;
      
      public static var detailSmall_baseof:Class = MovieClip;
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var label_:String = null;
      
      private var occupiedSpace_:Class = null;
      
      private var rangeOfVisibility_:Number = 0;
      
      private var weapons_:Vector.<Weapon> = null;
      
      private var weaponOffsets_:Vector.<Vector2> = null;
      
      private var abilities_:Vector.<AbilityDef> = null;
      
      private var areaEffects_:Vector.<AreaEffectDef> = null;
      
      private var targetMask_:Vector.<int>;
      
      private var description_:String = null;
      
      private var display_:Class = null;
      
      private var detail_:Class = null;
      
      private var detailSmall_:Class = null;
      
      private var displayAddons_:Vector.<DisplayAddonDef> = null;
      
      private var behavior_:BehaviorDef = null;
      
      private var isBoat_:Boolean = false;
      
      private var isLand_:Boolean = true;
      
      private var canPriorityTarget_:Boolean = true;
      
      private var canPlaceOnTrack_:Boolean = false;
      
      private var sacrificeType_:int;
      
      private var targetAll_:Boolean = false;
      
      private var changesTerrain_:uint = 0;
      
      private var isPlatform_:Boolean = false;
      
      private var platformEffects_:Vector.<AreaEffectDef> = null;
      
      private var _targetingSystem:uint = 0;
      
      private var _requiresTarget:Boolean = true;
      
      private var _buffs:Vector.<Buff>;
      
      public function TowerDef(param1:* = null)
      {
         this.targetMask_ = Vector.<int>([Bloon.IMMUNITY_NO_DETECTION]);
         this.sacrificeType_ = Sacrifice.SACRIFICE_TYPE_SHARP;
         this._buffs = new Vector.<Buff>();
         super(param1);
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("id","label","occupiedSpace","rangeOfVisibility","weapons","weaponOffsets","abilities","areaEffects","targetMask","description","display","displayAddons","behavior","isBoat","canPlaceOnTrack","sacrificeType");
         }
         return displayOrder;
      }
      
      public function set label(param1:String) : void
      {
         if(this.label_ != param1)
         {
            this.label_ = param1;
            dispatchEvent(new PropertyModEvent("label"));
         }
      }
      
      public function get label() : String
      {
         return this.label_;
      }
      
      public function Label(param1:String) : TowerDef
      {
         this.label = param1;
         return this;
      }
      
      public function set occupiedSpace(param1:Class) : void
      {
         if(this.occupiedSpace_ != param1)
         {
            this.occupiedSpace_ = param1;
            dispatchEvent(new PropertyModEvent("occupiedSpace"));
         }
      }
      
      public function get occupiedSpace() : Class
      {
         return this.occupiedSpace_;
      }
      
      public function OccupiedSpace(param1:Class) : TowerDef
      {
         this.occupiedSpace = param1;
         return this;
      }
      
      public function set rangeOfVisibility(param1:Number) : void
      {
         if(this.rangeOfVisibility_ != param1)
         {
            this.rangeOfVisibility_ = param1;
            dispatchEvent(new PropertyModEvent("rangeOfVisibility"));
         }
      }
      
      public function get rangeOfVisibility() : Number
      {
         return this.rangeOfVisibility_;
      }
      
      public function RangeOfVisibility(param1:Number) : TowerDef
      {
         this.rangeOfVisibility = param1;
         return this;
      }
      
      public function set weapons(param1:Vector.<Weapon>) : void
      {
         if(this.weapons_ != param1)
         {
            this.weapons_ = param1;
            dispatchEvent(new PropertyModEvent("weapons"));
         }
      }
      
      public function get weapons() : Vector.<Weapon>
      {
         return this.weapons_;
      }
      
      public function Weapons(param1:Vector.<Weapon>) : TowerDef
      {
         this.weapons = param1;
         return this;
      }
      
      public function set weaponOffsets(param1:Vector.<Vector2>) : void
      {
         if(this.weaponOffsets_ != param1)
         {
            this.weaponOffsets_ = param1;
            dispatchEvent(new PropertyModEvent("weaponOffsets"));
         }
      }
      
      public function get weaponOffsets() : Vector.<Vector2>
      {
         return this.weaponOffsets_;
      }
      
      public function WeaponOffsets(param1:Vector.<Vector2>) : TowerDef
      {
         this.weaponOffsets = param1;
         return this;
      }
      
      public function set abilities(param1:Vector.<AbilityDef>) : void
      {
         if(this.abilities_ != param1)
         {
            this.abilities_ = param1;
            dispatchEvent(new PropertyModEvent("abilities"));
         }
      }
      
      public function get abilities() : Vector.<AbilityDef>
      {
         return this.abilities_;
      }
      
      public function Abilities(param1:Vector.<AbilityDef>) : TowerDef
      {
         this.abilities = param1;
         return this;
      }
      
      public function set areaEffects(param1:Vector.<AreaEffectDef>) : void
      {
         if(this.areaEffects_ != param1)
         {
            this.areaEffects_ = param1;
            dispatchEvent(new PropertyModEvent("areaEffects"));
         }
      }
      
      public function get areaEffects() : Vector.<AreaEffectDef>
      {
         return this.areaEffects_;
      }
      
      public function AreaEffects(param1:Vector.<AreaEffectDef>) : TowerDef
      {
         this.areaEffects = param1;
         return this;
      }
      
      public function set targetMask(param1:Vector.<int>) : void
      {
         if(this.targetMask_ != param1)
         {
            this.targetMask_ = param1;
            dispatchEvent(new PropertyModEvent("targetMask"));
         }
      }
      
      public function get targetMask() : Vector.<int>
      {
         return this.targetMask_;
      }
      
      public function TargetMask(param1:Vector.<int>) : TowerDef
      {
         this.targetMask = param1;
         return this;
      }
      
      public function set description(param1:String) : void
      {
         if(this.description_ != param1)
         {
            this.description_ = param1;
            dispatchEvent(new PropertyModEvent("description"));
         }
      }
      
      public function get description() : String
      {
         return this.description_;
      }
      
      public function Description(param1:String) : TowerDef
      {
         this.description = param1;
         return this;
      }
      
      public function set display(param1:Class) : void
      {
         if(this.display_ != param1)
         {
            this.display_ = param1;
            dispatchEvent(new PropertyModEvent("display"));
         }
      }
      
      public function get display() : Class
      {
         return this.display_;
      }
      
      public function Display(param1:Class) : TowerDef
      {
         this.display = param1;
         return this;
      }
      
      public function set detail(param1:Class) : void
      {
         if(this.detail_ != param1)
         {
            this.detail_ = param1;
            dispatchEvent(new PropertyModEvent("detail"));
         }
      }
      
      public function get detail() : Class
      {
         return this.detail_;
      }
      
      public function Detail(param1:Class) : TowerDef
      {
         this.detail = param1;
         return this;
      }
      
      public function set detailSmall(param1:Class) : void
      {
         if(this.detailSmall_ != param1)
         {
            this.detailSmall_ = param1;
            dispatchEvent(new PropertyModEvent("detailmall"));
         }
      }
      
      public function get detailSmall() : Class
      {
         return this.detailSmall_;
      }
      
      public function DetailSmall(param1:Class) : TowerDef
      {
         this.detailSmall_ = param1;
         return this;
      }
      
      public function set displayAddons(param1:Vector.<DisplayAddonDef>) : void
      {
         if(this.displayAddons_ != param1)
         {
            this.displayAddons_ = param1;
            dispatchEvent(new PropertyModEvent("displayAddons"));
         }
      }
      
      public function get displayAddons() : Vector.<DisplayAddonDef>
      {
         return this.displayAddons_;
      }
      
      public function DisplayAddons(param1:Vector.<DisplayAddonDef>) : TowerDef
      {
         this.displayAddons = param1;
         return this;
      }
      
      public function set behavior(param1:BehaviorDef) : void
      {
         if(this.behavior_ != param1)
         {
            this.behavior_ = param1;
            dispatchEvent(new PropertyModEvent("behavior"));
         }
      }
      
      public function get behavior() : BehaviorDef
      {
         return this.behavior_;
      }
      
      public function Behavior(param1:BehaviorDef) : TowerDef
      {
         this.behavior = param1;
         return this;
      }
      
      public function set isBoat(param1:Boolean) : void
      {
         if(this.isBoat_ != param1)
         {
            this.isBoat_ = param1;
            dispatchEvent(new PropertyModEvent("isBoat"));
         }
      }
      
      public function get isBoat() : Boolean
      {
         return this.isBoat_;
      }
      
      public function IsBoat(param1:Boolean) : TowerDef
      {
         this.isBoat = param1;
         return this;
      }
      
      public function set isLand(param1:Boolean) : void
      {
         if(this.isLand_ != param1)
         {
            this.isLand_ = param1;
            dispatchEvent(new PropertyModEvent("isLand"));
         }
      }
      
      public function get isLand() : Boolean
      {
         return this.isLand_;
      }
      
      public function IsLand(param1:Boolean) : TowerDef
      {
         this.isLand = param1;
         return this;
      }
      
      public function set targetAll(param1:Boolean) : void
      {
         if(this.targetAll_ != param1)
         {
            this.targetAll_ = param1;
            dispatchEvent(new PropertyModEvent("targetAll"));
         }
      }
      
      public function get targetAll() : Boolean
      {
         return this.targetAll_;
      }
      
      public function TargetAll(param1:Boolean) : TowerDef
      {
         this.targetAll = param1;
         return this;
      }
      
      public function set canPriorityTarget(param1:Boolean) : void
      {
         if(this.canPriorityTarget_ != param1)
         {
            this.canPriorityTarget_ = param1;
            dispatchEvent(new PropertyModEvent("canPriorityTarget"));
         }
      }
      
      public function get canPriorityTarget() : Boolean
      {
         return this.canPriorityTarget_;
      }
      
      public function CanPriorityTarget(param1:Boolean) : TowerDef
      {
         this.canPriorityTarget = param1;
         return this;
      }
      
      public function set canPlaceOnTrack(param1:Boolean) : void
      {
         if(this.canPlaceOnTrack_ != param1)
         {
            this.canPlaceOnTrack_ = param1;
            dispatchEvent(new PropertyModEvent("canPlaceOnTrack"));
         }
      }
      
      public function get canPlaceOnTrack() : Boolean
      {
         return this.canPlaceOnTrack_;
      }
      
      public function CanPlaceOnTrack(param1:Boolean) : TowerDef
      {
         this.canPlaceOnTrack = param1;
         return this;
      }
      
      public function set sacrificeType(param1:int) : void
      {
         if(this.sacrificeType_ != param1)
         {
            this.sacrificeType_ = param1;
            dispatchEvent(new PropertyModEvent("sacrificeType"));
         }
      }
      
      public function get sacrificeType() : int
      {
         return this.sacrificeType_;
      }
      
      public function SacrificeType(param1:int) : TowerDef
      {
         this.sacrificeType = param1;
         return this;
      }
      
      public function get changesTerrain() : uint
      {
         return this.changesTerrain_;
      }
      
      public function set changesTerrain(param1:uint) : void
      {
         if(this.changesTerrain_ != param1)
         {
            this.changesTerrain_ = param1;
            dispatchEvent(new PropertyModEvent("changesTerrain"));
         }
      }
      
      public function ChangesTerrain(param1:uint) : TowerDef
      {
         this.changesTerrain = param1;
         return this;
      }
      
      public function get isPlatform() : Boolean
      {
         return this.isPlatform_;
      }
      
      public function set isPlatform(param1:Boolean) : void
      {
         if(this.isPlatform_ != param1)
         {
            this.isPlatform_ = param1;
            dispatchEvent(new PropertyModEvent("isPlatform"));
         }
      }
      
      public function IsPlatform(param1:Boolean) : TowerDef
      {
         this.isPlatform = param1;
         return this;
      }
      
      public function set platformEffects(param1:Vector.<AreaEffectDef>) : void
      {
         if(this.platformEffects_ != param1)
         {
            this.platformEffects_ = param1;
            dispatchEvent(new PropertyModEvent("platformEffects"));
         }
      }
      
      public function get platformEffects() : Vector.<AreaEffectDef>
      {
         return this.platformEffects_;
      }
      
      public function PlatformEffects(param1:Vector.<AreaEffectDef>) : TowerDef
      {
         this.platformEffects = param1;
         return this;
      }
      
      public function get targetingSystem() : uint
      {
         return this._targetingSystem;
      }
      
      public function set targetingSystem(param1:uint) : void
      {
         this._targetingSystem = param1;
      }
      
      public function TargetingSystem(param1:uint) : TowerDef
      {
         this._targetingSystem = param1;
         return this;
      }
      
      public function get requiresTarget() : Boolean
      {
         return this._requiresTarget;
      }
      
      public function set requiresTarget(param1:Boolean) : void
      {
         this._requiresTarget = param1;
      }
      
      public function RequiresTarget(param1:Boolean) : TowerDef
      {
         this._requiresTarget = param1;
         return this;
      }
      
      public function get buffs() : Vector.<Buff>
      {
         return this._buffs;
      }
      
      public function set buffs(param1:Vector.<Buff>) : void
      {
         this._buffs = param1;
      }
   }
}
