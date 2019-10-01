package ninjakiwi.monkeyTown.btdModule.premium
{
   import flash.events.EventDispatcher;
   
   public class ShopItemDef extends EventDispatcher
   {
      
      public static const CURRENCY_NKCOINS:int = 0;
      
      public static const CURRENCY_MEDALLIONS:int = 1;
       
      
      private var id_:int = 0;
      
      private var thumb_:Class = null;
      
      private var name_:String = null;
      
      private var description_:String = null;
      
      private var price_:int = 0;
      
      private var currency_:int = 0;
      
      private var _useLimit:int = 0;
      
      private var salePrice_:int = 0;
      
      private var mynkID_:int = 0;
      
      public function ShopItemDef()
      {
         super();
      }
      
      public function set id(param1:int) : void
      {
         this.id_ = param1;
      }
      
      public function get id() : int
      {
         return this.id_;
      }
      
      public function Id(param1:int) : ShopItemDef
      {
         this.id = param1;
         return this;
      }
      
      public function set thumb(param1:Class) : void
      {
         this.thumb_ = param1;
      }
      
      public function get thumb() : Class
      {
         return this.thumb_;
      }
      
      public function Thumb(param1:Class) : ShopItemDef
      {
         this.thumb = param1;
         return this;
      }
      
      public function set name(param1:String) : void
      {
         this.name_ = param1;
      }
      
      public function get name() : String
      {
         return this.name_;
      }
      
      public function Name(param1:String) : ShopItemDef
      {
         this.name = param1;
         return this;
      }
      
      public function set description(param1:String) : void
      {
         this.description_ = param1;
      }
      
      public function get description() : String
      {
         return this.description_;
      }
      
      public function Description(param1:String) : ShopItemDef
      {
         this.description = param1;
         return this;
      }
      
      public function set price(param1:int) : void
      {
         this.price_ = param1;
      }
      
      public function get price() : int
      {
         return this.price_;
      }
      
      public function Price(param1:int) : ShopItemDef
      {
         this.price = param1;
         return this;
      }
      
      public function set currency(param1:int) : void
      {
         this.currency_ = param1;
      }
      
      public function get currency() : int
      {
         return this.currency_;
      }
      
      public function Currency(param1:int) : ShopItemDef
      {
         this.currency_ = param1;
         return this;
      }
      
      public function set salePrice(param1:int) : void
      {
         this.salePrice_ = param1;
      }
      
      public function get salePrice() : int
      {
         return this.salePrice_;
      }
      
      public function SalePrice(param1:int) : ShopItemDef
      {
         this.salePrice = param1;
         return this;
      }
      
      public function set mynkID(param1:int) : void
      {
         this.mynkID_ = param1;
      }
      
      public function get mynkID() : int
      {
         return this.mynkID_;
      }
      
      public function MynkID(param1:int) : ShopItemDef
      {
         this.mynkID = param1;
         return this;
      }
      
      public function get useLimit() : int
      {
         return this._useLimit;
      }
      
      public function set useLimit(param1:int) : void
      {
         this._useLimit = param1;
      }
      
      public function UseLimit(param1:int) : ShopItemDef
      {
         this._useLimit = param1;
         return this;
      }
   }
}
