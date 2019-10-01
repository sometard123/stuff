package ninjakiwi.monkeyTown.town.ui.pvp.attack
{
   import assets.town.PvPAdvancedAttackClipNewVersion;
   import com.codecatalyst.promise.Promise;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.data.definitions.BloonResearchLabUpgrade;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.BloonBeaconIcon;
   import ninjakiwi.monkeyTown.town.ui.slider.Slider;
   import ninjakiwi.monkeyTown.town.ui.slider.TickSlider;
   import ninjakiwi.monkeyTown.ui.ToolTip;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class PvPAttackBloonTypeSlider extends PvPAttackBaseSlider
   {
       
      
      private const BLOON_TYPE_RANGE:int = 3;
      
      private const BLOON_TYPE_MAX_LEVEL:int = 30;
      
      private const BLOON_TYPE_MIN_LEVEL:int = 8;
      
      private const MIN_BLOON_TYPE_INDEX:int = 2;
      
      private const disabledColorTransform:ColorTransform = new ColorTransform(0.3,0.3,0.3,1,118,118,118);
      
      private const enabledColorTransform:ColorTransform = new ColorTransform();
      
      private const _tooltip:ToolTip = new ToolTip();
      
      private const _tooltipNameList:Vector.<String> = new Vector.<String>();
      
      private const _hintNameList:Vector.<String> = new Vector.<String>();
      
      private var _bloonTypeSlider:TickSlider;
      
      private const _defaultBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _fastBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _thermalBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _leadBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _multiBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _ceramicBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _moabBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _bfbBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _zombBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private const _ddtBloonType:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private var _allBloonTypes:Vector.<MovieClip>;
      
      public function PvPAttackBloonTypeSlider(param1:PvPAdvancedAttackClipNewVersion)
      {
         var _loc3_:MovieClip = null;
         var _loc5_:BloonResearchLabUpgrade = null;
         var _loc6_:String = null;
         this._allBloonTypes = new Vector.<MovieClip>();
         super(param1,Slider.HORIZONTAL);
         _clip.bloonTypeSliderGuide.visible = false;
         this._defaultBloonType.push(_clip.bloonRed);
         this._defaultBloonType.push(_clip.bloonBlue);
         this._defaultBloonType.push(_clip.bloonGreen);
         this._fastBloonType.push(_clip.bloonYellow);
         this._fastBloonType.push(_clip.bloonPink);
         this._thermalBloonType.push(_clip.bloonBlack);
         this._thermalBloonType.push(_clip.bloonWater);
         this._thermalBloonType.push(_clip.bloonZebra);
         this._leadBloonType.push(_clip.bloonLead);
         this._multiBloonType.push(_clip.bloonRainbow);
         this._ceramicBloonType.push(_clip.bloonCeramic);
         this._moabBloonType.push(_clip.bloonMoab);
         this._bfbBloonType.push(_clip.bloonBfb);
         this._zombBloonType.push(_clip.bloonZomb);
         this._ddtBloonType.push(_clip.bloonDdt);
         this._allBloonTypes = this.getAllBloonTypes();
         var _loc2_:Vector.<Number> = new Vector.<Number>();
         for each(_loc3_ in this._allBloonTypes)
         {
            _loc2_.push(_loc3_.x);
         }
         if(Constants.SELECTABLE_BLOON_TYPE)
         {
            _clip.bloonTypeIndicator.visible = false;
            _clip.bloonTypeBG.gotoAndStop(2);
            this._bloonTypeSlider = new TickSlider(_clip.bloonTypeSliderGuide,_clip.bloonTypeSlideBar,_loc2_,MonkeySystem.getInstance().flashStage);
            this._bloonTypeSlider.indexChanged.add(this.indexChanged);
         }
         else
         {
            _clip.bloonTypeMin.visible = false;
            _clip.bloonTypeMax.visible = false;
            _clip.bloonTypeSlideBar.visible = false;
            _clip.bloonTypeBG.gotoAndStop(1);
            this._bloonTypeSlider = new TickSlider(_clip.bloonTypeSliderGuide,_clip.bloonTypeIndicator,_loc2_,MonkeySystem.getInstance().flashStage);
            this._bloonTypeSlider.indexChanged.add(this.indexChanged);
            this._bloonTypeSlider.lock();
            this._bloonTypeSlider.removeHandleButton();
         }
         _clip.bloonTypeSlideBar.gotoAndStop(1);
         var _loc4_:int = 0;
         while(_loc4_ < this._allBloonTypes.length)
         {
            _loc5_ = this.findResearchLabUpgrade(_loc4_);
            _loc6_ = "";
            if(_loc5_ != null)
            {
               _loc6_ = LocalisationConstants.STRING_BLOON_RESEARCH_TOOLTIP.split("<research name>").join(_loc5_.name);
            }
            this._tooltipNameList.push(_loc6_);
            this._hintNameList.push(_loc6_);
            _loc4_++;
         }
         this._tooltip.stage = MonkeySystem.getInstance().flashStage;
         this._tooltip.width = 300;
         this._tooltip.activateMouseFollow();
         _clip.addChild(this._tooltip);
      }
      
      private function indexChanged(param1:int) : void
      {
         needSync();
      }
      
      public function enableTooltips() : void
      {
         var _loc1_:int = this._allBloonTypes.indexOf(this.findStrongestBloonType());
         var _loc2_:int = 0;
         while(_loc2_ < this._allBloonTypes.length)
         {
            if(_loc2_ > _loc1_)
            {
               this._allBloonTypes[_loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.onBloonMouseOver);
               this._allBloonTypes[_loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.onBloonMouseOut);
            }
            _loc2_++;
         }
      }
      
      public function disableTooltips() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._allBloonTypes)
         {
            if(_loc1_.hasEventListener(MouseEvent.MOUSE_OVER))
            {
               _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onBloonMouseOver);
            }
            if(_loc1_.hasEventListener(MouseEvent.MOUSE_OUT))
            {
               _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onBloonMouseOut);
            }
         }
      }
      
      private function onBloonMouseOver(param1:MouseEvent) : void
      {
         this._tooltip.message = this._tooltipNameList[this._allBloonTypes.indexOf(param1.target)];
         this._tooltip.reveal();
      }
      
      private function onBloonMouseOut(param1:MouseEvent) : void
      {
         this._tooltip.hide();
      }
      
      override public function refresh() : void
      {
         super.refresh();
         this.setEnableBloonTypes();
      }
      
      private function findStrongestBloonType() : MovieClip
      {
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.DDTS.id))
         {
            return this._ddtBloonType[this._ddtBloonType.length - 1];
         }
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.ZOMGS.id))
         {
            return this._zombBloonType[this._zombBloonType.length - 1];
         }
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.BFBS.id))
         {
            return this._bfbBloonType[this._bfbBloonType.length - 1];
         }
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.MOABS.id))
         {
            return this._moabBloonType[this._moabBloonType.length - 1];
         }
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.CERAMIC_BLOON_CONSTRUCTION.id))
         {
            return this._ceramicBloonType[this._ceramicBloonType.length - 1];
         }
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.MULTILAYER_TECH.id))
         {
            return this._multiBloonType[this._multiBloonType.length - 1];
         }
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.HEAVY_BLOON_ARMOUR.id))
         {
            return this._leadBloonType[this._leadBloonType.length - 1];
         }
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.THERMAL_BLOONS.id))
         {
            return this._thermalBloonType[this._thermalBloonType.length - 1];
         }
         if(BloonResearchLabState.hasUpgrade(BloonResearchLabUpgrades.FAST_BLOONS.id))
         {
            return this._fastBloonType[this._fastBloonType.length - 1];
         }
         return this._defaultBloonType[this._defaultBloonType.length - 1];
      }
      
      private function setEnableBloonTypes() : void
      {
         this.enableBloonType(BloonResearchLabUpgrades.FAST_BLOONS.id,this._fastBloonType);
         this.enableBloonType(BloonResearchLabUpgrades.THERMAL_BLOONS.id,this._thermalBloonType);
         this.enableBloonType(BloonResearchLabUpgrades.HEAVY_BLOON_ARMOUR.id,this._leadBloonType);
         this.enableBloonType(BloonResearchLabUpgrades.MULTILAYER_TECH.id,this._multiBloonType);
         this.enableBloonType(BloonResearchLabUpgrades.CERAMIC_BLOON_CONSTRUCTION.id,this._ceramicBloonType);
         this.enableBloonType(BloonResearchLabUpgrades.MOABS.id,this._moabBloonType);
         this.enableBloonType(BloonResearchLabUpgrades.BFBS.id,this._bfbBloonType);
         this.enableBloonType(BloonResearchLabUpgrades.ZOMGS.id,this._zombBloonType);
         this.enableBloonType(BloonResearchLabUpgrades.DDTS.id,this._ddtBloonType);
      }
      
      private function enableBloonType(param1:String, param2:Vector.<MovieClip>) : void
      {
         var _loc3_:MovieClip = null;
         if(BloonResearchLabState.hasUpgrade(param1))
         {
            for each(_loc3_ in param2)
            {
               _loc3_.transform.colorTransform = this.enabledColorTransform;
            }
         }
         else
         {
            for each(_loc3_ in param2)
            {
               _loc3_.transform.colorTransform = this.disabledColorTransform;
            }
         }
      }
      
      public function syncBloonType(param1:int, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:int = this.getMaxBloonTypeIndex(param2);
         var _loc5_:int = this.getMinBloonTypeIndex(param2);
         var _loc6_:int = this._allBloonTypes.indexOf(this.findStrongestBloonType());
         var _loc7_:int = _loc6_;
         var _loc8_:int = _loc5_;
         var _loc9_:int = _loc4_;
         _clip.bloonTypeSlideBar.gotoAndStop(1);
         _clip.hintText.text = "";
         if(Constants.SELECTABLE_BLOON_TYPE)
         {
            if(_loc6_ < _loc8_)
            {
               _loc8_ = _loc6_;
            }
            if(_loc9_ > _loc6_)
            {
               _loc9_ = _loc6_;
            }
            _clip.bloonTypeMin.x = this._allBloonTypes[_loc5_].x;
            _clip.bloonTypeMax.x = this._allBloonTypes[_loc4_].x;
            this._bloonTypeSlider.setMinIndex(_loc8_);
            this._bloonTypeSlider.setMaxIndex(_loc9_);
            this._bloonTypeSlider.currentIndex = _loc6_;
         }
         else
         {
            this._bloonTypeSlider.setMinIndex(_loc5_);
            this._bloonTypeSlider.setMaxIndex(_loc4_);
            if(_loc6_ < _loc5_)
            {
               _loc7_ = _loc5_;
               _clip.bloonTypeSlideBar.gotoAndStop(2);
               _clip.hintText.text = this._hintNameList[_loc5_];
            }
            else if(_loc6_ > _loc4_)
            {
               _loc7_ = _loc4_;
            }
            this._bloonTypeSlider.currentIndex = _loc7_;
         }
      }
      
      private function getMinBloonTypeIndex(param1:Number) : int
      {
         var _loc2_:int = this.getMaxBloonTypeIndex(param1);
         var _loc3_:int = _loc2_ - (this.BLOON_TYPE_RANGE - 1);
         if(_loc3_ > Constants.MOAB_ID)
         {
            _loc3_ = Constants.MOAB_ID;
         }
         if(_loc3_ < this.MIN_BLOON_TYPE_INDEX)
         {
            _loc3_ = this.MIN_BLOON_TYPE_INDEX;
         }
         return _loc3_;
      }
      
      private function getMaxBloonTypeIndex(param1:Number) : int
      {
         var _loc2_:int = this._allBloonTypes.length - 1;
         var _loc3_:int = _loc2_;
         var _loc4_:int = _loc2_;
         while(_loc4_ >= 0)
         {
            if(BloonPredictor.meanestBloonThresholds[this.getBloonString(_loc4_).valueOf()] <= param1)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_--;
         }
         return _loc3_;
      }
      
      public function canAttackLevel(param1:Number) : Boolean
      {
         var _loc2_:int = this.getMinBloonTypeIndex(param1);
         var _loc3_:MovieClip = this.findStrongestBloonType();
         var _loc4_:int = this._allBloonTypes.indexOf(_loc3_);
         if(_loc4_ != -1 && _loc4_ >= _loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function getLeastResearchLabNameForAttackLevel(param1:Number) : String
      {
         var _loc2_:int = this.getMinBloonTypeIndex(param1);
         var _loc3_:BloonResearchLabUpgrade = this.findResearchLabUpgrade(_loc2_);
         if(_loc3_ == null)
         {
            return "";
         }
         return _loc3_.name;
      }
      
      private function findResearchLabUpgrade(param1:int) : BloonResearchLabUpgrade
      {
         var _loc2_:MovieClip = this._allBloonTypes[param1];
         if(this._fastBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.FAST_BLOONS;
         }
         if(this._thermalBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.THERMAL_BLOONS;
         }
         if(this._leadBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.HEAVY_BLOON_ARMOUR;
         }
         if(this._multiBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.MULTILAYER_TECH;
         }
         if(this._ceramicBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.CERAMIC_BLOON_CONSTRUCTION;
         }
         if(this._moabBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.MOABS;
         }
         if(this._bfbBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.BFBS;
         }
         if(this._zombBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.ZOMGS;
         }
         if(this._ddtBloonType.indexOf(_loc2_) != -1)
         {
            return BloonResearchLabUpgrades.DDTS;
         }
         return null;
      }
      
      private function getAllBloonTypes() : Vector.<MovieClip>
      {
         return this._defaultBloonType.concat(this._fastBloonType).concat(this._thermalBloonType).concat(this._leadBloonType).concat(this._multiBloonType).concat(this._ceramicBloonType).concat(this._moabBloonType).concat(this._bfbBloonType).concat(this._zombBloonType).concat(this._ddtBloonType);
      }
      
      public function isRedBloonAttack() : Boolean
      {
         if(this._bloonTypeSlider.currentIndex <= this._allBloonTypes.indexOf(_clip.bloonRed))
         {
            return true;
         }
         return false;
      }
      
      public function doesUseLead() : Boolean
      {
         return this.doesUseBloonType(_clip.bloonLead);
      }
      
      public function doesUseMoab() : Boolean
      {
         return this.doesUseBloonType(_clip.bloonMoab);
      }
      
      private function doesUseBloonType(param1:MovieClip) : Boolean
      {
         var _loc2_:int = this._allBloonTypes.indexOf(param1);
         if(_loc2_ == -1)
         {
            return false;
         }
         if(this._bloonTypeSlider.currentIndex >= _loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function isSelectedBloonTypeAvailable(param1:Number) : Boolean
      {
         var _loc2_:BloonResearchLabUpgrade = this.findResearchLabUpgrade(this.getMinBloonTypeIndex(param1));
         if(_loc2_ == null)
         {
            return true;
         }
         if(BloonResearchLabState.hasUpgrade(_loc2_.id))
         {
            return true;
         }
         return false;
      }
      
      public function getSelectedBloonResearchName(param1:Number) : String
      {
         var _loc2_:BloonResearchLabUpgrade = this.findResearchLabUpgrade(this.getAvailableCurrentIndex(param1));
         if(_loc2_ == null)
         {
            return "";
         }
         return _loc2_.name;
      }
      
      private function getAvailableCurrentIndex(param1:Number) : int
      {
         var _loc2_:int = this._bloonTypeSlider.currentIndex;
         var _loc3_:int = this.getMinBloonTypeIndex(param1);
         if(_loc3_ > _loc2_)
         {
            _loc2_ = _loc3_;
         }
         return _loc2_;
      }
      
      private function getBloonString(param1:int) : String
      {
         if(param1 < 0 || param1 >= this._allBloonTypes.length)
         {
            return Constants.RED_BLOON;
         }
         var _loc2_:MovieClip = this._allBloonTypes[param1];
         if(_loc2_ == _clip.bloonRed)
         {
            return Constants.RED_BLOON;
         }
         if(_loc2_ == _clip.bloonBlue)
         {
            return Constants.BLUE_BLOON;
         }
         if(_loc2_ == _clip.bloonGreen)
         {
            return Constants.GREEN_BLOON;
         }
         if(_loc2_ == _clip.bloonYellow)
         {
            return Constants.YELLOW_BLOON;
         }
         if(_loc2_ == _clip.bloonPink)
         {
            return Constants.PINK_BLOON;
         }
         if(_loc2_ == _clip.bloonBlack)
         {
            return Constants.BLACK_BLOON;
         }
         if(_loc2_ == _clip.bloonWater)
         {
            return Constants.WHITE_BLOON;
         }
         if(_loc2_ == _clip.bloonZebra)
         {
            return Constants.ZEBRA_BLOON;
         }
         if(_loc2_ == _clip.bloonLead)
         {
            return Constants.LEAD_BLOON;
         }
         if(_loc2_ == _clip.bloonRainbow)
         {
            return Constants.RAINBOW_BLOON;
         }
         if(_loc2_ == _clip.bloonCeramic)
         {
            return Constants.CERAMIC_BLOON;
         }
         if(_loc2_ == _clip.bloonMoab)
         {
            return Constants.MOAB_BLOON;
         }
         if(_loc2_ == _clip.bloonBfb)
         {
            return Constants.BFB_BLOON;
         }
         if(_loc2_ == _clip.bloonZomb)
         {
            return Constants.BOSS_BLOON;
         }
         if(_loc2_ == _clip.bloonDdt)
         {
            return Constants.DDT_BLOON;
         }
         return Constants.RED_BLOON;
      }
      
      public function getStrongestBloonType() : String
      {
         return this.getBloonString(this._bloonTypeSlider.currentIndex);
      }
   }
}
