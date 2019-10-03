package ninjakiwi.monkeyTown.btdModule.towers.upgrades
{
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.DisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDisplayMod;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class AddDef extends EventDispatcher
   {
      
      public static var detail_baseof:Class = MovieClip;
      
      public static var detailSmall_baseof:Class = MovieClip;
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var rangeOfVisibility_:Number = 0;
      
      private var rangeOfVisibilityAsScale_:Boolean = false;
      
      private var weaponMod_:WeaponModDef = null;
      
      private var abilities_:Vector.<AbilityDef> = null;
      
      private var abilityMod_:AbilityModDef = null;
      
      private var display_:Vector.<TowerDisplayMod> = null;
      
      private var displayAddonMods_:Vector.<TowerDisplayMod> = null;
      
      private var displayAddons_:Vector.<DisplayAddonDef> = null;
      
      private var areaEffects_:Vector.<AreaEffectDef> = null;
      
      private var removeFromTargetMask_:Vector.<int> = null;
      
      private var behavior_:BehaviorModDef = null;
      
      private var weapons_:Vector.<Weapon> = null;
      
      private var replaceWeapons_:Vector.<WeaponReplaceDef> = null;
      
      private var detail_:Class = null;
      
      private var detailSmall_:Class = null;
      
      public function AddDef()
      {
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("rangeOfVisibility","rangeOfVisibilityAsScale","weaponMod","abilityMod","display","displayAddons","areaEffects","removeFromTargetMask","behavior","weapons");
         }
         return displayOrder;
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
      
      public function RangeOfVisibility(param1:Number) : AddDef
      {
         this.rangeOfVisibility = param1;
         return this;
      }
      
      public function set rangeOfVisibilityAsScale(param1:Boolean) : void
      {
         if(this.rangeOfVisibilityAsScale_ != param1)
         {
            this.rangeOfVisibilityAsScale_ = param1;
            dispatchEvent(new PropertyModEvent("rangeOfVisibilityAsScale"));
         }
      }
      
      public function get rangeOfVisibilityAsScale() : Boolean
      {
         return this.rangeOfVisibilityAsScale_;
      }
      
      public function RangeOfVisibilityAsScale(param1:Boolean) : AddDef
      {
         this.rangeOfVisibilityAsScale = param1;
         return this;
      }
      
      public function set weaponMod(param1:WeaponModDef) : void
      {
         if(this.weaponMod_ != param1)
         {
            this.weaponMod_ = param1;
            dispatchEvent(new PropertyModEvent("weaponMod"));
         }
      }
      
      public function get weaponMod() : WeaponModDef
      {
         return this.weaponMod_;
      }
      
      public function WeaponMod(param1:WeaponModDef) : AddDef
      {
         this.weaponMod = param1;
         return this;
      }
      
      public function set abilityMod(param1:AbilityModDef) : void
      {
         if(this.abilityMod_ != param1)
         {
            this.abilityMod_ = param1;
            dispatchEvent(new PropertyModEvent("abilityMod"));
         }
      }
      
      public function get abilityMod() : AbilityModDef
      {
         return this.abilityMod_;
      }
      
      public function AbilityMod(param1:AbilityModDef) : AddDef
      {
         this.abilityMod = param1;
         return this;
      }
      
      public function set display(param1:Vector.<TowerDisplayMod>) : void
      {
         if(this.display_ != param1)
         {
            this.display_ = param1;
            dispatchEvent(new PropertyModEvent("display"));
         }
      }
      
      public function get display() : Vector.<TowerDisplayMod>
      {
         return this.display_;
      }
      
      public function Display(param1:Vector.<TowerDisplayMod>) : AddDef
      {
         this.display = param1;
         return this;
      }
      
      public function set displayAddonMods(param1:Vector.<TowerDisplayMod>) : void
      {
         if(this.displayAddonMods_ != param1)
         {
            this.displayAddonMods_ = param1;
            dispatchEvent(new PropertyModEvent("displayAddonMods"));
         }
      }
      
      public function get displayAddonMods() : Vector.<TowerDisplayMod>
      {
         return this.displayAddonMods_;
      }
      
      public function DisplayAddonMods(param1:Vector.<TowerDisplayMod>) : AddDef
      {
         this.displayAddonMods = param1;
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
      
      public function DisplayAddons(param1:Vector.<DisplayAddonDef>) : AddDef
      {
         this.displayAddons = param1;
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
      
      public function AreaEffects(param1:Vector.<AreaEffectDef>) : AddDef
      {
         this.areaEffects = param1;
         return this;
      }
      
      public function set removeFromTargetMask(param1:Vector.<int>) : void
      {
         if(this.removeFromTargetMask_ != param1)
         {
            this.removeFromTargetMask_ = param1;
            dispatchEvent(new PropertyModEvent("removeFromTargetMask"));
         }
      }
      
      public function get removeFromTargetMask() : Vector.<int>
      {
         return this.removeFromTargetMask_;
      }
      
      public function RemoveFromTargetMask(param1:Vector.<int>) : AddDef
      {
         this.removeFromTargetMask = param1;
         return this;
      }
      
      public function set behavior(param1:BehaviorModDef) : void
      {
         if(this.behavior_ != param1)
         {
            this.behavior_ = param1;
            dispatchEvent(new PropertyModEvent("behavior"));
         }
      }
      
      public function get behavior() : BehaviorModDef
      {
         return this.behavior_;
      }
      
      public function Behavior(param1:BehaviorModDef) : AddDef
      {
         this.behavior = param1;
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
      
      public function Weapons(param1:Vector.<Weapon>) : AddDef
      {
         this.weapons = param1;
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
      
      public function Detail(param1:Class) : AddDef
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
      
      public function DetailSmall(param1:Class) : AddDef
      {
         this.detailSmall_ = param1;
         return this;
      }
      
      public function get replaceWeapons() : Vector.<WeaponReplaceDef>
      {
         return this.replaceWeapons_;
      }
      
      public function set replaceWeapons(param1:Vector.<WeaponReplaceDef>) : void
      {
         this.replaceWeapons_ = param1;
      }
      
      public function ReplaceWeapons(param1:Vector.<WeaponReplaceDef>) : AddDef
      {
         this.replaceWeapons_ = param1;
         return this;
      }
      
      public function get abilities() : Vector.<AbilityDef>
      {
         return this.abilities_;
      }
      
      public function set abilities(param1:Vector.<AbilityDef>) : void
      {
         this.abilities_ = param1;
      }
      
      public function Abilities(param1:Vector.<AbilityDef>) : AddDef
      {
         this.abilities_ = param1;
         return this;
      }
   }
}
