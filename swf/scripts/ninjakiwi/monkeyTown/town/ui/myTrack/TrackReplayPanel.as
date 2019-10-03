package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import assets.ui.MyTracksSelectDifficultyPanelClip;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.TileUniqueDataDefinition;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.town.ui.TerrainDetail;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.bloon.BloonTypeIcon;
   import ninjakiwi.monkeyTown.town.ui.terrain.TerrainRestrictionModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.utils.Calculator;
   
   public class TrackReplayPanel extends HideRevealViewPopup
   {
       
      
      private var _clip:MyTracksSelectDifficultyPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _goButton:ButtonControllerBase;
      
      private var _track:TrackData;
      
      private var _bitmap:Bitmap;
      
      private var _details:TerrainDetail;
      
      private var _restriction:TerrainRestrictionModule;
      
      private var _difficultyOption:DifficultyRadioGroup;
      
      private var _assaultOption:AssaultRadioGroup;
      
      private var _zomgOption:ZomgRadioGroup;
      
      private var _strongestType:BloonTypeIcon;
      
      private var _description:BTDGameRequest;
      
      private var _viewIsActive:Boolean = false;
      
      public function TrackReplayPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._description = new BTDGameRequest();
         super(param1,param2);
      }
      
      public function setTrack(param1:TrackData) : void
      {
         this._track = param1;
      }
      
      private function initView() : void
      {
         if(this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = true;
         this._clip = new MyTracksSelectDifficultyPanelClip();
         this.isModal = true;
         this.addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._closeButton.setClickFunction(hide);
         this._goButton = new ButtonControllerBase(this._clip.go_btn);
         this._goButton.setClickFunction(this.go);
         this._bitmap = new Bitmap();
         this._bitmap.scaleX = 0.8;
         this._bitmap.scaleY = 0.8;
         this._clip.track_mc.addChild(this._bitmap);
         this._details = new TerrainDetail(this._clip.detailPosition,TerrainDetail.TERRAIN_INFO | TerrainDetail.STARTING_CASH);
         this._restriction = new TerrainRestrictionModule(this._clip.restrictions);
         this._difficultyOption = new DifficultyRadioGroup(this._clip.difficultyRadioGroup);
         this._assaultOption = new AssaultRadioGroup(this._clip.assaultRadioGroup);
         this._zomgOption = new ZomgRadioGroup(this._clip.zomgRadioGroup);
         this._difficultyOption.changed.add(this.syncAll);
         this._assaultOption.changedSignal.add(this.syncPips);
         this._strongestType = new BloonTypeIcon();
         this._strongestType.x = this._clip.bloonType.x;
         this._strongestType.y = this._clip.bloonType.y;
         this._clip.bloonType.visible = false;
         this._clip.addChild(this._strongestType);
         this._clip.bloonStoneBonusTxt.visible = false;
         this._clip.bloonstoneIcon.visible = false;
      }
      
      override public function centerOnStage() : void
      {
         if(!_flashClip)
         {
            return;
         }
         _flashClip.x = int(MonkeySystem.getInstance().flashStage.stageWidth * 0.5);
         _flashClip.y = int(MonkeySystem.getInstance().flashStage.stageHeight * 0.5) - 10;
      }
      
      private function buildView() : void
      {
         if(this._track == null)
         {
            return;
         }
         this._bitmap.bitmapData = this._track.loadThumbnail();
         this._details.setTerrainDetail(this._track.terrainName,this._track.terrainID);
         this._details.setStartingCash(ResourceStore.getInstance().btdStartingMoney);
         this._restriction.syncTerrainRestrictionsWithType(this._track.terrainID);
      }
      
      private function destroyView() : void
      {
         if(!this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = false;
         if(this._closeButton != null)
         {
            this._closeButton.destroy();
            this._closeButton = null;
         }
         if(this._goButton != null)
         {
            this._goButton.destroy();
            this._goButton = null;
         }
         if(this._details != null)
         {
            this._details.destroy();
         }
         if(this._restriction != null)
         {
            this._restriction.destroy();
         }
         if(this._difficultyOption != null)
         {
            this._difficultyOption.changed.remove(this.syncAll);
            this._difficultyOption.destroy();
         }
         if(this._assaultOption != null)
         {
            this._assaultOption.changedSignal.remove(this.syncPips);
            this._assaultOption.reset();
         }
         if(this._zomgOption != null)
         {
            this._zomgOption.destroy();
         }
         if(this._track != null)
         {
            this._track.releaseThumbnail();
         }
         if(this._clip != null && this._clip.track_mc != null && this._clip.track_mc.contains(this._bitmap))
         {
            this._clip.track_mc.removeChild(this._bitmap);
         }
         this._bitmap = null;
         if(this._clip.contains(this._strongestType))
         {
            this._clip.removeChild(this._strongestType);
         }
         this._strongestType = null;
         if(this.contains(this._clip))
         {
            this.removeChild(this._clip);
         }
         this._clip = null;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         if(this._track == null)
         {
            return;
         }
         this.initView();
         this.buildView();
         this.syncAll();
         super.reveal(param1);
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this.destroyView();
      }
      
      private function syncAll() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(this._track == null)
         {
            return;
         }
         _loc1_ = this._difficultyOption.getTickedDescriptionValue();
         _loc2_ = 3;
         _loc3_ = MonkeySystem.getInstance().map.getDifficultyByRank(_loc1_,ResourceStore.getInstance().townLevel,this._track.trackDefName);
         var _loc4_:BloonWeightsDefinition = BloonPredictor.getWeightsDefinition(_loc3_,true,_loc2_);
         if(_loc3_ >= Constants.MINIMUM_CAMO_TILE_DIFFICULTY && _loc3_ >= Constants.MINIMUM_REGEN_TILE_DIFFICULTY)
         {
            this._assaultOption.setIsAvailable(true);
         }
         else
         {
            this._assaultOption.setIsAvailable(false);
         }
         if(_loc4_.strongestBloonType == Constants.BOSS_BLOON)
         {
            this._zomgOption.enable = true;
         }
         else
         {
            this._zomgOption.enable = false;
         }
         this._clip.moneyBonusTxt.text = String(Calculator.getCashFromAttack(_loc3_)) + "+";
         this.syncPips();
         this._strongestType.setBloonType(_loc4_.strongestBloonType);
         this._description.Difficulty(_loc3_);
      }
      
      private function syncPips() : void
      {
         if(this._track == null)
         {
            return;
         }
         var _loc1_:int = this._difficultyOption.getTickedDescriptionValue();
         if(this._assaultOption.camoTickbox.ticked)
         {
            _loc1_ = _loc1_ + 1;
         }
         if(this._assaultOption.regenTickbox.ticked)
         {
            _loc1_ = _loc1_ + 1;
         }
         this._clip.difficultyPipsGroup.indicator.gotoAndStop(_loc1_ + 1);
         this._clip.difficultyPipsGroup.difficultyTxt.text = MonkeySystem.getInstance().map.getDifficultyDescriptionByRank(_loc1_);
         this._description.DifficultyRankRelativeToMTL(_loc1_).DifficultyDescription(MonkeySystem.getInstance().map.getDifficultyDescriptionByRank(_loc1_));
      }
      
      private function go() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         if(this._track == null)
         {
            return;
         }
         TrackManager.getInstance().trackPlayed(this._track);
         var _loc1_:int = 3;
         var _loc2_:int = this._zomgOption.getTickedDescriptionValue();
         if(_loc2_ == ZomgRadioGroup.MOAB_CLUSTER)
         {
            _loc1_ = 0;
         }
         else if(_loc2_ == ZomgRadioGroup.BFB_CLUSTER)
         {
            _loc1_ = 1;
         }
         else if(_loc2_ == ZomgRadioGroup.DDT)
         {
            _loc1_ = 2;
         }
         _loc3_ = this._difficultyOption.getTickedDescriptionValue();
         _loc4_ = MonkeySystem.getInstance().map.getDifficultyByRank(_loc3_,ResourceStore.getInstance().townLevel,this._track.trackDefName);
         var _loc5_:BloonWeightsDefinition = BloonPredictor.getWeightsDefinition(_loc4_,true,_loc1_);
         var _loc6_:int = MonkeySystem.getInstance().city.cityIndex;
         var _loc7_:Array = GameEventManager.getInstance().monkeyTeam.getCurrentActiveMonkeyTeam();
         this._description.ExtraRedHotSpikes(ResourceStore.getInstance().redHotSpikes).ExtraMonkeyBoosts(ResourceStore.getInstance().monkeyBoosts).CityIndex(_system.city.cityIndex).AvailableUpgrades(MonkeySystem.getInstance().city.upgradeTree.getDescriptionForBTDModule()).AvailableTowers(MonkeySystem.getInstance().city.buildingManager.getAvailableTowersDescription(this._track.terrainID)).StartingMoney(ResourceStore.getInstance().btdStartingMoney + ResourceStore.getInstance().btdBonusStartingMoney).StartingLives(ResourceStore.getInstance().btdStartingLives).TerrainType(this._track.terrainID).TerrainName(this._track.terrainName).TileUniqueData(new TileUniqueDataDefinition().TrackID(LevelDefData.getTrackIndex(this._track.terrainID,this._track.trackDefName,_loc6_))).TrackSelectionBias(1).IsReplayMode(true).IsCamoTile(this._assaultOption.camoTickbox.ticked).IsRegenTile(this._assaultOption.regenTickbox.ticked).MonkeyTeamTowers(_loc7_).BloonWeights(_loc5_);
         MonkeyCityMain.getInstance().launchReplay(this._description);
         hide();
         TownUI.getInstance().myTracksPanel.hide();
      }
   }
}
