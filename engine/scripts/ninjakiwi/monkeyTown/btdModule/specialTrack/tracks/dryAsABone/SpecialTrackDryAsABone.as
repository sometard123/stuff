package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dryAsABone
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGeneratorDryAsABone;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackDryAsABone extends SpecialTrack
   {
      
      private static var _game:Game;
      
      private static var _level:Level;
      
      private static var _rainClouds:Vector.<RainCloud> = new Vector.<RainCloud>();
      
      private static const FIXED_DIFFICULTY:int = 25;
       
      
      public function SpecialTrackDryAsABone()
      {
         super();
         _game = Main.instance.game;
         _level = Main.instance.game.level;
      }
      
      public static function abilityActivated() : void
      {
         var _loc1_:Tower = null;
         var _loc3_:RainCloud = null;
         var _loc4_:BananaEmitter = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _level.allTowers.length)
         {
            _loc1_ = _level.allTowers[_loc5_];
            if(_loc1_.rootID === "BananaFarm")
            {
               _loc4_ = _loc1_.def.behavior.roundStart as BananaEmitter;
               _loc4_.spewExtraRoundWorthOfBalloons(_loc1_);
               _loc3_ = getRaincloud(_loc2_++);
               if(_loc3_.scene !== _level)
               {
                  _level.addEntity(_loc3_);
               }
               _loc3_.x = _loc1_.x;
               _loc3_.y = _loc1_.y;
               _loc3_.clip.gotoAndPlay(1);
            }
            _loc5_++;
         }
      }
      
      private static function getRaincloud(param1:int) : RainCloud
      {
         if(_rainClouds.length <= param1)
         {
            _rainClouds[param1] = new RainCloud();
         }
         return _rainClouds[param1];
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         Bloon.cashChanceModifier = 1;
         _rainClouds.length = 0;
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         super.setSpecialTrack(param1);
         param1.TerrainType(Constants.TERRAIN_DRY_AS_A_BONE);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         super.applySpecialTrack(param1);
         this.addFarm(115,380);
         this.addFarm(195,380);
         param1.difficulty = FIXED_DIFFICULTY;
         Bloon.cashChanceModifier = 0;
         RainCloudActivatedAbility.add();
         _level.roundGenerator = new RoundGeneratorDryAsABone(_level);
         _level.roundGenerator.generate(param1);
         param1.bloonWeights.strongestBloonID = Bloon.DDT;
         param1.bloonWeights.strongestBloonType = Constants.DDT_BLOON;
      }
      
      private function addFarm(param1:int, param2:int) : void
      {
         var _loc3_:TowerDef = Main.instance.towerFactory.getBaseTower(Constants.TOWER_FARM);
         var _loc4_:UpgradePathDef = Main.instance.towerFactory.getUpgrades(Constants.TOWER_FARM);
         var _loc5_:Vector.<UpgradeDef> = _loc4_.upgrades[0].slice(0,2).concat(_loc4_.upgrades[1].slice(0,2));
         var _loc6_:Tower = Main.instance.game.level.createTower(Constants.TOWER_FARM,_loc3_,param1,param2,0);
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_.addUpgrade(_loc5_[_loc7_]);
            _loc7_++;
         }
         _loc6_.upgradePaths[0] = 2;
         _loc6_.upgradePaths[1] = 2;
         TowerPlace.towerPlacedSignal.dispatch(_loc6_);
      }
   }
}
