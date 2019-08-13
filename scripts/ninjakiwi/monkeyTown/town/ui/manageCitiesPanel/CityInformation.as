package ninjakiwi.monkeyTown.town.ui.manageCitiesPanel
{
   import assets.town.CityInformationClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataSlot;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class CityInformation extends Sprite
   {
      
      public static const requestCollectResourcesSignal:Signal = new Signal(CityInformation);
      
      public static const citySelectedSignal:Signal = new Signal(CityInformation);
       
      
      private var _clip:CityInformationClip;
      
      public var slot:CityCommonDataSlot;
      
      private var _collectResourcesButton:ButtonControllerBase;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public function CityInformation()
      {
         this._clip = new CityInformationClip();
         this._collectResourcesButton = new ButtonControllerBase(this._clip.collectResourcesButton);
         super();
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this._collectResourcesButton.setClickFunction(this.onCollectResourcesButtonClicked);
         this._clip.collectingResourcesIndicator.visible = false;
         this._clip.mainHitArea.alpha = 0;
         this._clip.mainHitArea.addEventListener(MouseEvent.CLICK,this.onSelectionClickHandler);
         this._collectResourcesButton.target.visible = false;
      }
      
      private function onSelectionClickHandler(param1:MouseEvent) : void
      {
         citySelectedSignal.dispatch(this);
      }
      
      private function onCollectResourcesButtonClicked() : void
      {
         this._collectResourcesButton.lock();
         this._clip.collectingResourcesIndicator.visible = true;
         requestCollectResourcesSignal.dispatch(this);
      }
      
      public function collectResourcesComplete() : void
      {
         this._collectResourcesButton.unlock();
         this._clip.collectingResourcesIndicator.visible = false;
      }
      
      public function syncToSaveSlot(param1:CityCommonDataSlot) : void
      {
         this.slot = param1;
         this.setName(param1.name);
         if(param1.bucketID == this._system.city.cityIndex)
         {
            this._collectResourcesButton.target.visible = false;
         }
      }
      
      public function setName(param1:String) : void
      {
         this._clip.cityNameField.htmlText = param1;
      }
      
      private function setLevel(param1:int) : void
      {
         this._clip.levelField.htmlText = "Level: " + param1;
      }
   }
}
