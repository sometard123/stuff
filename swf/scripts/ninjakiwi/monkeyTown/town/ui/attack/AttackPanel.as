package ninjakiwi.monkeyTown.town.ui.attack
{
   import assets.ui.AttackPanelClip3;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.LevelDefData;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesTickBoxes;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.town.ui.terrain.TerrainRestrictionModule;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class AttackPanel extends AttackPanelBase
   {
      
      private static const terrainFrames:Object = {
         TileDefinitions.getInstance().GRASS.valueOf():1,
         TileDefinitions.getInstance().FOREST.valueOf():2,
         TileDefinitions.getInstance().HEAVY_FOREST.valueOf():3,
         TileDefinitions.getInstance().HILLS.valueOf():4,
         TileDefinitions.getInstance().VOLCANO.valueOf():5,
         TileDefinitions.getInstance().DESERT.valueOf():6,
         TileDefinitions.getInstance().JUNGLE.valueOf():7,
         TileDefinitions.getInstance().RUINS.valueOf():8,
         TileDefinitions.getInstance().MOUNTAINS.valueOf():9,
         TileDefinitions.getInstance().SNOW.valueOf():10,
         TileDefinitions.getInstance().RIVER.valueOf():11,
         TileDefinitions.getInstance().LAKE.valueOf():12
      };
       
      
      private const _clip:AttackPanelClip3 = new AttackPanelClip3();
      
      private var _hardcoreModeTickbox:TickBox;
      
      private var _hardcoreGreyoutPanel:MovieClip;
      
      private var _hardcoreSkull:MovieClip;
      
      private const _crateTickboxes:CratesTickBoxes = new CratesTickBoxes(this._clip.crateTickBoxes);
      
      private const _restrictions:TerrainRestrictionModule = new TerrainRestrictionModule(this._clip.restrictions);
      
      private var _trackThumb:MyTrackThumbNailClip;
      
      public function AttackPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,this._clip.bonusCashClip,this._clip.detailClip,this._clip.earnRewardClip,this._clip.cancelButton,this._clip.attackButton);
         addChild(this._clip);
         this._hardcoreModeTickbox = new TickBox(this._clip.hardcoreModeTickbox.tickBox);
         this._hardcoreGreyoutPanel = this._clip.hardcoreModeTickbox.locked;
         this._hardcoreSkull = this._clip.hardcoreModeTickbox.skull;
         this._hardcoreModeTickbox.changedSignal.add(this.tickBoxStateChangedSignal);
         this._clip.hardcoreModeTickbox.hardcoreIcons.gotoAndStop(2);
         this.setHardcoreEnabled(true);
         enableDefaultOnResize(this._clip);
         setAutoPlayStopClipsArray([this._clip.bonusCashClip.gem,this._hardcoreSkull]);
      }
      
      public static function getTileFrame(param1:String) : int
      {
         if(terrainFrames.hasOwnProperty(param1))
         {
            return terrainFrames[param1];
         }
         return 1;
      }
      
      private function tickBoxStateChangedSignal(param1:Boolean) : void
      {
         _earns.setHardcoreState(param1);
      }
      
      private function setHardcoreEnabled(param1:Boolean) : void
      {
         this._hardcoreGreyoutPanel.visible = !param1;
      }
      
      override public function get isHardcore() : Boolean
      {
         return this._hardcoreModeTickbox.ticked;
      }
      
      override public function get cratesTicked() : int
      {
         return this._crateTickboxes.cratesTicked;
      }
      
      override public function get cratesTickedArray() : Array
      {
         return this._crateTickboxes.cratesTickedArray;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this.setHardcoreEnabled(ResourceStore.getInstance().townLevel >= Constants.HARDCORE_MODE_MIN_LEVEL);
         this._hardcoreModeTickbox.ticked = false;
         if(Kong.isOnKong() && Constants.DISABLE_CRATES_ON_KONG)
         {
            this._clip.crateTickBoxes.visible = false;
         }
      }
      
      override public function setMessage(param1:TownMap, param2:TileAttackDefinition) : void
      {
         var _loc4_:String = null;
         var _loc7_:Object = null;
         var _loc8_:TrackData = null;
         super.setMessage(param1,param2);
         var _loc3_:Tile = param1.tileAtPoint(param2.attackAtLocation);
         if(_loc3_ == null)
         {
            return;
         }
         this._restrictions.syncTerrainRestrictions(_loc3_);
         var _loc5_:int = MonkeySystem.getInstance().city.cityIndex;
         var _loc6_:Array = LevelDefData.getLevelDefNamesByTerrain(param2.terrainType,_loc5_);
         if(_loc6_ !== null)
         {
            _loc7_ = LevelDefData.selectRandomTrackByDifficultyBias(_loc6_,_loc3_.trackSelectionBias);
            _loc4_ = _loc6_[_loc7_.index];
         }
         if(_loc3_.uniqueDataDefinition.trackID != -1)
         {
            _loc4_ = _loc3_.uniqueDataDefinition.trackClassName;
         }
         if(param1.totalCapturedCount() <= 0 && _loc5_ === 0)
         {
            _loc4_ = "Grass1";
         }
         if(_loc7_ != null && _loc7_.def != null)
         {
            if(this._trackThumb != null)
            {
               if(this._clip.track_mc.contains(this._trackThumb))
               {
                  this._clip.track_mc.removeChild(this._trackThumb);
               }
               MyTrackThumbNailClip.recycleThumbNail(this._trackThumb);
            }
            if(_loc4_ != null)
            {
               _loc8_ = TrackManager.getInstance().findTrack(_loc4_);
               this._trackThumb = MyTrackThumbNailClip.getThumbNail(_loc8_,true);
            }
            else
            {
               _loc8_ = TrackManager.getInstance().findTrackByDefName(_loc7_.def);
               this._trackThumb = MyTrackThumbNailClip.getThumbNail(_loc8_,true);
            }
            this._trackThumb.scaleX = 0.9;
            this._trackThumb.scaleY = 0.9;
            if(this._trackThumb != null)
            {
               this._clip.track_mc.addChild(this._trackThumb);
            }
            this.syncCrates();
         }
      }
      
      private function syncCrates() : void
      {
         var _loc1_:CrateManager = CrateManager.getInstance();
         this._crateTickboxes.setCratesAvailable(_loc1_.cratesAvailable());
         this._crateTickboxes.setCratesTicked(0);
      }
   }
}
