package ninjakiwi.monkeyTown.town.ui
{
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import org.osflash.signals.Signal;
   
   public class RadioGroup
   {
       
      
      private const _tickBoxList:Vector.<RadioGroupElement> = new Vector.<RadioGroupElement>();
      
      private var _lastTickedBox:RadioGroupElement = null;
      
      private var _defaultTickBox:RadioGroupElement = null;
      
      private var _enable:Boolean = false;
      
      public const changed:Signal = new Signal();
      
      public function RadioGroup()
      {
         super();
      }
      
      public function destroy() : void
      {
         var _loc1_:RadioGroupElement = null;
         for each(_loc1_ in this._tickBoxList)
         {
            _loc1_.tickBox.changedSignal.remove(this.setTicked);
         }
         this._tickBoxList.length = 0;
      }
      
      public function addTickBox(param1:TickBox, param2:Number, param3:int, param4:Boolean = false) : void
      {
         var _loc5_:RadioGroupElement = new RadioGroupElement(param1,param2,param3);
         if(param4)
         {
            this._defaultTickBox = _loc5_;
         }
         param1.clickedSignal.add(this.setTicked);
         this._tickBoxList.push(_loc5_);
      }
      
      public function reset() : void
      {
         if(this._defaultTickBox != null)
         {
            this.setTicked(this._defaultTickBox.tickBox);
         }
         this.enable = true;
      }
      
      public function setTicked(param1:TickBox, param2:Boolean = true) : void
      {
         if(this._lastTickedBox != null && this._lastTickedBox.tickBox != null)
         {
            this._lastTickedBox.tickBox.ticked = false;
         }
         this._lastTickedBox = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:RadioGroupElement = this.findElementByTickBox(param1);
         if(_loc3_ != null)
         {
            this._lastTickedBox = _loc3_;
            if(this._lastTickedBox.tickBox != null)
            {
               this._lastTickedBox.tickBox.ticked = true;
            }
         }
         if(param2)
         {
            this.changed.dispatch();
         }
      }
      
      public function set enable(param1:Boolean) : void
      {
         var _loc2_:RadioGroupElement = null;
         for each(_loc2_ in this._tickBoxList)
         {
            if(_loc2_.tickBox != null)
            {
               _loc2_.tickBox.enabled = param1;
            }
         }
         if(param1 == true && this._lastTickedBox != null)
         {
            this.setTicked(this._lastTickedBox.tickBox,false);
         }
         this._enable = param1;
      }
      
      public function getTickedValue() : Number
      {
         if(this._lastTickedBox != null)
         {
            return this._lastTickedBox.value;
         }
         return 0;
      }
      
      public function getTickedDescriptionValue() : int
      {
         if(this._lastTickedBox != null && this._enable == true)
         {
            return this._lastTickedBox.descriptionValue;
         }
         return -1;
      }
      
      private function findElementByTickBox(param1:TickBox) : RadioGroupElement
      {
         var _loc2_:RadioGroupElement = null;
         for each(_loc2_ in this._tickBoxList)
         {
            if(_loc2_.tickBox == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

import ninjakiwi.monkeyTown.ui.buttons.TickBox;

class RadioGroupElement
{
    
   
   private var _tickBox:TickBox;
   
   private var _value:Number;
   
   private var _descriptionValue:int;
   
   function RadioGroupElement(param1:TickBox, param2:Number, param3:int)
   {
      super();
      this._tickBox = param1;
      this._value = param2;
      this._descriptionValue = param3;
   }
   
   public function get tickBox() : TickBox
   {
      return this._tickBox;
   }
   
   public function get value() : Number
   {
      return this._value;
   }
   
   public function get descriptionValue() : int
   {
      return this._descriptionValue;
   }
}
