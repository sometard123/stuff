package ninjakiwi.monkeyTown.btdModule.towers.modifiers
{
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class FreezeTemporaryModifier extends TowerModifier
   {
       
      
      private var _timeRemaining:Number = 0;
      
      public function FreezeTemporaryModifier(param1:Tower, param2:Number)
      {
         super(param1);
         mustBeUnique = true;
         this._timeRemaining = param2;
      }
      
      override public function apply() : void
      {
         tower.freeze(true);
      }
      
      override public function reset() : void
      {
         tower.freeze(false);
      }
      
      override public function update(param1:Number) : void
      {
         this._timeRemaining = this._timeRemaining - param1;
         if(this._timeRemaining <= 0)
         {
            die();
         }
      }
   }
}
