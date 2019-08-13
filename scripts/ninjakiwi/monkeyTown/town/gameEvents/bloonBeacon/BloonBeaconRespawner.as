package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon
{
   import com.greensock.TweenLite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.path;
   
   public class BloonBeaconRespawner
   {
      
      private static const UPDATE_INTERVAL:Number = 1000;
       
      
      private var _bloonBeaconSystem:BloonBeaconSystem = null;
      
      private var _timeOfNextSpawn:Number = 0;
      
      private var _spawnCheckTimer:Timer;
      
      public function BloonBeaconRespawner(param1:BloonBeaconSystem)
      {
         this._spawnCheckTimer = new Timer(1000);
         super();
         this._bloonBeaconSystem = param1;
         param1.onBeaconCapturedSignal.add(this.onBeaconCaptured);
         param1.onBeaconSpawned.add(this.onBeaconSpawned);
         this._spawnCheckTimer.addEventListener(TimerEvent.TIMER,this.update);
         MonkeyCityMain.globalResetSignal.add(this.onGlobalReset);
      }
      
      private function onGlobalReset() : void
      {
         this._spawnCheckTimer.reset();
         this._spawnCheckTimer.stop();
         this.reset();
      }
      
      private function onBeaconCaptured(param1:Tile, param2:Number) : void
      {
         this._timeOfNextSpawn = param2 + BloonBeaconSystem.getInstance().getModifiedRespawnTime();
         this.startUpdateTimout();
      }
      
      public function countDownToRespawn(param1:Number) : void
      {
         this._timeOfNextSpawn = param1 + BloonBeaconSystem.getInstance().getModifiedRespawnTime();
         this.startUpdateTimout();
      }
      
      private function onBeaconSpawned(param1:Tile) : void
      {
         this.reset();
      }
      
      public function reset() : void
      {
         if(null != MonkeyCityMain.getInstance().stage)
         {
            this._spawnCheckTimer.stop();
            this._spawnCheckTimer.reset();
         }
         this._timeOfNextSpawn = 0;
      }
      
      private function startUpdateTimout() : void
      {
         this._spawnCheckTimer.reset();
         this._spawnCheckTimer.start();
      }
      
      private function update(... rest) : void
      {
         if(MonkeyCityMain.isInGame)
         {
            return;
         }
         if(this.canSpawn())
         {
            this._bloonBeaconSystem.spawnNewBeacon();
            this._spawnCheckTimer.stop();
            this._spawnCheckTimer.reset();
         }
      }
      
      public function canSpawn() : Boolean
      {
         if(this._timeOfNextSpawn < MonkeySystem.getInstance().getSecureTime())
         {
            return true;
         }
         return false;
      }
   }
}
