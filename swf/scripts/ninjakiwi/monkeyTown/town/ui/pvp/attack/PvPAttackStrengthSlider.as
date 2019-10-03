package ninjakiwi.monkeyTown.town.ui.pvp.attack
{
   import assets.town.PvPAdvancedAttackClipNewVersion;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.pvp.Friend;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuButton;
   import ninjakiwi.monkeyTown.town.ui.slider.Slider;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PvPAttackStrengthSlider extends PvPAttackBaseSlider
   {
       
      
      private const MAX_LEVEL:int = 41;
      
      private const BLOONTONIUM_AT_MAX_LEVEL:int = 9000;
      
      private const BLOONTONIUM_AT_MIN_LEVEL:int = 1000;
      
      private const MIN_LEVEL:int = 8;
      
      private const VERY_HARD:Number = 1.33;
      
      private const MODERATE:Number = 1.0;
      
      private const MAX_BLOONTONIUM:int = 11970.0;
      
      private var _strengthSlider:Slider;
      
      private var _selectedBloontonium:INumber;
      
      public function PvPAttackStrengthSlider(param1:PvPAdvancedAttackClipNewVersion)
      {
         this._selectedBloontonium = DancingShadows.getOne();
         super(param1,Slider.HORIZONTAL);
         _clip.strengthSliderGuide.visible = false;
         this._strengthSlider = new Slider(_clip.strengthSliderGuide,_clip.strengthSlideBar,MonkeySystem.getInstance().flashStage);
         this._strengthSlider.dragUpdateSignal.add(this.needSync);
      }
      
      public function setOpponent(param1:Friend, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         _loc3_ = var _loc3_:Object = PvPMain.getMatchingCity(param1.cities,param2);
         if(_loc3_ != null)
         {
            _loc4_ = this.expectedBloontonium(this.clampLevel(_loc3_.level));
            _loc5_ = _loc4_ * this.MODERATE / this.MAX_BLOONTONIUM;
            _loc6_ = _loc4_ * this.VERY_HARD / this.MAX_BLOONTONIUM;
            _clip.strengthMin.x = _clip.strengthSliderGuide.width * _loc5_ + _clip.strengthSliderGuide.x;
            _clip.strengthMax.x = _clip.strengthSliderGuide.width * _loc6_ + _clip.strengthSliderGuide.x;
            _loc7_ = _loc4_ / this.MAX_BLOONTONIUM;
            if(_resourceStore.bloontonium < _loc4_)
            {
               _loc7_ = _resourceStore.bloontonium / this.MAX_BLOONTONIUM;
            }
            this._strengthSlider.setPosition(_loc7_);
            this._strengthSlider.setMin(_loc5_);
            this._strengthSlider.setMax(_loc6_);
         }
      }
      
      private function clampLevel(param1:int) : int
      {
         if(param1 > this.MAX_LEVEL)
         {
            return this.MAX_LEVEL;
         }
         if(param1 < this.MIN_LEVEL)
         {
            return this.MIN_LEVEL;
         }
         return param1;
      }
      
      private function getLeastAttackLevel(param1:Friend, param2:int) : int
      {
         var _loc3_:Object = PvPMain.getMatchingCity(param1.cities,param2);
         if(null == _loc3_)
         {
            return int.MAX_VALUE;
         }
         var _loc4_:int = this.expectedBloontonium(this.clampLevel(_loc3_.level));
         return this.MAX_LEVEL * (_loc4_ * this.MODERATE / this.MAX_BLOONTONIUM);
      }
      
      public function getLeastDifficulty(param1:Friend, param2:int) : int
      {
         var _loc3_:Object = PvPMain.getMatchingCity(param1.cities,param2);
         if(null == _loc3_)
         {
            return int.MAX_VALUE;
         }
         var _loc4_:int = this.expectedBloontonium(this.clampLevel(_loc3_.level));
         var _loc5_:Number = _loc4_ * this.MODERATE / this.MAX_BLOONTONIUM;
         return this.getDifficulty(this.MAX_BLOONTONIUM * _loc5_);
      }
      
      private function expectedBloontonium(param1:int) : int
      {
         return param1 * 250 - 1000;
      }
      
      private function getDifficulty(param1:int) : Number
      {
         var _loc2_:Number = (this.MAX_LEVEL - this.MIN_LEVEL) / (this.BLOONTONIUM_AT_MAX_LEVEL - this.BLOONTONIUM_AT_MIN_LEVEL);
         var _loc3_:Number = this.MIN_LEVEL - _loc2_ * this.BLOONTONIUM_AT_MIN_LEVEL;
         var _loc4_:Number = param1 * _loc2_ + _loc3_;
         return _loc4_;
      }
      
      public function getDifficultyForInvestment() : Number
      {
         return this.getDifficulty(this.getInvestedBloontonium());
      }
      
      public function getInvestedBloontonium() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = this._selectedBloontonium.value;
         _loc2_ = _loc1_ - (_resourceStore.bloontonium + _resourceStore.getTempOverage());
         var _loc3_:int = _loc2_ % Constants.BLOONTONIUM_PER_BLOONSTONE;
         if(_loc3_ > 0)
         {
            _loc1_ = _loc1_ - _loc3_;
         }
         return _loc1_;
      }
      
      public function getInvestedAttackLevel() : int
      {
         return this._selectedBloontonium.value;
      }
      
      public function setInvestedBloontonium(param1:int) : void
      {
         var _loc2_:int = this.MAX_BLOONTONIUM * this._strengthSlider.max;
         var _loc3_:int = this.MAX_BLOONTONIUM * this._strengthSlider.min;
         if(param1 < _loc3_)
         {
            param1 = _loc3_;
         }
         else if(param1 > _loc2_)
         {
            param1 = _loc2_;
         }
         this._strengthSlider.setPosition(param1 / this.MAX_BLOONTONIUM);
         this._selectedBloontonium.value = param1;
         this.syncWithCachedBloontonium();
      }
      
      private function syncWithCachedBloontonium() : void
      {
         super.needSync();
      }
      
      override protected function needSync() : void
      {
         this.cachBloontonium();
         super.needSync();
      }
      
      private function cachBloontonium() : void
      {
         this._selectedBloontonium.value = this.MAX_BLOONTONIUM * this._strengthSlider.getPosition();
      }
   }
}
