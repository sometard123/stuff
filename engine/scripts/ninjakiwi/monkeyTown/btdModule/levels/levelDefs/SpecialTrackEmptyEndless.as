package ninjakiwi.monkeyTown.btdModule.levels.levelDefs
{
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSendTestModule;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.BloonSpawnType;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.Round;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackEmptyEndless extends SpecialTrack
   {
       
      
      public function SpecialTrackEmptyEndless()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.TerrainType(Constants.TERRAIN_FOREST);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(2));
         param1.AvailableTowers({
            "BoomerangThrower":{"count":100},
            "DartMonkey":{"count":100},
            "GlueGunner":{"count":100},
            "NinjaMonkey":{"count":100},
            "MortarTower":{"count":100},
            "TackTower":{"count":100},
            "SpikeFactory":{"count":100},
            "SniperMonkey":{"count":100},
            "BombTower":{"count":100},
            "IceTower":{"count":100},
            "MonkeyBuccaneer":{"count":100},
            "MonkeyAce":{"count":100},
            "MonkeyApprentice":{"count":100},
            "DartlingGun":{"count":100},
            "BananaFarm":{"count":100},
            "SuperMonkey":{"count":100},
            "RoadSpikes":{"count":100},
            "ExplodingPineapple":{"count":100},
            "MonkeyVillage":{"count":100},
            "Engineer":{"count":100}
         });
         param1.AvailableUpgrades({
            "BombTower":{
               "path1":4,
               "path2":4
            },
            "DartlingGun":{
               "path1":4,
               "path2":4
            },
            "BoomerangThrower":{
               "path1":4,
               "path2":4
            },
            "IceTower":{
               "path1":4,
               "path2":4
            },
            "NinjaMonkey":{
               "path1":4,
               "path2":4
            },
            "GlueGunner":{
               "path1":4,
               "path2":4
            },
            "MonkeyAce":{
               "path1":4,
               "path2":4
            },
            "SuperMonkey":{
               "path1":4,
               "path2":4
            },
            "BananaFarm":{
               "path1":4,
               "path2":4
            },
            "DartMonkey":{
               "path1":4,
               "path2":4
            },
            "SuperMonkey":{
               "path1":4,
               "path2":4
            },
            "MonkeyVillage":{
               "path1":4,
               "path2":4
            },
            "MortarTower":{
               "path1":4,
               "path2":4
            },
            "SpikeFactory":{
               "path1":4,
               "path2":4
            },
            "SniperMonkey":{
               "path1":4,
               "path2":4
            },
            "MonkeyApprentice":{
               "path1":4,
               "path2":4
            },
            "TackTower":{
               "path1":4,
               "path2":4
            },
            "MonkeyBuccaneer":{
               "path1":4,
               "path2":4
            },
            "Engineer":{
               "path1":4,
               "path2":4
            }
         });
         param1.StartingMoney(5000000);
         param1.StartingLives(9999999);
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc4_:BloonSpawnType = null;
         super.applySpecialTrack(param1);
         var _loc2_:Vector.<Round> = new Vector.<Round>();
         var _loc3_:Round = new Round(Main.instance.game.level);
         _loc4_ = new BloonSpawnType(Constants.RED_ID);
         _loc4_.Spacing(99999999);
         _loc3_.queueBloon(_loc4_);
         _loc2_.push(_loc3_);
         Main.instance.game.level.roundGenerator.setCustomRounds(_loc2_);
         BloonSendTestModule.instance.activateBloonSendTestModule();
      }
   }
}
