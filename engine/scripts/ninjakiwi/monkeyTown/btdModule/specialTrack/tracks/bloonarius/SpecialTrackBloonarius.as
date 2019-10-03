package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.bloonarius
{
   import assets.BloonariusDeath;
   import assets.BloonariusEntrance;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.bloons.bossBloons.BossConstants;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.ingame.GameGoButtonController;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleAttackDefinition;
   
   public class SpecialTrackBloonarius extends SpecialTrackBoss
   {
       
      
      private var BLOONARIUS_SPAWN_DELAY:Number = 20;
      
      private var _previousBossHealth:int = 2147483647;
      
      private var _spawnTypes:Array;
      
      private const bloonTypesByKey:Object = {
         "lead":Bloon.LEAD,
         "ceramic":Bloon.CERAMIC,
         "rainbow":Bloon.RAINBOW,
         "moab":Bloon.MOAB,
         "BFB":Bloon.BFB,
         "ZOMG":Bloon.BOSS
      };
      
      public function SpecialTrackBloonarius(param1:BossBattleAttackDefinition)
      {
         this._spawnTypes = [];
         param1.bossType = Bloon.BOSS_BLOONARIUS;
         super(param1,this.BLOONARIUS_SPAWN_DELAY);
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         _enterEffectClass = BloonariusEntrance;
         _destroyedEffectClass = BloonariusDeath;
         super.setSpecialTrack(param1);
         var _loc2_:Object = Main.instance.remoteDataManager.bloonariusSpawnData;
         var _loc3_:int = param1.bossAttack.bossLevel;
         var _loc4_:int = _loc3_ - 1;
         this._spawnTypes.push(_loc2_.spawn1[_loc4_]);
         this._spawnTypes.push(_loc2_.spawn2[_loc4_]);
         this._spawnTypes.push(_loc2_.spawn3[_loc4_]);
         this._previousBossHealth = _attackDef.bossHitPoints;
      }
      
      override protected function spawnBoss(... rest) : void
      {
         var _loc2_:* = false;
         super.spawnBoss();
         _bossBloon.radius = BossConstants.BLOONARIUS_RADIUS;
         _loc2_ = Main.instance.game.inGameMenu.goButton.throttleState == GameGoButtonController.THROTTLE_STATE_FAST_FORWARD;
         var _loc3_:Number = !!_loc2_?Number(0.24167):Number(0.967);
         var _loc4_:Number = !!_loc2_?Number(16):Number(4);
      }
      
      override protected function onBloonDamage(param1:BloonEvent) : void
      {
         var _loc5_:Array = null;
         var _loc6_:String = null;
         super.onBloonDamage(param1);
         if(_bossBloon === null || param1.bloon !== _bossBloon)
         {
            return;
         }
         var _loc2_:Number = Math.max(0,_bossBloon.health);
         var _loc3_:Number = Math.ceil(_loc2_ / _bossBloon.maxHealth * 4);
         var _loc4_:Number = Math.ceil(this._previousBossHealth / _bossBloon.maxHealth * 4);
         if(_loc3_ != _loc4_ && _loc3_ !== 0)
         {
            _loc5_ = [-1,2,1,0];
            _loc6_ = this._spawnTypes[_loc5_[_loc3_]];
            spawnChild(_bossBloon,this.bloonTypesByKey[_loc6_]);
            explodeSkullRange(_loc3_ - 1,_loc4_ - 1);
         }
         this._previousBossHealth = _loc2_;
      }
   }
}
