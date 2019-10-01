package ninjakiwi.monkeyTown.btdModule.analytics
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class BenchmarkTracking
   {
      
      private static const ENABLED:Boolean = false;
       
      
      private var _rounds:Vector.<BenchmarkInfoRound>;
      
      private var _currentRound:BenchmarkInfoRound = null;
      
      private var _allBloons:Vector.<Bloon> = null;
      
      private var _allTowers:Vector.<Tower> = null;
      
      private var _allProjectiles:Vector.<Projectile> = null;
      
      public function BenchmarkTracking()
      {
         this._rounds = new Vector.<BenchmarkInfoRound>();
         super();
      }
      
      public function onNewGame() : void
      {
         if(false == ENABLED)
         {
            return;
         }
         this._allBloons = Main.instance.game.level.bloons;
         this._allTowers = Main.instance.game.level.allTowers;
         this._allProjectiles = Main.instance.game.level.allProjectiles;
         Main.instance.game.addEventListener(LevelEvent.ROUND_START,this.onRoundStarted);
         Main.instance.game.addEventListener(LevelEvent.ROUND_OVER,this.onRoundEnded);
         Main.instance.game.level.addEventListener("TOWER_ADDED",this.onTowerPlaced);
         Bloon.eventDispatcher.addEventListener(BloonEvent.POP,this.onBloonsChanged);
         Main.instance.game.level.addEventListener(BloonEvent.ADD,this.onBloonsChanged);
         this._rounds.length = 0;
         var _loc1_:BenchmarkInfoRound = new BenchmarkInfoRound();
         this._rounds.push(_loc1_);
         this._currentRound = _loc1_;
      }
      
      public function onRoundStarted(... rest) : void
      {
         if(false == ENABLED)
         {
            return;
         }
         var _loc2_:BenchmarkInfoRound = new BenchmarkInfoRound();
         _loc2_.bestNumberOfTowers = this.getNumOfPlaceableTowers();
         this._rounds.push(_loc2_);
         this._currentRound = _loc2_;
      }
      
      public function onRoundEnded(... rest) : void
      {
         if(false == ENABLED)
         {
            return;
         }
         this.report();
      }
      
      public function report() : void
      {
         var _loc5_:BenchmarkInfoRound = null;
         if(false == ENABLED)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._rounds.length)
         {
            _loc5_ = this._rounds[_loc4_];
            if(_loc1_ < _loc5_.bestNumberOfBloons)
            {
               _loc1_ = _loc5_.bestNumberOfBloons;
            }
            if(_loc2_ < _loc5_.bestNumberOfTowers)
            {
               _loc2_ = _loc5_.bestNumberOfTowers;
            }
            if(_loc3_ < _loc5_.bestNumberOfProjectiles)
            {
               _loc3_ = _loc5_.bestNumberOfProjectiles;
            }
            _loc4_++;
         }
      }
      
      public function onBloonsChanged(... rest) : void
      {
         if(false == ENABLED)
         {
            return;
         }
         if(this._currentRound.bestNumberOfBloons < this._allBloons.length)
         {
            this._currentRound.bestNumberOfBloons = this._allBloons.length;
         }
      }
      
      public function onTowerPlaced(... rest) : void
      {
         if(false == ENABLED)
         {
            return;
         }
         var _loc2_:int = this.getNumOfPlaceableTowers();
         if(this._currentRound.bestNumberOfTowers < _loc2_)
         {
            this._currentRound.bestNumberOfTowers = _loc2_;
         }
      }
      
      public function onProjectileAdded() : void
      {
         if(false == ENABLED)
         {
            return;
         }
         if(this._currentRound.bestNumberOfProjectiles < this._allProjectiles.length)
         {
            this._currentRound.bestNumberOfProjectiles = this._allProjectiles.length;
         }
      }
      
      public function set allBloons(param1:Vector.<Bloon>) : void
      {
         this._allBloons = param1;
      }
      
      private function getNumOfPlaceableTowers() : int
      {
         var _loc3_:Tower = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._allTowers.length)
         {
            _loc3_ = this._allTowers[_loc2_];
            if(_loc3_.def != null && _loc3_.rootID != TowerFactory.TOWER_ROADSPIKE && _loc3_.rootID != TowerFactory.TOWER_PINEAPPLE && _loc3_.rootID != Constants.TOWER_REDHOTSPIKES && _loc3_.rootID != Constants.TOWER_CUDDLY_BEAR && _loc3_.rootID != Constants.TOWER_ANTI_CAMO_DUST)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
