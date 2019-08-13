package ninjakiwi.monkeyTown.town.ui.salePanels
{
   import assets.ui.SaleItemInfoBoxClip;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import org.osflash.signals.Signal;
   
   public class SaleItemInfoBox extends Sprite
   {
       
      
      private var _clip:SaleItemInfoBoxClip;
      
      private var _costField:TextField;
      
      private var _buyButton:ButtonControllerBase;
      
      private var _data:Object;
      
      public const buySignal:Signal = new Signal();
      
      public function SaleItemInfoBox(param1:Object)
      {
         this._clip = new SaleItemInfoBoxClip();
         this._costField = this._clip.costField;
         this._buyButton = new ButtonControllerBase(this._clip.buyButton);
         super();
         this._data = param1;
         addChild(this._clip);
         this.init(param1);
      }
      
      private function init(param1:Object) : void
      {
         var _loc2_:MovieClip = null;
         this._buyButton.setClickFunction(this.buy);
         this._clip.titleField.text = param1.title;
         this._clip.descriptionField.text = param1.description;
         this._costField.text = param1.cost.toString();
         if(param1.iconClass is Class)
         {
            _loc2_ = new param1.iconClass();
            _loc2_.x = this._clip.iconPlaceholder.x;
            _loc2_.y = this._clip.iconPlaceholder.y;
            this._clip.removeChild(this._clip.iconPlaceholder);
            this._clip.addChild(_loc2_);
         }
         if(Kong.isOnKong())
         {
            this._clip.currencyIcon.gotoAndStop(2);
         }
         else
         {
            this._clip.currencyIcon.gotoAndStop(1);
         }
         if(param1.hasOwnProperty("regularCost"))
         {
            this._clip.priceNote.visible = true;
            this._clip.priceNote.priceNoteField.text = param1.regularCost;
         }
         else
         {
            this._clip.priceNote.visible = false;
         }
      }
      
      private function buy() : void
      {
         this.buySignal.dispatch(JSON.parse(JSON.stringify(this._data)));
      }
   }
}
