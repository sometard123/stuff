package ninjakiwi.monkeyTown.town.city
{
   import flash.display.DisplayObjectContainer;
   
   public class ActiveCity extends City
   {
       
      
      protected var _isActive:Boolean = false;
      
      public function ActiveCity(param1:DisplayObjectContainer, param2:int)
      {
         super(param1,param2);
         this._isActive = true;
         ActiveCitySignals.setTargetCity(this);
      }
      
      public function dispose() : void
      {
         this._isActive = false;
      }
      
      public function getIsActive() : Boolean
      {
         return this._isActive;
      }
      
      public function setIsActive(param1:Boolean) : void
      {
         this._isActive = param1;
      }
   }
}
