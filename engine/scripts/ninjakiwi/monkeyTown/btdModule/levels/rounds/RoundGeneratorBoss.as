package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.analytics.GameInfoTracking;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SwapForProjectile;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Standard;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleAttackDefinition;
   
   public class RoundGeneratorBoss extends RoundGenerator
   {
       
      
      private var _bossAttack:BossBattleAttackDefinition;
      
      private var _hasBossBeenDestroyed:Boolean = false;
      
      public function RoundGeneratorBoss(param1:Level, param2:BossBattleAttackDefinition)
      {
         var _loc4_:ProjectileDef = null;
         super(param1);
         this._bossAttack = param2;
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY));
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY_BALL));
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY_MINES));
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY_STORM));
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY_MOAB));
         var _loc3_:TowerDef = Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_ROADSPIKE);
         if(_loc3_.behavior != null)
         {
            if(_loc3_.behavior.roundStart != null)
            {
               if(_loc3_.behavior.roundStart is SwapForProjectile)
               {
                  if((_loc3_.behavior.roundStart as SwapForProjectile).projectile != null)
                  {
                     _loc4_ = (_loc3_.behavior.roundStart as SwapForProjectile).projectile;
                     if(_loc4_.behavior != null)
                     {
                        _loc4_.behavior.roundOver = null;
                     }
                  }
               }
            }
         }
         param1.sigBloonRemoved.addWithPriority(this.checkForRoundOver,1000);
         SpecialTrackBoss.onBossSpawnedSignal.remove(this.onBossSpawned);
         SpecialTrackBoss.onBossSpawnedSignal.add(this.onBossSpawned);
         Bloon.eventDispatcher.removeEventListener(BloonEvent.BOSS_DESTROYED,this.onBossDespawned);
         Bloon.eventDispatcher.addEventListener(BloonEvent.BOSS_DESTROYED,this.onBossDespawned);
      }
      
      override public function generate(param1:BTDGameRequest) : void
      {
         super.generate(param1);
         _rounds.splice(0,this._bossAttack.bossLevel - 1);
         _totalRounds.value = _rounds.length;
         this._hasBossBeenDestroyed = false;
      }
      
      private function disableRoundOverBehavior(param1:TowerDef) : void
      {
         var i:int = 0;
         var tower:TowerDef = param1;
         if(tower != null)
         {
            if(tower.weapons != null)
            {
               i = 0;
               while(i < tower.weapons.length)
               {
                  try
                  {
                     Standard(tower.weapons[i]).projectile.behavior.roundOver = null;
                  }
                  catch(e:Error)
                  {
                  }
                  i++;
               }
            }
         }
      }
      
      override public function process(param1:Number) : void
      {
         if(false == this._hasBossBeenDestroyed)
         {
            _rounds[_currentRoundIndex.value].update(param1);
         }
      }
      
      private function checkForRoundOver(param1:Bloon) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Round = _rounds[_currentRoundIndex.value];
         if(!_loc2_.hasCuedBloons() && _currentRoundIndex.value < _rounds.length - 1)
         {
            Main.instance.game.dispatchEvent(new LevelEvent(LevelEvent.ROUND_OVER));
            _currentRoundIndex.value = _currentRoundIndex.value + 1;
            _loc2_ = _rounds[_currentRoundIndex.value];
            RoundGenerator.roundStartSignal.dispatch(_currentRoundIndex.value);
            _loc3_ = 50;
            _level.addCash(_loc3_);
            Main.instance.game.gameInfoTracking.cashEarned(_loc3_,GameInfoTracking.CASH_TYPE_END_OF_ROUND);
            Main.instance.game.waveIndex = _currentRoundIndex.value;
            Main.instance.game.roundTime = 0;
            Main.instance.game.recalculateCashPerPop();
            Main.instance.game.dispatchEvent(new LevelEvent(LevelEvent.ROUND_START));
         }
      }
      
      private function onBossSpawned(... rest) : void
      {
      }
      
      private function onBossDespawned(... rest) : void
      {
         this._hasBossBeenDestroyed = true;
      }
   }
}
