package ninjakiwi.monkeyTown.town.ui.attack
{
   import assets.ui.BloonBeaconAttackPanelClip;
   import assets.ui.BloonTypeIconClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesTickBoxes;
   import ninjakiwi.monkeyTown.town.ui.bloon.BloonTypeIcon;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.town.ui.terrain.AddStartCashModule;
   import ninjakiwi.monkeyTown.town.ui.terrain.TerrainRestrictionModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import org.osflash.signals.Signal;
   
   public class AttackPanelBloonBeacon extends HideRevealViewPopup
   {
       
      
      private var _clip:BloonBeaconAttackPanelClip;
      
      private var _terrainIcon:MovieClip;
      
      private var _terrainInfoText:TextField;
      
      private var _startingCashText:TextField;
      
      private var _bloonTypeClip:BloonTypeIconClip;
      
      private var _difficultyPipsGroup:MovieClip;
      
      private var _trackThumb:MyTrackThumbNailClip;
      
      private const _restrictions:TerrainRestrictionModule = new TerrainRestrictionModule(this._clip.restrictions);
      
      private var _startCashOption:AddStartCashModule;
      
      private const _crateTickboxes:CratesTickBoxes = new CratesTickBoxes(this._clip.crateTickBoxes);
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _attackButton:ButtonControllerBase;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private var _trackData:TrackData;
      
      public const attackSelectionSignal:Signal = new Signal(Boolean);
      
      private var _assaultClips:Array;
      
      public function AttackPanelBloonBeacon(param1:DisplayObjectContainer)
      {
         this._clip = new BloonBeaconAttackPanelClip();
         this._terrainIcon = this._clip.info.terrainInfoGroup.terrainIcon;
         this._terrainInfoText = this._clip.info.terrainInfoGroup.terrainInfoTxt;
         this._startingCashText = this._clip.info.startingCashGroup.startingCash;
         this._bloonTypeClip = this._clip.info.highestBloonGroup.bloonType;
         this._difficultyPipsGroup = this._clip.info.difficultyPipsGroup;
         this._assaultClips = [];
         super(param1);
         this.isModal = true;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._cancelButton = new ButtonControllerBase(this._clip.cancelButton);
         this._cancelButton.setClickFunction(this.onCancel);
         this._attackButton = new ButtonControllerBase(this._clip.attackButton);
         this._attackButton.setClickFunction(this.onAttack);
         this._startCashOption = new AddStartCashModule(this._clip.bonusCashClip);
         this._startCashOption.enableWarningPanel(param1);
         this._startCashOption.changedSignal.add(this.onBonusCashOptionChanged);
         this._assaultClips = [this._clip.info.option1,this._clip.info.option2];
      }
      
      public function syncToAttack(param1:TileAttackDefinition) : void
      {
         var _loc6_:Object = null;
         var _loc2_:IntPoint2D = param1.attackAtLocation;
         var _loc3_:Tile = MonkeySystem.getInstance().map.tileAt(_loc2_.x,_loc2_.y);
         var _loc4_:int = MonkeySystem.getInstance().city.cityIndex;
         var _loc5_:Array = LevelDefData.getLevelDefNamesByTerrain(_loc3_.type,_loc4_);
         if(_loc5_ !== null)
         {
            _loc6_ = LevelDefData.selectRandomTrackByDifficultyBias(_loc5_,_loc3_.trackSelectionBias);
         }
         var _loc7_:int = MonkeySystem.getInstance().map.getDifficultyAtTile(_loc3_);
         var _loc8_:String = BloonPredictor.getWeightsDefinition(_loc7_,true,_loc3_.variantHint).strongestBloonType;
         BloonTypeIcon.setBloonTypeOfTarget(this._bloonTypeClip,_loc8_);
         var _loc9_:int = _system.map.getRank(_loc3_);
         this.setDifficultyPips(_loc9_);
         this.setAssault(_loc3_,_loc7_);
         var _loc10_:TrackData = TrackManager.getInstance().findTrack(_loc6_.def);
         this.syncToTrackData(_loc10_);
      }
      
      public function syncToTrackData(param1:TrackData) : void
      {
         this._trackData = param1;
         this._startCashOption.reset();
         this.updateThumbnail();
         this._terrainIcon.gotoAndStop(AttackPanel.getTileFrame(this._trackData.terrainID));
         this._restrictions.syncTerrainRestrictionsWithType(this._trackData.terrainID);
         this._terrainInfoText.text = this._trackData.terrainName + " " + LocalisationConstants.TERRAIN;
         this.updateStartingCashField();
         this.updateCrates();
      }
      
      public function setAssault(param1:Tile, param2:int) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < this._assaultClips.length)
         {
            this._assaultClips[_loc3_].visible = false;
            _loc3_++;
         }
         var _loc4_:int = 0;
         if(param1.isCamoTile)
         {
            if(this._assaultClips.length > _loc4_)
            {
               this._assaultClips[_loc4_].visible = true;
               this._assaultClips[_loc4_].gotoAndStop(3);
               _loc4_++;
            }
         }
         else if(param2 >= Constants.DIFFICULTY_REQUIRED_BEFORE_CAMO)
         {
            if(this._assaultClips.length > _loc4_)
            {
               this._assaultClips[_loc4_].visible = true;
               this._assaultClips[_loc4_].gotoAndStop(1);
               _loc4_++;
            }
         }
         if(param1.isRegenTile)
         {
            if(this._assaultClips.length > _loc4_)
            {
               this._assaultClips[_loc4_].visible = true;
               this._assaultClips[_loc4_].gotoAndStop(4);
               _loc4_++;
            }
         }
         else if(param2 >= Constants.DIFFICULTY_REQUIRED_BEFORE_REGEN)
         {
            if(this._assaultClips.length > _loc4_)
            {
               this._assaultClips[_loc4_].visible = true;
               this._assaultClips[_loc4_].gotoAndStop(2);
               _loc4_++;
            }
         }
      }
      
      public function setDifficultyPips(param1:int) : void
      {
         this._difficultyPipsGroup.indicator.gotoAndStop(param1 + 1);
         this._difficultyPipsGroup.difficultyTxt.text = _system.map.getDifficultyDescriptionByRank(param1);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         if(Kong.isOnKong() && Constants.DISABLE_CRATES_ON_KONG)
         {
            this._clip.crateTickBoxes.visible = false;
         }
      }
      
      private function onAttack() : void
      {
         if(this._startCashOption.canAfford())
         {
            this.attackSelectionSignal.dispatch(true);
            this._startCashOption.apply();
            hide();
         }
      }
      
      private function onCancel() : void
      {
         hide();
         this.attackSelectionSignal.dispatch(false);
      }
      
      private function onBonusCashOptionChanged() : void
      {
         this.updateStartingCashField();
      }
      
      private function updateStartingCashField() : void
      {
         this._startingCashText.text = LocalisationConstants.MONEY_SYMBOL + this._resourceStore.btdStartingMoney;
         var _loc1_:int = this.getBonusStartingCash();
         if(_loc1_ > 0)
         {
            this._startingCashText.appendText(" + " + LocalisationConstants.MONEY_SYMBOL + _loc1_);
         }
      }
      
      private function updateThumbnail() : void
      {
         if(this._trackThumb != null)
         {
            if(this._clip.track_mc.contains(this._trackThumb))
            {
               this._clip.track_mc.removeChild(this._trackThumb);
            }
            MyTrackThumbNailClip.recycleThumbNail(this._trackThumb);
         }
         this._trackThumb = MyTrackThumbNailClip.getThumbNail(this._trackData,true);
         if(this._trackThumb != null)
         {
            this._trackThumb.scaleX = 0.9;
            this._trackThumb.scaleY = 0.9;
            this._clip.track_mc.addChild(this._trackThumb);
         }
      }
      
      private function updateCrates() : void
      {
         var _loc1_:CrateManager = CrateManager.getInstance();
         this._crateTickboxes.setCratesAvailable(_loc1_.cratesAvailable());
         this._crateTickboxes.setCratesTicked(0);
      }
      
      public function get bonusStartingCash() : int
      {
         if(this._startCashOption == null)
         {
            return 0;
         }
         return this._startCashOption.bonusStartingCash;
      }
      
      public function get startCashOption() : AddStartCashModule
      {
         return this._startCashOption;
      }
      
      public function getBonusStartingCash() : int
      {
         return this._resourceStore.btdBonusStartingMoney + this._startCashOption.bonusStartingCash;
      }
      
      public function get cratesTicked() : int
      {
         return this._crateTickboxes.cratesTicked;
      }
      
      public function get cratesTickedArray() : Array
      {
         return this._crateTickboxes.cratesTickedArray;
      }
   }
}
