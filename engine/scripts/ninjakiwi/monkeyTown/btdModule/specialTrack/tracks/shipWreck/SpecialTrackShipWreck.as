package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.shipWreck
{
   import assets.PlayUI.Whirlpool;
   import assets.ability.ActivatedAbilityWhirpool;
   import assets.module.CoolDownTimerClip;
   import assets.occupiedSpace.Small;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.abilities.ActivateWhirpool;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.ActivateWhirpoolDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.ingame.DirectUseAbilityButton;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.levels.rounds.RoundGenerator;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.WhirpoolStore;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.ResetWhirpool;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.SinkBloon;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   
   public class SpecialTrackShipWreck extends SpecialTrack
   {
       
      
      public function SpecialTrackShipWreck()
      {
         super();
      }
      
      override public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc2_:TowerPickerDef = null;
         var _loc3_:UpgradePathDef = null;
         var _loc4_:UpgradeDef = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         super.setSpecialTrack(param1);
         param1.BloonWeights(new BloonWeightsDefinition().StrongestBloonID(Constants.MOAB_ID).StrongestBloonType(Constants.MOAB_BLOON));
         param1.TerrainType(Constants.SHIPWRECK);
         param1.TileUniqueData(new TileUniqueDataDefinition().TrackID(0));
         RoundGenerator.rbeModifier = 1.5;
         for(_loc5_ in param1.availableTowers)
         {
            _loc2_ = Main.instance.towerMenuSet.getPickerByTowerID(_loc5_);
            if(_loc5_ != TowerFactory.TOWER_BUCCANEER)
            {
               if(_loc2_ != null)
               {
                  _loc2_.Cost(_loc2_.cost * 2);
               }
               _loc3_ = Main.instance.towerFactory.getUpgrades(_loc5_);
               if(_loc3_ != null && _loc3_.upgrades != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc3_.upgrades.length)
                  {
                     _loc7_ = 0;
                     while(_loc7_ < _loc3_.upgrades[_loc6_].length)
                     {
                        _loc4_ = _loc3_.upgrades[_loc6_][_loc7_];
                        _loc4_.cost = _loc4_.cost * 2;
                        _loc7_++;
                     }
                     _loc6_++;
                  }
                  continue;
               }
               continue;
            }
         }
      }
      
      override public function clearSpecialTrack() : void
      {
         super.clearSpecialTrack();
         RoundGenerator.rbeModifier = 1;
      }
      
      override public function applySpecialTrack(param1:BTDGameRequest) : void
      {
         super.applySpecialTrack(param1);
         this.addWhirpool(80,90,250);
         this.addWhirpool(64,335,420);
         this.addWhirpool(78,613,370);
         this.addWhirpool(69,515,102);
      }
      
      private function addWhirpool(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:SinkBloon = new SinkBloon().Range(600).Power(1050).ReloadTime(0.29).Rotate(true);
         var _loc5_:AbilityDef = new ActivateWhirpoolDef("Activate Whirpool").Cooldown(55).Sound(null).Thumb(ActivatedAbilityWhirpool).Label("Activate Whirpool Ability").Description("Pops nearby bloons in its swirling vortex, including leads and camo.").AbilityClass(ActivateWhirpool);
         var _loc6_:TowerDef = new TowerDef("Whirpool").Label("Whirpool").Description("Pops nearby bloons in its swirling vortex, including leads and camo.").Display(MovieClip).Detail(null).DetailSmall(Whirlpool).OccupiedSpace(Small).CanPriorityTarget(false).RangeOfVisibility(param1).TargetMask(Vector.<int>([Bloon.IMMUNITY_MOAB,Bloon.IMMUNITY_BFB,Bloon.IMMUNITY_ZOMG])).Weapons(Vector.<Weapon>([_loc4_])).Behavior(new BehaviorDef().Process(new WhirpoolStore().ChipTime(0.5)).RoundOver(new ResetWhirpool().IsCalledOnReInit(false))).Abilities(Vector.<AbilityDef>([_loc5_]));
         var _loc7_:Tower = Main.instance.game.level.createTower(_loc6_.id,_loc6_,param2,param3,0);
         _loc7_.pause = true;
         _loc7_.resellable = false;
         _loc7_.coolDownTimerGuage = new CoolDownTimerClip();
         _loc7_.directUseAbilityButton = new DirectUseAbilityButton(_loc7_,_loc5_);
         _loc7_.hasPopCount = false;
         TowerPlace.towerPlacedSignal.dispatch(_loc7_);
      }
   }
}
