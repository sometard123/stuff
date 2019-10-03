package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import flash.display.MovieClip;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import org.osflash.signals.Signal;
   
   public class Awarder
   {
       
      
      protected var _quantity:INumber;
      
      public function Awarder(param1:Number)
      {
         this._quantity = DancingShadows.getOne();
         super();
         this._quantity.value = param1;
      }
      
      public function award() : void
      {
      }
      
      public function dispatchUISyncSignal() : void
      {
      }
      
      public function get quantity() : Number
      {
         return this._quantity.value;
      }
   }
}
