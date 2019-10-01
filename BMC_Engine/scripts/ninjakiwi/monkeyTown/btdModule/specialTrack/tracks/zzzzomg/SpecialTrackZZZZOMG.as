package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.zzzzomg
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnType;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorZZZZomg;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dryAsABone.RainCloud;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackZZZZOMG extends SpecialTrack
   {
      
      private static var _updateTimer:Timer = new Timer(500,0);
      
      public static const TICK_FREQUENCY_SEC:Number = 10;
      
      private static const CASH_AWARD:Number = 500;
      
      private static var _game:Game;
      
      private static var _level:Level;
      
      private static var _timeOfLastCashAward:Number = 0;
       
      
      public function SpecialTrackZZZZOMG()
      {
         super();
      }
      
      private static function onTimer(param1:TimerEvent = null) : void
      {
         var _loc2_:Number = _game.getGameTime();
         if(_loc2_ - _timeOfLastCashAward > TICK_FREQUENCY_SEC)
         {
            addCash();
         }
      }
      
      private static function addCash() : void
      {
         var _loc1_:Tower = null;
         var _loc2_:BananaEmitter = null;
         if(!Main.instance.game.level.roundInProgress)
         {
            return;
         }
         _timeOfLastCashAward = _game.getGameTime();
         _level.addCash(CASH_AWARD);
         _game.roundTime = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _level.allTowers.length)
         {
            _loc1_ = _level.allTowers[_loc3_];
            if(_loc1_.rootID === "BananaFarm")
            {
               _loc2_ = _loc1_.def.behavior.roundStart as BananaEmitter;
               _loc2_.execute(_loc1_);
            }
            _loc3_++;
         }
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         var _loc1_:Game = Main.instance.game;
         _loc1_.removeEventListener(LevelEvent.ROUND_START,this.onRoundStart);
         _updateTimer.removeEventListener(TimerEvent.TIMER,onTimer);
         _updateTimer.reset();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.TerrainType(Constants.TERRAIN_ZZZZOMG);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
      }
      
      private function patchAvailableTowers(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            if(_loc2_ == Constants.TOWER_PLANE)
            {
               param1[_loc2_].allowed = false;
            }
         }
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc5_:BloonSpawnType = null;
         super.applySpecialTrack(param1);
         _timeOfLastCashAward = 0;
         _game = Main.instance.game;
         _level = Main.instance.game.level;
         _level.roundGenerator = new RoundGeneratorZZZZomg(_level);
         var _loc2_:Vector.<Round> = new Vector.<Round>();
         var _loc3_:Round = new Round(_level);
         var _loc4_:int = 0;
         _loc3_ = new Round(_level);
         _loc5_ = new BloonSpawnType(Constants.BOSS_ID);
         _loc5_.Spacing(Constants.SPACING_NORMAL);
         _loc3_.queueBloon(_loc5_);
         _loc2_.push(_loc3_);
         Main.instance.game.level.roundGenerator.setCustomRounds(_loc2_);
         _game.addEventListener(LevelEvent.ROUND_START,this.onRoundStart);
         param1.allowRetry = false;
         addCash();
         this.patchAvailableTowers(param1.availableTowers);
      }
      
      private function onRoundStart(param1:LevelEvent) : void
      {
         _updateTimer.reset();
         _updateTimer.addEventListener(TimerEvent.TIMER,onTimer);
         _updateTimer.start();
         _timeOfLastCashAward = _game.getGameTime();
      }
   }
}
