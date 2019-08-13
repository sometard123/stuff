package ninjakiwi.monkeyTown.town.ui.currencyExchange
{
   import assets.ui.BloontoniumForBloonStonesInfoFullClip;
   import assets.ui.CashToBloontoniumPanelClip;
   import assets.ui.CityCashForBloonStonesInfoClip;
   import com.lgrey.signal.SignalHub;
   import com.lgrey.utils.LGDisplayListUtil;
   import com.lgrey.utils.LGMathUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.premiums.Premium;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   
   public class BloonstonesToBloontoniumExchangeUI extends HideRevealViewPopup
   {
       
      
      private const _clip:CashToBloontoniumPanelClip = new CashToBloontoniumPanelClip();
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private const LGMath:LGMathUtil = LGMathUtil.getInstance();
      
      private const _hubUI:SignalHub = SignalHub.getHub("ui");
      
      private const _displayListUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      private const tiersText:Array = ["Top up to full","Top up by half","Top up by 10%"];
      
      private const tiers:Array = [100,50,10];
      
      private const contentContainer:MovieClip = this._clip.contentContainer;
      
      public function BloonstonesToBloontoniumExchangeUI(param1:DisplayObjectContainer)
      {
         super(param1);
         this.init();
      }
      
      private function init() : void
      {
         enableDefaultOnResize(this._clip);
         enableCloseButton(this._clip.closeButton);
         addChild(this._clip);
         this._hubUI.add("requestBloonstonesToBloontoniumExchangeSignal",this.onRequestBloonstonesToBloontoniumExchange);
         isModal = true;
      }
      
      private function build() : void
      {
         var _loc1_:CityCashForBloonStonesInfoClip = null;
         var _loc4_:CostReport = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this._displayListUtil.removeAllChildren(this.contentContainer);
         var _loc2_:Number = this._resourceStore.bloontonium / this._resourceStore.bloontoniumCapacity * 100;
         var _loc3_:int = 0;
         _loc6_ = 80;
         var _loc7_:int = 20;
         var _loc8_:int = 0;
         while(_loc8_ < this.tiers.length)
         {
            _loc3_ = this.tiers[_loc8_];
            if(_loc3_ == 100)
            {
               _loc4_ = this.getCostForFillToMax();
            }
            else
            {
               _loc4_ = this.getCostForPercentFill(_loc3_);
            }
            if(_loc4_.hasEnoughStorageCapacity)
            {
               _loc1_ = new CityCashForBloonStonesInfoClip();
               this.initRollover(_loc1_);
               _loc1_.percentFillField.text = this.tiersText[_loc8_] + " ( " + _loc4_.bloontonium + " )";
               _loc1_.bloonstonesCostField.text = _loc4_.bloonstones.toString();
               _loc1_.report = _loc4_;
               if(_loc4_.hasEnoughBloonstones)
               {
                  _loc1_.addEventListener(MouseEvent.CLICK,this.infoPaneClickHandler);
               }
               else
               {
                  _loc1_.addEventListener(MouseEvent.CLICK,this.infoPaneCantAffordClickHandler);
               }
               _loc1_.priceNote.visible = false;
               _loc1_.saleIcon.visible = false;
               _loc1_.y = _loc5_;
               _loc1_.buttonMode = true;
               _loc1_.mouseChildren = false;
               _loc5_ = _loc5_ + _loc6_;
               this.contentContainer.addChild(_loc1_);
            }
            _loc8_++;
         }
         this._clip.background.height = this.contentContainer.y + _loc5_;
         centerOnStage();
      }
      
      private function initRollover(param1:CityCashForBloonStonesInfoClip) : void
      {
         var infoPane:CityCashForBloonStonesInfoClip = param1;
         infoPane.gotoAndStop(1);
         infoPane.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            infoPane.gotoAndStop(2);
         });
         infoPane.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            infoPane.gotoAndStop(1);
         });
      }
      
      private function buildAlreadyFull() : void
      {
         this._displayListUtil.removeAllChildren(this.contentContainer);
         var _loc1_:int = 20;
         var _loc2_:BloontoniumForBloonStonesInfoFullClip = new BloontoniumForBloonStonesInfoFullClip();
         _loc2_.addEventListener(MouseEvent.CLICK,this.infoPaneFullClickHandler);
         _loc2_.buttonMode = true;
         _loc2_.mouseChildren = false;
         this.contentContainer.addChild(_loc2_);
         this._clip.background.height = this.contentContainer.y + _loc2_.height + _loc1_;
         centerOnStage();
      }
      
      private function infoPaneFullClickHandler(param1:MouseEvent) : void
      {
         hide();
      }
      
      private function onRequestBloonstonesToBloontoniumExchange() : void
      {
         var _loc1_:Number = this._resourceStore.bloontonium / this._resourceStore.bloontoniumCapacity * 100;
         if(_loc1_ < 100)
         {
            this.build();
         }
         else
         {
            this.buildAlreadyFull();
         }
         reveal();
      }
      
      private function infoPaneClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CostReport = param1.currentTarget.report;
         GameMods.awardBloontonium(_loc2_.bloontonium);
         this._resourceStore.bloonstones = this._resourceStore.bloonstones - _loc2_.bloonstones;
         GameSignals.BOUGHT_BLOONTONIUM_WITH_BLOONSTONES.dispatch(int(_loc2_.perc),int(_loc2_.bloontonium),int(_loc2_.bloonstones));
         hide();
      }
      
      private function infoPaneCantAffordClickHandler(param1:MouseEvent) : void
      {
         Premium.getInstance().showStoreForBloonstones();
         hide();
      }
      
      private function getCostForPercentFill(param1:int) : CostReport#1075
      {
         param1 = this.LGMath.clamp(param1,0,100);
         var _loc2_:int = this._resourceStore.bloontoniumCapacity;
         var _loc3_:Number = Number(_loc2_ * param1) / 100;
         var _loc4_:int = Math.ceil(_loc3_ / Constants.BLOONTONIUM_PER_BLOONSTONE);
         var _loc5_:* = _loc4_ <= this._resourceStore.bloonstones;
         var _loc6_:* = _loc3_ + this._resourceStore.bloontonium <= _loc2_;
         return new CostReport#1075(param1,Math.ceil(_loc3_),_loc4_,_loc6_,_loc5_);
      }
      
      private function getCostForFillToMax() : CostReport#1075
      {
         var _loc1_:int = this._resourceStore.bloontoniumCapacity;
         var _loc2_:Number = _loc1_ - this._resourceStore.bloontonium;
         var _loc3_:int = Math.ceil(_loc2_ / Constants.BLOONTONIUM_PER_BLOONSTONE);
         var _loc4_:* = _loc3_ <= this._resourceStore.bloonstones;
         var _loc5_:Boolean = true;
         return new CostReport#1075(100,Math.ceil(_loc2_),_loc3_,_loc5_,_loc4_);
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this._displayListUtil.removeAllChildren(this.contentContainer);
      }
   }
}

class CostReport#1075
{
    
   
   public var bloontonium:int;
   
   public var bloonstones:int;
   
   public var hasEnoughStorageCapacity:Boolean;
   
   public var hasEnoughBloonstones:Boolean;
   
   public var perc:Number;
   
   function CostReport#1075(param1:Number, param2:int, param3:int, param4:Boolean, param5:Boolean)
   {
      super();
      this.perc = param1;
      this.bloontonium = param2;
      this.bloonstones = param3;
      this.hasEnoughStorageCapacity = param4;
      this.hasEnoughBloonstones = param5;
   }
}
