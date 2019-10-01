package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   
   public class Round
   {
       
      
      private var _timeElapsed:Number = 0;
      
      private var _spawnIndex:int;
      
      private var _level:Level;
      
      private var _bloonSpawnDefinitions:Array;
      
      private var _spawnTime:Number = 0;
      
      public function Round(param1:Level)
      {
         this._bloonSpawnDefinitions = [];
         super();
         this._level = param1;
      }
      
      public function queueBloon(param1:BloonSpawnType, param2:int = -1) : void
      {
         this._spawnTime = this._spawnTime + param1.spacing;
         this._bloonSpawnDefinitions.push(new BloonSpawnDefinition().Type(param1).SpawnTime(this._spawnTime));
      }
      
      public function insertPause(param1:Number) : void
      {
         this._spawnTime = this._spawnTime + param1;
      }
      
      public function finalise() : void
      {
         this._bloonSpawnDefinitions.sortOn("spawnTime",Array.NUMERIC);
      }
      
      public function startRound() : void
      {
         this._timeElapsed = 0;
         this._spawnIndex = 0;
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Bloon = null;
         this._timeElapsed = this._timeElapsed + param1;
         var _loc3_:BloonSpawnDefinition = this._bloonSpawnDefinitions[this._spawnIndex];
         while(_loc3_ !== null && _loc3_.spawnTime <= this._timeElapsed)
         {
            _loc2_ = new Bloon();
            _loc2_.initialise(this._level,_loc3_.spawnType.type,this._level.startTile,0,_loc3_.spawnType.regen,_loc3_.spawnType.camo,this._timeElapsed);
            if(_loc3_.tutorialType != Bloon.TUTORIAL_TYPE_INVALID)
            {
               Bloon.tutorialBloonSpawned.dispatch(_loc3_.tutorialType);
               _loc3_.tutorialType = Bloon.TUTORIAL_TYPE_INVALID;
            }
            this._level.addBloon(_loc2_);
            this._spawnIndex = this._spawnIndex + 1;
            if(this._spawnIndex < this._bloonSpawnDefinitions.length)
            {
               _loc3_ = this._bloonSpawnDefinitions[this._spawnIndex];
            }
            else
            {
               _loc3_ = null;
            }
         }
      }
      
      public function get currentTimeStamp() : Number
      {
         return this._timeElapsed;
      }
      
      public function hasCuedBloons() : Boolean
      {
         return this._spawnIndex < this._bloonSpawnDefinitions.length;
      }
      
      public function insertSpawnGroup(param1:GroupDefinition) : void
      {
         var _loc2_:int = this._spawnIndex;
         if(this._spawnIndex > this._bloonSpawnDefinitions.length - 1)
         {
            this._spawnIndex = this._bloonSpawnDefinitions.length - 1;
         }
         var _loc3_:Number = this._bloonSpawnDefinitions[this._spawnIndex].spawnTime + 0.5;
         var _loc4_:int = 0;
         while(_loc4_ < param1.numberOfBloons)
         {
            this._bloonSpawnDefinitions.push(new BloonSpawnDefinition().Type(param1.bloonSpawnType).SpawnTime(_loc3_));
            _loc3_ = _loc3_ + param1.bloonSpawnType.spacing;
            _loc4_++;
         }
         this.finalise();
         this._spawnIndex = _loc2_;
      }
      
      public function describe() : void
      {
         var _loc1_:BloonSpawnDefinition = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._bloonSpawnDefinitions.length)
         {
            _loc1_ = this._bloonSpawnDefinitions[_loc2_];
            _loc2_++;
         }
      }
      
      public function get duration() : Number
      {
         return this._spawnTime;
      }
      
      public function get queuedBloons() : Array
      {
         return this._bloonSpawnDefinitions;
      }
      
      public function set currentTimeStamp(param1:Number) : void
      {
         this._timeElapsed = param1;
      }
      
      public function set spawnIndex(param1:int) : void
      {
         this._spawnIndex = param1;
      }
      
      public function set spawnTime(param1:Number) : void
      {
         this._spawnTime = param1;
      }
   }
}
