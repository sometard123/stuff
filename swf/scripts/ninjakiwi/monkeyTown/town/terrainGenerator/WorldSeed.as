package ninjakiwi.monkeyTown.town.terrainGenerator
{
   import ninjakiwi.monkeyTown.utils.Random;
   
   public class WorldSeed
   {
       
      
      public var metaSeed:uint;
      
      public var altitudeMapSeed:uint;
      
      public var grassSeed:uint;
      
      public var riverSeed:uint;
      
      public var treeSeed:uint;
      
      public var hillSeed:uint;
      
      public var snowSeed:uint;
      
      public var jungleSeed:uint;
      
      public var lakeSeed:uint;
      
      public var desertSeed:uint;
      
      public var beautifySeed:uint;
      
      public var specialItemsSeed:uint;
      
      public var terrainSpecialPropertiesSeed:uint;
      
      public var ruinsSeed:uint;
      
      public var worldCorrectionsSeed:uint;
      
      public var difficultyNoiseSeed:uint;
      
      public var variantHintSeed:uint;
      
      public var tileExtrasSeed:uint;
      
      private var RND:Random;
      
      public function WorldSeed()
      {
         this.RND = new Random();
         super();
      }
      
      public function randomise() : void
      {
         this._randomise();
      }
      
      public function randomiseSeeded(param1:uint) : void
      {
         this._randomise(true,param1);
         this.metaSeed = param1;
      }
      
      private function _randomise(param1:Boolean = false, param2:uint = 1) : void
      {
         if(param1)
         {
            this.RND.setSeed(param2);
         }
         else
         {
            this.RND.setSeed(Math.random() * int.MAX_VALUE);
         }
         this.altitudeMapSeed = this.getRandomUint(param1);
         this.grassSeed = this.getRandomUint(param1);
         this.riverSeed = this.getRandomUint(param1);
         this.treeSeed = this.getRandomUint(param1);
         this.hillSeed = this.getRandomUint(param1);
         this.snowSeed = this.getRandomUint(param1);
         this.jungleSeed = this.getRandomUint(param1);
         this.lakeSeed = this.getRandomUint(param1);
         this.desertSeed = this.getRandomUint(param1);
         this.beautifySeed = this.getRandomUint(param1);
         this.specialItemsSeed = this.getRandomUint(param1);
         this.terrainSpecialPropertiesSeed = this.getRandomUint(param1);
         this.ruinsSeed = this.getRandomUint(param1);
         this.worldCorrectionsSeed = this.getRandomUint(param1);
         this.difficultyNoiseSeed = this.getRandomUint(param1);
         this.variantHintSeed = this.getRandomUint(param1);
         this.tileExtrasSeed = this.getRandomUint(param1);
      }
      
      public function getRandomUint(param1:Boolean) : uint
      {
         if(param1)
         {
            return this.RND.nextInteger() + 1;
         }
         return Math.random() * int.MAX_VALUE + 1;
      }
   }
}
