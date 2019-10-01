package ninjakiwi.monkeyTown.town.ui.informationBar
{
   import org.osflash.signals.Signal;
   
   public class LockedElement
   {
       
      
      private var _trigger:Signal;
      
      private var _numbers:Vector.<Element>;
      
      public function LockedElement(param1:Signal)
      {
         this._numbers = new Vector.<LockedElement>();
         super();
         this._trigger = param1;
         this._trigger.addOnce(this.onTrigger);
      }
      
      public function addNumber(param1:InformationNumber, param2:int) : void
      {
         var _loc3_:Element = null;
         if(param2 != 0)
         {
            _loc3_ = new Element();
            _loc3_.number = param1;
            _loc3_.value = param2;
            this._numbers.push(_loc3_);
         }
      }
      
      public function reset() : void
      {
         if(this._trigger != null)
         {
            this._trigger.remove(this.onTrigger);
         }
      }
      
      private function onTrigger(... rest) : void
      {
         var _loc2_:Element = null;
         for each(_loc2_ in this._numbers)
         {
            if(_loc2_.number != null)
            {
               _loc2_.number.addValueToDisplay(_loc2_.value);
            }
         }
      }
   }
}

import ninjakiwi.monkeyTown.town.ui.informationBar.InformationNumber;

class Element
{
    
   
   public var number:InformationNumber;
   
   public var value:int;
   
   function Element()
   {
      super();
   }
}
