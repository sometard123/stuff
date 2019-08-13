package ninjakiwi.monkeyTown.town.ui.attack
{
   import assets.ui.ContestedTerritoryAttackPanel;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesTickBoxes;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.town.ui.terrain.AddStartCashModule;
   import ninjakiwi.monkeyTown.town.ui.terrain.TerrainRestrictionModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import org.osflash.signals.Signal;
   
   public class AttackPanelContest extends HideRevealViewPopup
   {
       
      
      private var _attackPanelContestClip:ContestedTerritoryAttackPanel;
      
      private var _terrainIcon:MovieClip;
      
      private var _terrainInfoText:TextField;
      
      private var _trackThumb:MyTrackThumbNailClip;
      
      private const _restrictions:TerrainRestrictionModule = new TerrainRestrictionModule(this._attackPanelContestClip.restrictions);
      
      private var _startCashOption:AddStartCashModule;
      
      private const _crateTickboxes:CratesTickBoxes = new CratesTickBoxes(this._attackPanelContestClip.crateTickBoxes);
      
      private var _cancelButton:ButtonControllerBase;
      
      private var _attackButton:ButtonControllerBase;
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private var _trackData:TrackData;
      
      public const attackClickedSignal:Signal = new Signal();
      
      public const cancelClickedSignal:Signal = new Signal();
      
      public function AttackPanelContest(param1:DisplayObjectContainer)
      {
         this._attackPanelContestClip = new ContestedTerritoryAttackPanel();
         this._terrainIcon = this._attackPanelContestClip.terrainInfoGroup.terrainIcon;
         this._terrainInfoText = this._attackPanelContestClip.terrainInfoGroup.terrainInfoText;
         super(param1);
         this.isModal = true;
         addChild(this._attackPanelContestClip);
         enableDefaultOnResize(this._attackPanelContestClip);
         this._cancelButton = new ButtonControllerBase(this._attackPanelContestClip.cancelButton);
         this._cancelButton.setClickFunction(this.onCancel);
         this._attackButton = new ButtonControllerBase(this._attackPanelContestClip.attackButton);
         this._attackButton.setClickFunction(this.onAttack);
         this._startCashOption = new AddStartCashModule(this._attackPanelContestClip.bonusCashClip);
         this._startCashOption.enableWarningPanel(param1);
         this._startCashOption.changedSignal.add(this.onBonusCashOptionChanged);
      }
      
      public function syncToTrackData(param1:TrackData) : void
      {
         this._trackData = param1;
         this._startCashOption.reset();
         this.updateThumbnail();
         this._attackPanelContestClip.terrainInfoGroup.terrainIcon.gotoAndStop(this.findTerrainSymbolFrame(this._trackData.terrainID));
         this._restrictions.syncTerrainRestrictionsWithType(this._trackData.terrainID);
         this._attackPanelContestClip.terrainInfoGroup.terrainInfoTxt.text = this._trackData.terrainName + " " + LocalisationConstants.TERRAIN;
         this.updateStartingCashField();
         this.updateCrates();
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         if(Kong.isOnKong() && Constants.DISABLE_CRATES_ON_KONG)
         {
            this._attackPanelContestClip.crateTickBoxes.visible = false;
         }
      }
      
      private function onAttack() : void
      {
         var _loc1_:int = 0;
         if(this._startCashOption.canAfford())
         {
            _loc1_ = this._resourceStore.btdStartingMoney + this.getBonusStartingCash();
            this.attackClickedSignal.dispatch(_loc1_,this._crateTickboxes.cratesTickedArray);
            this._startCashOption.apply();
            hide();
         }
      }
      
      private function onCancel() : void
      {
         hide();
         this.cancelClickedSignal.dispatch();
      }
      
      private function onBonusCashOptionChanged() : void
      {
         this.updateStartingCashField();
      }
      
      private function updateStartingCashField() : void
      {
         this._attackPanelContestClip.startingCashGroup.startingCash.text = LocalisationConstants.MONEY_SYMBOL + this._resourceStore.btdStartingMoney;
         var _loc1_:int = this.getBonusStartingCash();
         if(_loc1_ > 0)
         {
            this._attackPanelContestClip.startingCashGroup.startingCash.appendText(" + " + LocalisationConstants.MONEY_SYMBOL + _loc1_);
         }
      }
      
      private function updateThumbnail() : void
      {
         if(this._trackThumb != null)
         {
            if(this._attackPanelContestClip.track_mc.contains(this._trackThumb))
            {
               this._attackPanelContestClip.track_mc.removeChild(this._trackThumb);
            }
            MyTrackThumbNailClip.recycleThumbNail(this._trackThumb);
         }
         this._trackThumb = MyTrackThumbNailClip.getThumbNail(this._trackData,true);
         if(this._trackThumb != null)
         {
            this._trackThumb.scaleX = 0.9;
            this._trackThumb.scaleY = 0.9;
            this._attackPanelContestClip.track_mc.addChild(this._trackThumb);
         }
      }
      
      private function updateCrates() : void
      {
         var _loc1_:CrateManager = CrateManager.getInstance();
         this._crateTickboxes.setCratesAvailable(_loc1_.cratesAvailable());
         this._crateTickboxes.setCratesTicked(0);
      }
      
      private function findTerrainSymbolFrame(param1:String) : int
      {
         if(param1 == TileDefinitions.getInstance().GRASS)
         {
            return 1;
         }
         if(param1 == TileDefinitions.getInstance().FOREST)
         {
            return 2;
         }
         if(param1 == TileDefinitions.getInstance().HEAVY_FOREST)
         {
            return 3;
         }
         if(param1 == TileDefinitions.getInstance().HILLS)
         {
            return 4;
         }
         if(param1 == TileDefinitions.getInstance().VOLCANO)
         {
            return 5;
         }
         if(param1 == TileDefinitions.getInstance().DESERT)
         {
            return 6;
         }
         if(param1 == TileDefinitions.getInstance().JUNGLE)
         {
            return 7;
         }
         if(param1 == TileDefinitions.getInstance().RUINS)
         {
            return 8;
         }
         if(param1 == TileDefinitions.getInstance().MOUNTAINS)
         {
            return 9;
         }
         if(param1 == TileDefinitions.getInstance().SNOW)
         {
            return 10;
         }
         if(param1 == TileDefinitions.getInstance().RIVER)
         {
            return 11;
         }
         if(param1 == TileDefinitions.getInstance().LAKE)
         {
            return 12;
         }
         return 1;
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
