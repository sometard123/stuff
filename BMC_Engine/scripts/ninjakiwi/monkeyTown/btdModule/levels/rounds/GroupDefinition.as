package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   public class GroupDefinition
   {
       
      
      public var bloonSpawnType:BloonSpawnType;
      
      public var sortRank:Number = 0;
      
      public var numberOfBloons:int;
      
      public function GroupDefinition(param1:BloonSpawnType, param2:int, param3:Number)
      {
         super();
         this.bloonSpawnType = param1;
         this.sortRank = param3;
         this.numberOfBloons = param2;
      }
   }
}
