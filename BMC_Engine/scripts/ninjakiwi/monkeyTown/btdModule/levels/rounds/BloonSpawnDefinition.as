package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   
   public class BloonSpawnDefinition
   {
       
      
      public var spawnType:BloonSpawnType;
      
      public var spawnTime:Number;
      
      public var tutorialType:int;
      
      public function BloonSpawnDefinition()
      {
         this.tutorialType = Bloon.TUTORIAL_TYPE_INVALID;
         super();
      }
      
      public function Type(param1:BloonSpawnType) : BloonSpawnDefinition
      {
         this.spawnType = param1;
         return this;
      }
      
      public function SpawnTime(param1:Number) : BloonSpawnDefinition
      {
         this.spawnTime = param1;
         return this;
      }
   }
}
