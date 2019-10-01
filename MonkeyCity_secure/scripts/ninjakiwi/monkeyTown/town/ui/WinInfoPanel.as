package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.WinInfoPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.smallEvents.miniLandGrab.MiniLandGrab;
   import ninjakiwi.monkeyTown.smallEvents.miniLandGrab.MiniLandGrabRewardDef;
   import ninjakiwi.monkeyTown.smallEvents.monkeyTeam.MonkeyTeam;
   import ninjakiwi.monkeyTown.smallEvents.monkeyTeam.MonkeyTeamRewardDef;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class WinInfoPanel extends HideRevealViewPopup
   {
       
      
      private var _clip:WinInfoPanelClip;
      
      private var _knowledgePane:MovieClip;
      
      private var _okButton:ButtonControllerBase;
      
      public const okSignal:Signal = new Signal();
      
      private const _resourceStore:ResourceStore = ResourceStore.getInstance();
      
      private var _miniLandGrabClip:MovieClip;
      
      private var _miniLandGrabClipRewardIcon:MovieClip;
      
      private var _miniLandGrabClipRewardText:TextField;
      
      private var _monkeyTeamsClip:MovieClip;
      
      private var _monkeyTeamsClipRewardIcon:MovieClip;
      
      private var _monkeyTeamsClipRewardText:TextField;
      
      private const congratulatoryExclamations:Vector.<String> = Vector.<String>(["Congrats!","Awesome sauce!","Great job!","Poptastic!","Monkey high five!","More awesomer!"]);
      
      private var _terrainFrame:Array;
      
      private var _specialTerrainFrame:Array;
      
      private var _currentMonkey:MovieClip;
      
      public function WinInfoPanel(param1:DisplayObjectContainer)
      {
         this._clip = new WinInfoPanelClip();
         this._knowledgePane = this._clip.monkeyKnowledge;
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._miniLandGrabClip = this._clip.miniLandGrab;
         this._miniLandGrabClipRewardIcon = this._miniLandGrabClip.icons0;
         this._miniLandGrabClipRewardText = this._miniLandGrabClip.rewardsTxt;
         this._monkeyTeamsClip = this._clip.monkeyTeams;
         this._monkeyTeamsClipRewardIcon = this._monkeyTeamsClip.icons0;
         this._monkeyTeamsClipRewardText = this._monkeyTeamsClip.rewardsTxt;
         this._terrainFrame = new Array();
         this._specialTerrainFrame = new Array();
         this._currentMonkey = this._clip.monkeySalute;
         super(param1);
         this.initSymbolFrame();
         addChild(this._clip);
         this._okButton.setClickFunction(this.okButtonClicked);
         isModal = true;
         enableDefaultOnResize(this._clip);
         setAutoPlayStopClipsArray([this._clip.monkeySalute,this._clip.shoutingMonkey]);
      }
      
      public function gamePlayComplete(param1:Object) : void
      {
         var _loc3_:MiniLandGrab = null;
         var _loc5_:Tile = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:MonkeyTeam = null;
         var _loc9_:MonkeyTeamRewardDef = null;
         this._clip.gotoAndStop(1);
         var _loc2_:Object = param1.monkeyKnowledgeRewards;
         if(param1["terrainBonusBloonstones"] != null || param1["terrainBonusMoney"] != null)
         {
            this._clip.gotoAndStop(2);
            this.setTextFieldWithValue(this._clip.bloonStoneTerrainBonusTxt,param1["terrainBonusBloonstones"]);
            this.setTextFieldWithValue(this._clip.moneyTerrainBonusTxt,"$" + param1["terrainBonusMoney"]);
         }
         this._clip.caption1.text = this.congratulatoryExclamations[int(Math.random() * this.congratulatoryExclamations.length)];
         if(int(param1["bloonstonesEarned"]) > 0)
         {
            this.setTextFieldWithValue(this._clip.noLivesLostBonus.bloonStoneBonusTxt,param1["bloonstonesEarned"]);
         }
         this.setTextFieldWithValue(this._clip.victoryBonusPart.moneyBonusTxt,"$" + param1["cashEarned"]);
         this.setTextFieldWithValue(this._clip.victoryBonusPart.xpRewardTxt,param1["xpEarned"]);
         if(param1["tile"] != null)
         {
            _loc5_ = param1["tile"];
            if(_loc5_ != null)
            {
               this.setTerrainIcon(_loc5_);
            }
            _loc6_ = "";
            if(_loc5_.terrainSpecialProperty != null)
            {
               _loc6_ = TileDefinitions.getInstance().getTerrainNameByID(_loc5_.terrainSpecialProperty.id);
            }
            else
            {
               _loc6_ = TileDefinitions.getInstance().getTerrainNameByID(_loc5_.terrainDefinition.id);
            }
            this._clip.caption2.text = "You captured a " + _loc6_ + " Tile";
         }
         else if(param1["terrainName"] != null && param1["terrainType"] != null)
         {
            this._clip.caption2.text = "You beat " + param1["terrainName"] + " track";
            _loc7_ = int(this._terrainFrame[param1["terrainType"]]);
            this._clip.terrainIconSet.gotoAndStop(_loc7_);
         }
         else
         {
            this._clip.caption2.text = "You captured Another Tile";
         }
         if(param1["didPlayerLoseALife"] != null && param1["didPlayerLoseALife"] == false)
         {
            this._currentMonkey = this._clip.shoutingMonkey;
            this._clip.noLivesLostBonus.visible = true;
         }
         else
         {
            this._currentMonkey = this._clip.monkeySalute;
            this._clip.noLivesLostBonus.visible = false;
         }
         if(_loc2_ !== null && _loc2_.packs > 0)
         {
            this._clip.monkeyKnowledge.visible = true;
         }
         else
         {
            this._clip.monkeyKnowledge.visible = false;
         }
         _loc3_ = GameEventManager.getInstance().miniLandGrab;
         _loc3_.onTileCaptured();
         var _loc4_:MiniLandGrabRewardDef = _loc3_.givePendingReward(param1);
         if(MiniLandGrab.UI_REWARD_INDEX_NONE == _loc4_.uiRewardIndex || 0 == _loc4_.rewardAmount)
         {
            this._miniLandGrabClip.visible = false;
         }
         else
         {
            this._miniLandGrabClipRewardIcon.gotoAndStop(_loc4_.uiRewardIndex);
            this._miniLandGrabClipRewardText.text = _loc4_.rewardAmount.toString();
            this._miniLandGrabClip.visible = true;
         }
         this._monkeyTeamsClip.visible = false;
         if(param1.canHaveMonkeyTeamReward)
         {
            _loc8_ = GameEventManager.getInstance().monkeyTeam;
            _loc9_ = _loc8_.giveReward(param1);
            if(_loc9_.rewardAmount != 0 && _loc9_.uiRewardIndex != -1)
            {
               this._monkeyTeamsClip.visible = true;
               this._monkeyTeamsClipRewardIcon.gotoAndStop(_loc9_.uiRewardIndex);
               this._monkeyTeamsClipRewardText.text = _loc9_.rewardAmount.toString();
            }
         }
      }
      
      private function setTextFieldWithValue(param1:TextField, param2:String) : void
      {
         if(param1 != null)
         {
            if(param2 != null)
            {
               param1.text = param2;
            }
            else
            {
               param1.text = "0";
            }
         }
      }
      
      private function initSymbolFrame() : void
      {
         this._terrainFrame[TileDefinitions.getInstance().GRASS] = 1;
         this._terrainFrame[TileDefinitions.getInstance().FOREST] = 2;
         this._terrainFrame[TileDefinitions.getInstance().HEAVY_FOREST] = 3;
         this._terrainFrame[TileDefinitions.getInstance().HILLS] = 4;
         this._terrainFrame[TileDefinitions.getInstance().VOLCANO] = 5;
         this._terrainFrame[TileDefinitions.getInstance().DESERT] = 6;
         this._terrainFrame[TileDefinitions.getInstance().JUNGLE] = 7;
         this._terrainFrame[TileDefinitions.getInstance().RUINS] = 8;
         this._terrainFrame[TileDefinitions.getInstance().MOUNTAINS] = 9;
         this._terrainFrame[TileDefinitions.getInstance().SNOW] = 10;
         this._terrainFrame[TileDefinitions.getInstance().RIVER] = 11;
         this._terrainFrame[TileDefinitions.getInstance().LAKE] = 12;
         this._terrainFrame[TileDefinitions.getInstance().DESERT_HIGHLANDS] = 23;
         this._terrainFrame[TileDefinitions.getInstance().DESERT_BADLANDS] = 24;
         this._terrainFrame[TileDefinitions.getInstance().DESERT_ARID_GRASSLANDS] = 25;
         this._specialTerrainFrame[TileDefinitions.getInstance().TRANQUIL_GLADE] = 13;
         this._specialTerrainFrame[TileDefinitions.getInstance().PHASE_CRYSTAL] = 14;
         this._specialTerrainFrame[TileDefinitions.getInstance().MOAB_GRAVEYARD] = 15;
         this._specialTerrainFrame[TileDefinitions.getInstance().STICKY_SAP_PLANT] = 16;
         this._specialTerrainFrame[TileDefinitions.getInstance().CONSECRATED_GROUND] = 17;
         this._specialTerrainFrame[TileDefinitions.getInstance().CAVES] = 18;
         this._specialTerrainFrame[TileDefinitions.getInstance().WATTLE_TREES] = 19;
         this._specialTerrainFrame[TileDefinitions.getInstance().SHIPWRECK] = 20;
         this._specialTerrainFrame[TileDefinitions.getInstance().GLACIER] = 21;
         this._specialTerrainFrame[TileDefinitions.getInstance().SANDSTORM] = 26;
         this._specialTerrainFrame[TileDefinitions.getInstance().ZZZZOMG] = 27;
         this._specialTerrainFrame[TileDefinitions.getInstance().DRY_AS_A_BONE] = 28;
      }
      
      private function setTerrainIcon(param1:Tile) : void
      {
         var frame:int = 0;
         var tile:Tile = param1;
         try
         {
            frame = 1;
            if(tile != null)
            {
               if(tile.terrainSpecialProperty != null)
               {
                  if(this._specialTerrainFrame[tile.terrainSpecialProperty.id] != null)
                  {
                     frame = int(this._specialTerrainFrame[tile.terrainSpecialProperty.id]);
                  }
               }
               else if(this._terrainFrame[tile.terrainDefinition.id] != null)
               {
                  frame = int(this._terrainFrame[tile.terrainDefinition.id]);
               }
            }
            if(this._clip)
            {
               this._clip.terrainIconSet.gotoAndStop(frame);
               setAutoPlayStopClipsArray([this._clip.monkeySalute,this._clip.shoutingMonkey]);
            }
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function okButtonClicked() : void
      {
         this.okSignal.dispatch();
         hide();
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         if(this._currentMonkey == null)
         {
            this._currentMonkey = this._clip.monkeySalute;
         }
         if(this._currentMonkey == this._clip.monkeySalute)
         {
            this._clip.monkeySalute.visible = true;
            this._clip.shoutingMonkey.visible = false;
            this._clip.monkeySalute.gotoAndPlay(1);
         }
         else
         {
            this._clip.monkeySalute.visible = false;
            this._clip.shoutingMonkey.visible = true;
            this._clip.shoutingMonkey.gotoAndPlay(1);
         }
         this._currentMonkey = null;
         super.reveal(param1);
      }
   }
}
