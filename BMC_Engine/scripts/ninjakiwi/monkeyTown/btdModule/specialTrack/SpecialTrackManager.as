package ninjakiwi.monkeyTown.btdModule.specialTrack
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.levelDefs.SpecialTrackEmptyEndless;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrack;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.blastopopoulos.SpecialTrackBlastopopoulos;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.bloonarius.SpecialTrackBloonarius;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dreadbloon.SpecialTrackDreadbloon;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dryAsABone.SpecialTrackDryAsABone;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.glacier.SpecialTrackGlacier;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.moabGraveyard.SpecialTrackMOABGraveyard;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.performanceTesting.SpecialTrackTesting;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.phaseCrystal.SpecialTrackPhaseCrystal;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.sandStorm.SpecialTrackSandStorm;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.shipWreck.SpecialTrackShipWreck;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.stickySapPlant.SpecialTrackStickySapPlant;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.templeRuins.SpecialTrackTempleRuin;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.tranquilGlade.SpecialTrackTranquilGlade;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.vortex.SpecialTrackVortex;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.wattleTrees.SpecialTrackWattleTrees;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.zzzzomg.SpecialTrackZZZZOMG;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BossBattleResultDefinition;
   
   public class SpecialTrackManager
   {
      
      private static var _instance:SpecialTrackManager = null;
       
      
      private var _specialTrack:SpecialTrack;
      
      public function SpecialTrackManager()
      {
         super();
      }
      
      public static function getInstance() : SpecialTrackManager
      {
         if(_instance == null)
         {
            _instance = new SpecialTrackManager();
         }
         return _instance;
      }
      
      public function setSpecialTrack(param1:BTDGameRequest, param2:String) : Boolean
      {
         this._specialTrack = null;
         switch(param2)
         {
            case Constants.WATTLE_TREES:
               this._specialTrack = new SpecialTrackWattleTrees();
               break;
            case Constants.SHIPWRECK:
               this._specialTrack = new SpecialTrackShipWreck();
               break;
            case Constants.STICKY_SAP_PLANT:
               this._specialTrack = new SpecialTrackStickySapPlant();
               break;
            case Constants.GLACIER:
               this._specialTrack = new SpecialTrackGlacier();
               break;
            case Constants.TRANQUIL_GLADE:
               this._specialTrack = new SpecialTrackTranquilGlade();
               break;
            case Constants.PHASE_CRYSTAL:
               this._specialTrack = new SpecialTrackPhaseCrystal();
               break;
            case Constants.CONSECRATED_GROUND:
               this._specialTrack = new SpecialTrackTempleRuin();
               break;
            case Constants.MOAB_GRAVEYARD:
               this._specialTrack = new SpecialTrackMOABGraveyard();
               break;
            case Constants.SANDSTORM:
               this._specialTrack = new SpecialTrackSandStorm();
               break;
            case Constants.ZZZZOMG:
               this._specialTrack = new SpecialTrackZZZZOMG();
               break;
            case Constants.DRY_AS_A_BONE:
               this._specialTrack = new SpecialTrackDryAsABone();
               break;
            case Constants.TEST_PERFORMANCE:
               this._specialTrack = new SpecialTrackTesting();
               break;
            case Constants.BOSS_VORTEX:
               this._specialTrack = new SpecialTrackVortex(param1.bossAttack);
               break;
            case Constants.BOSS_BLOONARIUS:
               this._specialTrack = new SpecialTrackBloonarius(param1.bossAttack);
               break;
            case Constants.BOSS_BLASTAPOPOULOS:
               this._specialTrack = new SpecialTrackBlastopopoulos(param1.bossAttack);
               break;
            case Constants.BOSS_DREADBLOON:
               this._specialTrack = new SpecialTrackDreadbloon(param1.bossAttack);
               break;
            case Constants.EMPTY_ENDLESS:
               this._specialTrack = new SpecialTrackEmptyEndless();
         }
         if(this._specialTrack != null)
         {
            this._specialTrack.setSpecialTrack(param1);
            return true;
         }
         return false;
      }
      
      public function activateSpecialTrack(param1:BTDGameRequest) : void
      {
         if(this._specialTrack != null)
         {
            this._specialTrack.applySpecialTrack(param1);
         }
      }
      
      public function clearSpecialTrack() : void
      {
         if(this._specialTrack != null)
         {
            this._specialTrack.clearSpecialTrack();
            this._specialTrack = null;
         }
      }
      
      public function update(param1:Number) : void
      {
         if(this._specialTrack != null)
         {
            this._specialTrack.update(param1);
         }
      }
      
      public function getBoss() : Bloon
      {
         var _loc1_:SpecialTrackBoss = this._specialTrack as SpecialTrackBoss;
         if(false === _loc1_ is SpecialTrackBoss)
         {
            return null;
         }
         var _loc2_:SpecialTrackBoss = _loc1_ as SpecialTrackBoss;
         return _loc2_.bossBloon;
      }
      
      public function getBossBattleResult() : BossBattleResultDefinition
      {
         if(this._specialTrack is SpecialTrackBoss)
         {
            return (this._specialTrack as SpecialTrackBoss).getBossBattleResult();
         }
         return null;
      }
      
      public function get specialTrack() : SpecialTrack
      {
         return this._specialTrack;
      }
   }
}
