package ninjakiwi.monkeyTown.btdModule.abilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGenerator;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class SupplyDrop extends Ability
   {
      
      private static const MAX_ACTIVATIONS_PER_ROUND:int = 2;
      
      private static var _numOfTimesUsedThisRound:int = 0;
      
      private static var _isReady:Boolean = true;
       
      
      public function SupplyDrop()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         RoundGenerator.roundStartSignal.remove(this.onRoundStart);
         RoundGenerator.roundStartSignal.add(this.onRoundStart);
         var _loc3_:ninjakiwi.monkeyTown.btdModule.entities.SupplyDrop = new ninjakiwi.monkeyTown.btdModule.entities.SupplyDrop();
         _loc3_.initialise(param1);
         param1.level.addEntity(_loc3_);
         super.execute(param1,param2);
         _numOfTimesUsedThisRound++;
      }
      
      private function onRoundStart(param1:int) : void
      {
         _isReady = true;
         RoundGenerator.roundStartSignal.remove(this.onRoundStart);
         _numOfTimesUsedThisRound = 0;
      }
      
      override public function get isReady() : Boolean
      {
         return _isReady;
      }
   }
}
