package ninjakiwi.monkeyTown.town.ui
{
   import assets.icons.CostIndicator;
   import assets.ui.BuildingIconHit;
   import com.greensock.TweenLite;
   import fl.motion.AdjustColor;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class BuildingIcon extends ButtonControllerBase
   {
      
      private static var flattenedCache:Array = [];
      
      private static const COST_LABEL_Y:int = 80;
      
      private static const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private static const ROLL_OVER_TIME:Number = 0.13;
      
      private static const ROLL_OUT_TIME:Number = 0.16;
      
      private static const BASE_SHADOW_ALPHA:Number = 0.8;
      
      private static var glowFilter:GlowFilter = new GlowFilter(4294967295,1,5,5,20);
      
      private static var _currentFocusedBuildingIcon:BuildingIcon = null;
      
      private static const ROLLOVER_MOVE:int = 4;
       
      
      public var buildingDefinition:MonkeyTownBuildingDefinition;
      
      public var _costLabel:CostIndicator;
      
      public var available:Boolean = true;
      
      private var iconRect:Rectangle;
      
      public var homePosition:Point;
      
      public var building:MonkeyTownBuildingDefinition;
      
      public var index:int;
      
      public const view:MovieClip = new MovieClip();
      
      private var hitPad:BuildingIconHit;
      
      private var dropShadowFilter:DropShadowFilter;
      
      private var _unavailableFilter:ColorMatrixFilter;
      
      public function BuildingIcon(param1:MovieClip, param2:Boolean = true)
      {
         this._costLabel = new CostIndicator();
         this.iconRect = new Rectangle(0,-10,80,90);
         this.homePosition = new Point();
         this.hitPad = new BuildingIconHit();
         this.dropShadowFilter = new DropShadowFilter(2,125,0,1,5,5,BASE_SHADOW_ALPHA);
         this.view.addChild(this.hitPad);
         super(param1);
         this.view.buildingIcon = this;
         this.view.addChild(param1);
         param1.gotoAndStop(1);
         this.flatten(param1);
         this._costLabel.y = COST_LABEL_Y;
         if(param2)
         {
            this.view.addChild(this._costLabel);
         }
         param1.filters = [this.dropShadowFilter];
         this.initColorTransforms();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.buildingDefinition = null;
         this._costLabel = null;
         this.iconRect = null;
         this.homePosition = null;
         this.building = null;
      }
      
      private function initColorTransforms() : void
      {
         var _loc1_:AdjustColor = new AdjustColor();
         var _loc2_:Array = [];
         _loc1_.hue = 0;
         _loc1_.saturation = -100;
         _loc1_.brightness = 0;
         _loc1_.contrast = 0;
         _loc2_ = _loc1_.CalculateFinalFlatArray();
         this._unavailableFilter = new ColorMatrixFilter(_loc2_);
      }
      
      public function getView() : MovieClip
      {
         return this.view;
      }
      
      public function storeHomeState() : void
      {
         this.homePosition.x = target.x;
         this.homePosition.y = target.y;
      }
      
      public function overState(param1:MouseEvent = null) : void
      {
         if(this.available)
         {
            TweenLite.to(target,ROLL_OVER_TIME,{
               "y":this.homePosition.y - ROLLOVER_MOVE,
               "onUpdate":this.updateDropshadow
            });
         }
      }
      
      public function outState(param1:MouseEvent = null) : void
      {
         TweenLite.to(target,ROLL_OUT_TIME,{
            "y":this.homePosition.y,
            "onUpdate":this.updateDropshadow
         });
      }
      
      public function activateRollovers() : void
      {
         this.view.addEventListener(MouseEvent.ROLL_OVER,this.overState);
         this.view.addEventListener(MouseEvent.ROLL_OUT,this.outState);
      }
      
      public function deactivateRollovers() : void
      {
         this.view.removeEventListener(MouseEvent.ROLL_OVER,this.overState);
         this.view.removeEventListener(MouseEvent.ROLL_OUT,this.outState);
      }
      
      public function focus() : void
      {
         if(_currentFocusedBuildingIcon === this)
         {
            return;
         }
         if(_currentFocusedBuildingIcon !== null)
         {
            _currentFocusedBuildingIcon.unfocus();
         }
         target.y = this.homePosition.y - ROLLOVER_MOVE;
         this.deactivateRollovers();
         TweenLite.killTweensOf(target);
         target.filters = [glowFilter,this.dropShadowFilter];
         _currentFocusedBuildingIcon = this;
      }
      
      public function unfocus() : void
      {
         this.activateRollovers();
         target.filters = [this.dropShadowFilter];
         _currentFocusedBuildingIcon = null;
         this.outState();
      }
      
      public function syncAvailabilityToBuilding() : void
      {
         if(this.building === null)
         {
            return;
         }
         this.available = _system.city.buildingManager.hasCompletedBuilding(this.building.id);
         if(!this.available)
         {
            target.transform.colorTransform = MonkeySystem.unavailableColorTransform;
         }
         else
         {
            target.transform.colorTransform = new ColorTransform();
         }
      }
      
      public function set greyedOut(param1:Boolean) : void
      {
         if(param1)
         {
            target.transform.colorTransform = MonkeySystem.unavailableColorTransform;
         }
         else
         {
            target.transform.colorTransform = new ColorTransform();
         }
      }
      
      private function updateDropshadow() : void
      {
         var _loc1_:Number = (this.homePosition.y - target.y) / ROLLOVER_MOVE;
         this.dropShadowFilter.distance = 2 + _loc1_ * 10;
         this.dropShadowFilter.alpha = BASE_SHADOW_ALPHA - BASE_SHADOW_ALPHA * _loc1_ * 0.5;
         target.filters = [this.dropShadowFilter];
      }
      
      public function set label(param1:String) : void
      {
         this._costLabel.label.text = param1;
      }
      
      private function flatten(param1:DisplayObjectContainer) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Bitmap = null;
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(-this.iconRect.x,-this.iconRect.y);
         var _loc5_:String = getQualifiedClassName(target);
         if(flattenedCache[_loc5_])
         {
            _loc2_ = flattenedCache[_loc5_];
         }
         else
         {
            _loc2_ = new BitmapData(this.iconRect.width,this.iconRect.height,true,0);
            _loc2_.draw(param1,_loc4_);
            flattenedCache[_loc5_] = _loc2_;
         }
         _loc3_ = new Bitmap(_loc2_);
         _loc3_.smoothing = false;
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
         _loc3_.x = this.iconRect.x;
         _loc3_.y = this.iconRect.y;
         param1.addChild(_loc3_);
      }
   }
}
