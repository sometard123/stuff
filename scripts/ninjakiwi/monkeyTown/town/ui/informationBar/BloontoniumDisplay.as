package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import assets.ui.BurstAnimation;
   import com.lgrey.signal.SignalHub;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.city.ActiveCitySignals;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import org.osflash.signals.Signal;
   
   public class BloontoniumDisplay extends InformationNumber
   {
       
      
      public const requestBloonstonesToBloontoniumExchangeSignal:Signal = SignalHub.getHub("ui").defineSignal("requestBloonstonesToBloontoniumExchangeSignal");
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      public function BloontoniumDisplay(param1:TextField, param2:BurstAnimation, param3:MovieClip)
      {
         super(param1,param2,param3,this._resourceStore.bloontoniumStorageCapacity,this.moreBloontoniumButtonClickHandler);
         ActiveCitySignals.bloontoniumChangedDiffSignal.add(this.updateBloontoniumDisplay);
         ActiveCitySignals.maximumBloontoniumChangedSignal.add(setMaximum);
      }
      
      private function updateBloontoniumDisplay(param1:int) : void
      {
         setMaximum(this._resourceStore.bloontoniumCapacity);
         addValue(param1);
      }
      
      override public function sync() : void
      {
         setMaximum(this._resourceStore.bloontoniumCapacity);
         updateValue(this._resourceStore.bloontonium + this._resourceStore.getTempOverage());
      }
      
      private function moreBloontoniumButtonClickHandler(param1:MouseEvent) : void
      {
         this.requestBloonstonesToBloontoniumExchangeSignal.dispatch();
      }
      
      override protected function buttonRolloverHandler(param1:Event) : void
      {
         TownUI.showToolTipSignal.dispatch(LocalisationConstants.HINT_BLOONTOINUM);
      }
   }
}
