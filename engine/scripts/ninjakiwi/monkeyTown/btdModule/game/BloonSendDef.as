package ninjakiwi.monkeyTown.btdModule.game
{
   public class BloonSendDef
   {
       
      
      public var id:String = null;
      
      public var type:int = 0;
      
      public var name:String = "";
      
      public var hotkey:String = "";
      
      public var quantity:int = 0;
      
      public var interval:Number = 0;
      
      public var cost:int = 0;
      
      public var incomeChange:Number = 0;
      
      public var unlockRound:int = 0;
      
      public var thumbStandard:Class = null;
      
      public var thumbCamo:Class = null;
      
      public var thumbRegen:Class = null;
      
      public var thumbRegenCamo:Class = null;
      
      public function BloonSendDef()
      {
         super();
      }
      
      public function ID(param1:String) : BloonSendDef
      {
         this.id = param1;
         return this;
      }
      
      public function Type(param1:int) : BloonSendDef
      {
         this.type = param1;
         return this;
      }
      
      public function Name(param1:String) : BloonSendDef
      {
         this.name = param1;
         return this;
      }
      
      public function Hotkey(param1:String) : BloonSendDef
      {
         this.hotkey = param1;
         return this;
      }
      
      public function Quantity(param1:int) : BloonSendDef
      {
         this.quantity = param1;
         return this;
      }
      
      public function Interval(param1:Number) : BloonSendDef
      {
         this.interval = param1;
         return this;
      }
      
      public function Cost(param1:int) : BloonSendDef
      {
         this.cost = param1;
         return this;
      }
      
      public function IncomeChange(param1:Number) : BloonSendDef
      {
         this.incomeChange = param1;
         return this;
      }
      
      public function UnlockRound(param1:int) : BloonSendDef
      {
         this.unlockRound = param1;
         return this;
      }
      
      public function ThumbStandard(param1:Class) : BloonSendDef
      {
         this.thumbStandard = param1;
         return this;
      }
      
      public function ThumbCamo(param1:Class) : BloonSendDef
      {
         this.thumbCamo = param1;
         return this;
      }
      
      public function ThumbRegen(param1:Class) : BloonSendDef
      {
         this.thumbRegen = param1;
         return this;
      }
      
      public function ThumbRegenCamo(param1:Class) : BloonSendDef
      {
         this.thumbRegenCamo = param1;
         return this;
      }
   }
}
