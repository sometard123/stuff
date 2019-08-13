package ninjakiwi.monkeyTown.town.ui.attack
{
   import assets.ui.SpecialTerrainAttackPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsData;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.specialMissions.definition.SpecialMissionDefinition;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.TerrainDetail;
   import ninjakiwi.monkeyTown.town.ui.terrain.AddStartCashModule;
   
   public class AttackSpecialMissionPanel extends AttackPanelBase
   {
       
      
      private const _clip:SpecialTerrainAttackPanelClip = new SpecialTerrainAttackPanelClip();
      
      private const _details:TerrainDetail = new TerrainDetail(this._clip.detailClip,TerrainDetail.TERRAIN_INFO | TerrainDetail.STARTING_CASH);
      
      public function AttackSpecialMissionPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,this._clip.bonusCashClip,null,this._clip.earnRewardClip,this._clip.cancelButton,this._clip.attackButton);
         this._clip.x = 35;
         this._clip.y = 20;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         setAutoPlayStopClipsArray([this._clip.specialRules.dude,this._clip.bonusCashClip.gem]);
      }
      
      override public function setMessage(param1:TownMap, param2:TileAttackDefinition) : void
      {
         super.setMessage(param1,param2);
         var _loc3_:Tile = param1.tileAtPoint(param2.attackAtLocation);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:SpecialMissionDefinition = SpecialMissionsManager.getInstance().findSpecialMission(_loc3_);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:int = ResourceStore.getInstance().btdStartingMoney;
         var _loc6_:int = ResourceStore.getInstance().btdBonusStartingMoney;
         this._clip.specialRules.descriptionTxt.text = _loc4_.description;
         if(_loc4_.id == SpecialMissionsData.WATTLE_TREES.id)
         {
            this._clip.specialRules.icons.gotoAndStop(1);
         }
         else if(_loc4_.id == SpecialMissionsData.TRANQUIL_GLADE.id)
         {
            _loc5_ = _loc5_ + 500;
            this._clip.specialRules.icons.gotoAndStop(2);
         }
         else if(_loc4_.id == SpecialMissionsData.GLACIER.id)
         {
            this._clip.specialRules.icons.gotoAndStop(3);
         }
         else if(_loc4_.id == SpecialMissionsData.SHIPWRECK.id)
         {
            this._clip.specialRules.icons.gotoAndStop(4);
         }
         else if(_loc4_.id == SpecialMissionsData.STICKY_SAP_PLANT.id)
         {
            this._clip.specialRules.icons.gotoAndStop(5);
         }
         else if(_loc4_.id == SpecialMissionsData.PHASE_CRYSTAL.id)
         {
            this._clip.specialRules.icons.gotoAndStop(6);
         }
         else if(_loc4_.id == SpecialMissionsData.CONSECRATED_GROUND.id)
         {
            _loc5_ = 30000;
            _loc6_ = 0;
            this._clip.specialRules.icons.gotoAndStop(7);
         }
         else if(_loc4_.id == SpecialMissionsData.MOAB_GRAVEYARD.id)
         {
            _loc5_ = 30000;
            _loc6_ = 0;
            this._clip.specialRules.icons.gotoAndStop(8);
         }
         else if(_loc4_.id == SpecialMissionsData.SANDSTORM.id)
         {
            this._clip.specialRules.icons.gotoAndStop(9);
         }
         else if(_loc4_.id == SpecialMissionsData.DRY_AS_A_BONE.id)
         {
            this._clip.specialRules.icons.gotoAndStop(10);
         }
         else if(_loc4_.id == SpecialMissionsData.ZZZZOMG.id)
         {
            this._clip.specialRules.icons.gotoAndStop(11);
         }
         this._details.setDetails(_loc3_);
         this._details.setStartingCash(_loc5_,_loc6_);
         AddStartCashModule.enableTickBox = false;
         _startCashOption.reset();
         AddStartCashModule.enableTickBox = true;
         param2.bonusStartingCash = _startCashOption.calculatePossibleBonusCash();
      }
   }
}
