package ninjakiwi.monkeyTown.btdModule.towers.modifiers
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class AttackSpeedTemporaryModifierBuff extends TowerModifier
   {
       
      
      private var _timeRemaining:Number = 0;
      
      private var _speedModifier:Number = 1.0;
      
      public function AttackSpeedTemporaryModifierBuff(param1:Tower, param2:Number, param3:Number)
      {
         super(param1);
         mustBeUnique = true;
         this._timeRemaining = param2;
         this._speedModifier = param3;
      }
      
      override public function apply() : void
      {
         tower.scaleAttackSpeed(this._speedModifier);
      }
      
      override public function reset() : void
      {
         tower.unScaleAttackSpeed(this._speedModifier);
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
