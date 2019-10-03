package ninjakiwi.monkeyTown.town.ui.currencyExchange
{
   import assets.ui.CityCashForBloonStonesInfoClip;
   import assets.ui.CurrencyExchangePanelClip;
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
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   
   public class BloonstonesToCashExchangeUI extends HideRevealViewPopup
   {
       
      
      private var _clip:CurrencyExchangePanelClip;
      
      private var _resourceStore:ResourceStore;
      
      private const LGMath:LGMathUtil = LGMathUtil.getInstance();
      
      private const _hubUI:SignalHub = SignalHub.getHub("ui");
      
      private const _displayListUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      private const tiersText:Array = ["Top up to full","Top up by half","Top up by 10%"];
      
      private const tiers:Array = [100,50,10];
      
      private var contentContainer:MovieClip;
      
      public function BloonstonesToCashExchangeUI(param1:DisplayObjectContainer)
      {
         this._clip = new CurrencyExchangePanelClip();
         this._resourceStore = ResourceStore.getInstance();
         this.contentContainer = this._clip.contentContainer;
         super(param1);
         this.init();
      }
      
      private function init() : void
      {
         enableDefaultOnResize(this._clip);
         enableCloseButton(this._clip.closeButton);
         addChild(this._clip);
         this._hubUI.add("requestBloonstonesToCashExchange",this.onRequestBloonstonesToCashExchange);
         isModal = true;
      }
      
      private function build() : void
      {
         var _loc1_:CityCashForBloonStonesInfoClip = null;
         var _loc4_:CostReport = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this._displayListUtil.removeAllChildren(this.contentContainer);
         var _loc2_:Number = this._resourceStore.spendableMonkeyMoney / this._resourceStore.bankCapacity * 100;
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
            if(_loc4_.hasEnoughBankCapacity)
            {
               _loc1_ = new CityCashForBloonStonesInfoClip();
               this.initRollover(_loc1_);
               _loc1_.percentFillField.text = this.tiersText[_loc8_] + " ( $" + _loc4_.cash + " )";
               _loc1_.bloonstonesCostField.text = _loc4_.bloonstones.toString();
               if(_loc4_.bloonstonesBeforeModifier !== _loc4_.bloonstones)
               {
                  _loc1_.priceNote.priceNoteField.text = _loc4_.bloonstonesBeforeModifier.toString();
               }
               else
               {
                  _loc1_.priceNote.visible = false;
                  _loc1_.saleIcon.visible = false;
               }
               _loc1_.report = _loc4_;
               if(_loc4_.hasEnoughBloonstones)
               {
                  _loc1_.addEventListener(MouseEvent.CLICK,this.infoPaneClickHandler);
               }
               else
               {
                  _loc1_.addEventListener(MouseEvent.CLICK,this.infoPaneCantAffordClickHandler);
               }
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
         var _loc2_:CityCashForBloonStonesInfoFullClip = new CityCashForBloonStonesInfoFullClip();
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
      
      private function onRequestBloonstonesToCashExchange() : void
      {
         var _loc1_:Number = this._resourceStore.spendableMonkeyMoney / this._resourceStore.bankCapacity * 100;
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
         if(!_loc2_)
         {
            return;
         }
         GameMods.awardCash(_loc2_.cash);
         this._resourceStore.bloonstones = this._resourceStore.bloonstones - _loc2_.bloonstones;
         hide();
         GameSignals.BOUGHT_CASH_WITH_BLOONSTONES.dispatch(int(_loc2_.perc * 100),int(_loc2_.cash),int(_loc2_.bloonstones));
      }
      
      private function infoPaneCantAffordClickHandler(param1:MouseEvent) : void
      {
         Premium.getInstance().showStoreForBloonstones();
         hide();
      }
      
      private function getCostForPercentFill(param1:int) : CostReport#994
      {
         param1 = this.LGMath.clamp(param1,0,100);
         var _loc2_:int = Constants.CASH_PER_BLOONSTONE;
         var _loc3_:int = this._resourceStore.bankCapacity;
         var _loc4_:Number = Number(_loc3_ * param1) / 100;
         var _loc5_:int = Math.ceil(_loc4_ / _loc2_);
         var _loc6_:* = _loc4_ + this._resourceStore.spendableMonkeyMoney <= _loc3_;
         var _loc7_:int = _loc5_;
         _loc5_ = Math.ceil(_loc5_ * GameEventManager.getInstance().cashBloonstoneExchangeRateModifier.modifier);
         var _loc8_:* = _loc5_ <= this._resourceStore.bloonstones;
         return new CostReport#994(param1 * 0.01,Math.ceil(_loc4_),_loc5_,_loc6_,_loc8_,_loc7_);
      }
      
      private function getCostForFillToMax() : CostReport#994
      {
         var _loc1_:int = Constants.CASH_PER_BLOONSTONE;
         var _loc2_:int = this._resourceStore.bankCapacity;
         var _loc3_:Number = _loc2_ - this._resourceStore.monkeyMoney;
         var _loc4_:int = Math.ceil(_loc3_ / _loc1_);
         var _loc5_:Boolean = true;
         var _loc6_:int = _loc4_;
         _loc4_ = Math.ceil(_loc4_ * GameEventManager.getInstance().cashBloonstoneExchangeRateModifier.modifier);
         var _loc7_:* = _loc4_ <= this._resourceStore.bloonstones;
         return new CostReport#994(1,Math.ceil(_loc3_),_loc4_,_loc5_,_loc7_,_loc6_);
      }
   }
}

class CostReport#994
{
    
   
   public var perc:Number;
   
   public var cash:int;
   
   public var bloonstones:int;
   
   public var bloonstonesBeforeModifier:int;
   
   public var hasEnoughBankCapacity:Boolean;
   
   public var hasEnoughBloonstones:Boolean;
   
   function CostReport#994(param1:Number, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:int = -1)
   {
      super();
      this.perc = param1;
      this.cash = param2;
      this.bloonstones = param3;
      this.hasEnoughBankCapacity = param4;
      this.hasEnoughBloonstones = param5;
      if(param6 == -1)
      {
         this.bloonstonesBeforeModifier = param3;
      }
      else
      {
         this.bloonstonesBeforeModifier = param6;
      }
   }
}
