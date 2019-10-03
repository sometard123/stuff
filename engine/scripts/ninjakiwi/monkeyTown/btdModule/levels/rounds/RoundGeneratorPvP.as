package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.btdModule.analytics.GameInfoTracking;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SwapForProjectile;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Standard;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import org.osflash.signals.Signal;
   
   public class RoundGeneratorPvP extends RoundGenerator
   {
      
      public static const roundStartSignal:Signal = new Signal(int);
      
      public static const MVM_DIFFICULTY_MODIFIER:Number = 1.35;
       
      
      public function RoundGeneratorPvP(param1:Level)
      {
         var _loc3_:ProjectileDef = null;
         super(param1);
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY));
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY_BALL));
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY_MINES));
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY_STORM));
         this.disableRoundOverBehavior(Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_SPIKEFACTORY_MOAB));
         var _loc2_:TowerDef = Main.instance.towerFactory.getBaseTower(TowerFactory.TOWER_ROADSPIKE);
         if(_loc2_.behavior != null)
         {
            if(_loc2_.behavior.roundStart != null)
            {
               if(_loc2_.behavior.roundStart is SwapForProjectile)
               {
                  if((_loc2_.behavior.roundStart as SwapForProjectile).projectile != null)
                  {
                     _loc3_ = (_loc2_.behavior.roundStart as SwapForProjectile).projectile;
                     if(_loc3_.behavior != null)
                     {
                        _loc3_.behavior.roundOver = null;
                     }
                  }
               }
            }
         }
         param1.sigBloonRemoved.addWithPriority(this.checkForRoundOver,1000);
      }
      
      override public function clear() : void
      {
         super.clear();
         _level.sigBloonRemoved.remove(this.checkForRoundOver);
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
            RoundGeneratorPvP.roundStartSignal.dispatch(_currentRoundIndex.value);
            _loc3_ = 50;
            _level.addCash(_loc3_);
            Main.instance.game.gameInfoTracking.cashEarned(_loc3_,GameInfoTracking.CASH_TYPE_END_OF_ROUND);
            Main.instance.game.waveIndex = _currentRoundIndex.value;
            Main.instance.game.roundTime = 0;
            Main.instance.game.recalculateCashPerPop();
            Main.instance.game.dispatchEvent(new LevelEvent(LevelEvent.ROUND_START));
         }
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
      
      override public function generate(param1:BTDGameRequest) : void
      {
         var _loc2_:BloonSpawnType = null;
         var _loc3_:Vector.<Round> = null;
         var _loc4_:Round = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         super.generate(param1);
         if(param1.moreLead == Constants.LOTS)
         {
            _loc3_ = Main.instance.game.level.roundGenerator.rounds;
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               if(_loc6_ >= RoundGeneratorData.ROUND_REQUIRED_BEFORE_CAMO)
               {
                  _loc4_ = _loc3_[_loc6_];
                  _loc5_ = _loc4_.queuedBloons.length * 0.1;
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_)
                  {
                     _loc2_ = new BloonSpawnType(Constants.LEAD_ID);
                     _loc2_.Spacing(Constants.SPACING_NORMAL);
                     _loc4_.queueBloon(_loc2_);
                     _loc7_++;
                  }
               }
               _loc6_++;
            }
         }
         if(param1.moreMoabs == Constants.LOTS)
         {
            _loc3_ = Main.instance.game.level.roundGenerator.rounds;
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               _loc4_ = _loc3_[_loc6_];
               _loc5_ = _loc4_.queuedBloons.length * 0.01;
               _loc8_ = -1;
               _loc7_ = 0;
               while(_loc7_ < _loc4_.queuedBloons.length)
               {
                  _loc2_ = _loc4_.queuedBloons[_loc7_].spawnType;
                  if(Bloon.isMOABClass(_loc2_.type))
                  {
                     if(_loc8_ == -1)
                     {
                        _loc8_ = _loc2_.type;
                     }
                     else if(_loc8_ < _loc2_.type)
                     {
                        _loc8_ = _loc2_.type;
                     }
                  }
                  _loc7_++;
               }
               if(_loc8_ != -1 || _loc8_ >= Bloon.MOAB)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_)
                  {
                     _loc2_ = new BloonSpawnType(_loc8_);
                     _loc2_.Spacing(Constants.SPACING_NORMAL);
                     _loc4_.queueBloon(_loc2_);
                     _loc7_++;
                  }
               }
               _loc6_++;
            }
         }
      }
      
      override public function process(param1:Number) : void
      {
         _rounds[_currentRoundIndex.value].update(param1);
      }
      
      override protected function generateRBEPerRound(param1:int, param2:int, param3:Object = null) : Array
      {
         var _loc4_:Array = super.generateRBEPerRound(param1,param2,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc4_[_loc5_] = _loc4_[_loc5_] * MVM_DIFFICULTY_MODIFIER;
            _loc5_++;
         }
         return _loc4_;
      }
   }
}
