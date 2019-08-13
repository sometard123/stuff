package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.BlackSquare;
   import assets.ui.BuildingCityLoader;
   import fl.motion.AdjustColor;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataSlot;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   
   public class BuildProgressBar extends HideRevealView
   {
      
      public static var instance:BuildProgressBar;
       
      
      private var _clip:BuildingCityLoader;
      
      private var _targetFilters:Array = null;
      
      private var _targetColorTransform:ColorTransform = null;
      
      private var _colorFilter:AdjustColor;
      
      private var _effectColorTransform:ColorTransform;
      
      private var _effectColorMatrixFilter:ColorMatrixFilter;
      
      private var _blackBlocker:BlackSquare;
      
      private var _filters:Array;
      
      private var _tintIntensity:Number = 0.3;
      
      private var _tintR:int = 221;
      
      private var _tintG:int = 175;
      
      private var _tintB:int = 68;
      
      private var _saturation:Number = -100;
      
      private var _saturationFadeIncrement:Number = 8;
      
      public function BuildProgressBar(param1:DisplayObjectContainer)
      {
         this._clip = new BuildingCityLoader();
         this._colorFilter = new AdjustColor();
         this._blackBlocker = new BlackSquare();
         this._filters = [];
         super(param1);
         this.setProgress(0);
         addChild(this._blackBlocker);
         addChild(this._clip);
         while(this._clip.cityFilterContainer.numChildren > 0)
         {
            this._clip.cityFilterContainer.removeChildAt(0);
         }
         this.initColorTransforms();
         WorldViewSignals.buildWorldWithNameStartSignal.add(this.setCityName);
         WorldViewSignals.buildWorldProgressSignal.add(this.setProgress);
         WorldViewSignals.initialMVMDataReceived.add(this.hide);
         GameSignals.REPORT_GAME_LAUNCH_STATE.add(this.setMessage);
         setAutoPlayStopClipsArray([this._clip.mechanism.cogs]);
         instance = this;
      }
      
      private function onCityLoadBegin(param1:CityCommonDataSlot) : void
      {
         this.setCityName(param1.name);
      }
      
      private function initColorTransforms() : void
      {
         var _loc1_:Array = null;
         this._colorFilter.hue = 0;
         this._colorFilter.saturation = -100;
         this._colorFilter.brightness = 0;
         this._colorFilter.contrast = 0;
         _loc1_ = this._colorFilter.CalculateFinalFlatArray();
         this._effectColorMatrixFilter = new ColorMatrixFilter(_loc1_);
         this._effectColorTransform = this.getTintTransform(this._tintIntensity);
         this._filters = [this._effectColorMatrixFilter];
      }
      
      private function getTintTransform(param1:Number) : ColorTransform
      {
         return new ColorTransform(1,1,1,1,this._tintR * param1,this._tintG * param1,this._tintB * param1,0);
      }
      
      public function setProgress(param1:Number) : void
      {
      }
      
      public function setMessage(param1:String) : void
      {
         super.reveal(0);
         this._clip.mechanism.messageField.htmlText = param1;
      }
      
      public function setCityName(param1:String) : void
      {
         this._clip.mechanism.messageField.htmlText = "Loading " + param1 + "...";
      }
      
      override public function reveal(param1:Number = 0) : void
      {
         var time:Number = param1;
         super.reveal(time);
         this._effectColorTransform = this.getTintTransform(this._tintIntensity);
         this.setProgress(0);
         this._targetFilters = _system.mainBitmap.filters;
         this._targetColorTransform = _system.mainBitmap.transform.colorTransform;
         WorldViewSignals.worldIsNowVisibleSignal.addOnce(function():void
         {
            _effectColorTransform = getTintTransform(0.3);
            _system.mainBitmap.filters = _filters;
            _system.mainBitmap.transform.colorTransform = _effectColorTransform;
            TownUI.getInstance().hideHUD(0);
            setTimeout(function():void
            {
               _blackBlocker.visible = false;
            },16);
         });
      }
      
      public function hideWithoutEffects() : void
      {
         super.hide();
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         if(isRevealed)
         {
            setTimeout(this.fadeOut,300);
         }
         this.isRevealed = false;
      }
      
      private function fadeOut() : void
      {
         super.hide(0.5);
         this._saturation = -100;
         this.fadeOutEffects();
      }
      
      public function fadeInEffects() : void
      {
         this._saturation = 0;
         addEventListener(Event.ENTER_FRAME,this.fadeInEffectsUpdate);
         this._blackBlocker.alpha = 0;
         this._blackBlocker.visible = true;
      }
      
      private function fadeOutEffects() : void
      {
         addEventListener(Event.ENTER_FRAME,this.fadeOutEffectsUpdate);
      }
      
      private function fadeInEffectsUpdate(param1:Event) : void
      {
         this._saturation = this._saturation - this._saturationFadeIncrement;
         if(this._saturation < -100)
         {
            this._saturation = -100;
            removeEventListener(Event.ENTER_FRAME,this.fadeInEffectsUpdate);
         }
         this._blackBlocker.alpha = Math.abs(this._saturation) / 100;
         this.calculateFinalEffects();
      }
      
      private function fadeOutEffectsUpdate(param1:Event) : void
      {
         this._saturation = this._saturation + this._saturationFadeIncrement;
         if(this._saturation > 0)
         {
            this._saturation = 0;
            removeEventListener(Event.ENTER_FRAME,this.fadeOutEffectsUpdate);
            this.restoreTargetFilters();
            WorldViewSignals.buildProgressBarEndSignal.dispatch();
         }
         this.calculateFinalEffects();
      }
      
      private function calculateFinalEffects() : void
      {
         var _loc1_:Array = null;
         this._colorFilter.saturation = this._saturation;
         _loc1_ = this._colorFilter.CalculateFinalFlatArray();
         this._effectColorMatrixFilter = new ColorMatrixFilter(_loc1_);
         var _loc2_:Number = this._tintIntensity * (Math.abs(this._saturation) / 200);
         this._effectColorTransform = this.getTintTransform(_loc2_);
         _system.mainBitmap.filters = [this._effectColorMatrixFilter];
         _system.mainBitmap.transform.colorTransform = this._effectColorTransform;
      }
      
      private function restoreTargetFilters() : void
      {
         _system.mainBitmap.filters = this._targetFilters;
         _system.mainBitmap.transform.colorTransform = this._targetColorTransform;
      }
      
      override public function resize() : void
      {
         var _loc1_:Number = _system.flashStage.stageWidth;
         var _loc2_:Number = _system.flashStage.stageHeight;
         this._clip.vignette.width = _system.flashStage.stageWidth;
         this._clip.vignette.height = _system.flashStage.stageHeight;
         this._clip.mechanism.x = _loc1_ * 0.5;
         this._clip.mechanism.y = _loc2_ * 0.6;
         this._blackBlocker.width = _system.flashStage.stageWidth;
         this._blackBlocker.height = _system.flashStage.stageHeight;
      }
      
      override protected function onGlobalResetSignal() : void
      {
      }
   }
}
