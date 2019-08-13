package ninjakiwi.monkeyTown.ui
{
   import assets.town.LockClip;
   import assets.town.Tick;
   import assets.town.UpgradeIconBackgroundClip;
   import assets.town.UpgradeIconBackgroundClipBlue;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   import org.osflash.signals.Signal;
   
   public class UpgradeIcon extends MovieClip
   {
      
      protected static const tintLevel:Number = 0.7;
      
      protected static const tintColorTransform:ColorTransform = new ColorTransform(tintLevel,tintLevel,tintLevel,1);
       
      
      public const clickSignal:Signal = new Signal(UpgradeIcon);
      
      public const rolloverSignal:Signal = new Signal(UpgradeIcon);
      
      public const rolloutSignal:Signal = new Signal(UpgradeIcon);
      
      public var hasPurchased:Boolean = false;
      
      protected var _mainContainer:Sprite;
      
      protected var _backgroundOwned:UpgradeIconBackgroundClipBlue;
      
      protected var _backgroundNotOwned:UpgradeIconBackgroundClip;
      
      protected var _lockClip:LockClip;
      
      protected var _tickClip:Tick;
      
      protected var _iconGraphic:MovieClip;
      
      public function UpgradeIcon(param1:String)
      {
         this._mainContainer = new Sprite();
         this._backgroundOwned = new UpgradeIconBackgroundClipBlue();
         this._backgroundNotOwned = new UpgradeIconBackgroundClip();
         this._lockClip = new LockClip();
         this._tickClip = new Tick();
         super();
         addChild(this._mainContainer);
         this._backgroundOwned.gotoAndStop(1);
         this._mainContainer.addChild(this._backgroundOwned);
         this._mainContainer.addChild(this._backgroundNotOwned);
         var _loc2_:Class = this.getIconClass(param1);
         this._iconGraphic = new _loc2_();
         this._mainContainer.addChild(this._iconGraphic);
         addChild(this._lockClip);
         addChild(this._tickClip);
         this.setOwned(false);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollout);
      }
      
      public function enableClick() : void
      {
         this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      public function disableClick() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         this.clickSignal.dispatch(this);
      }
      
      private function onRollover(param1:MouseEvent) : void
      {
         this.rolloverSignal.dispatch(this);
      }
      
      private function onRollout(param1:MouseEvent) : void
      {
         this.rolloutSignal.dispatch(this);
      }
      
      public function setTintOn(param1:Boolean) : void
      {
         if(param1)
         {
            this._mainContainer.transform.colorTransform = tintColorTransform;
         }
         else
         {
            this._mainContainer.transform.colorTransform = new ColorTransform();
         }
      }
      
      public function setOwned(param1:Boolean) : void
      {
         this.hasPurchased = param1;
         this._backgroundOwned.visible = param1;
         this._backgroundNotOwned.visible = !param1;
         this._tickClip.visible = param1;
      }
      
      public function setLocked(param1:Boolean) : void
      {
         this._lockClip.visible = param1;
         if(param1)
         {
            this.setTintOn(true);
         }
         else
         {
            this.setTintOn(false);
         }
      }
      
      protected function getIconClass(param1:String) : Class
      {
         var iconClass:Class = null;
         var iconName:String = param1;
         try
         {
            iconClass = getDefinitionByName(iconName) as Class;
         }
         catch(e:Error)
         {
            return null;
         }
         return iconClass;
      }
   }
}
