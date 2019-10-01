package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.PVPBattleHistoryPanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.analytics.StatsData;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.ui.bloon.BloonTypeIcon;
   import ninjakiwi.monkeyTown.ui.HideRevealViewCancelable;
   import ninjakiwi.monkeyTown.ui.ScrollBar;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class BattleHistoryPanel extends HideRevealViewCancelable
   {
       
      
      private var _clip:PVPBattleHistoryPanelClip;
      
      private var _infoBoxContainer:MovieClip;
      
      private var _bloonStrengthIconContainer:MovieClip;
      
      private var _roundsField:TextField;
      
      private var _rewardCashField:TextField;
      
      private var _trackThumbContainer:MovieClip;
      
      private var _noHistoryMessage:MovieClip;
      
      private var _bloonIcon:BloonTypeIcon;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _contentArea:MovieClip;
      
      private var _actualArea:MovieClip;
      
      private var _battleHistory:Array;
      
      private var _scrollBar:ScrollBar;
      
      private var _boxes:Array;
      
      public function BattleHistoryPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new PVPBattleHistoryPanelClip();
         this._infoBoxContainer = this._clip.infoBoxContainer;
         this._bloonStrengthIconContainer = this._clip.detailPanel.textFields.bloonStrengthIconContainer;
         this._roundsField = this._clip.detailPanel.textFields.roundsField;
         this._rewardCashField = this._clip.rewardCash;
         this._trackThumbContainer = this._clip.detailPanel.trackThumbContainer;
         this._noHistoryMessage = this._clip.noHistoryMessage;
         this._bloonIcon = new BloonTypeIcon();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._contentArea = this._clip.contentMask;
         this._actualArea = this._clip.actualMask;
         this._battleHistory = [];
         this._scrollBar = new ScrollBar(this._clip.scrollbar,this._infoBoxContainer,this._contentArea,true,Constants.MOUSE_WHEEL_SCROLL_SPEED);
         this._boxes = [];
         super(param1,param2);
         addChild(this._clip);
         this.init();
         this._bloonStrengthIconContainer.addChild(this._bloonIcon);
         this._contentArea.visible = false;
         this._infoBoxContainer.mask = this._actualArea;
      }
      
      private function init() : void
      {
         this._closeButton.setClickFunction(hide);
         PvPSignals.pvpDataUpdatedSignal.add(this.onPvPDataUpdatedSignal);
         this._bloonStrengthIconContainer.rotation = 15;
         this._scrollBar.fitView = this._clip.contentMask;
         this._clip.shade.mouseEnabled = false;
         this._clip.shade.mouseChildren = false;
      }
      
      override public function destroy() : void
      {
         var _loc1_:PVPHistoryInfoBox = null;
         LGDisplayListUtil.getInstance().removeAllChildren(this._clip);
         LGDisplayListUtil.getInstance().removeAllChildren(this._noHistoryMessage);
         LGDisplayListUtil.getInstance().removeAllChildren(this._infoBoxContainer);
         LGDisplayListUtil.getInstance().removeAllChildren(this._trackThumbContainer);
         LGDisplayListUtil.getInstance().removeAllChildren(this._bloonStrengthIconContainer);
         LGDisplayListUtil.getInstance().removeAllChildren(this);
         super.destroy();
         this._clip = null;
         _container = null;
         this._infoBoxContainer = null;
         this._bloonStrengthIconContainer = null;
         this._roundsField = null;
         this._rewardCashField = null;
         this._trackThumbContainer = null;
         this._noHistoryMessage = null;
         this._bloonIcon = null;
         this._closeButton.destroy();
         this._closeButton = null;
         this._contentArea = null;
         this._actualArea = null;
         this._battleHistory = null;
         this._scrollBar.destroy();
         this._scrollBar = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._boxes.length)
         {
            _loc1_ = this._boxes[_loc2_];
            _loc1_.destroy();
            _loc1_.selectedSignal.remove(this.onBoxSelected);
            _loc2_++;
         }
         this._boxes.length = 0;
         this._boxes = null;
         PvPSignals.pvpDataUpdatedSignal.remove(this.onPvPDataUpdatedSignal);
      }
      
      private function onPvPDataUpdatedSignal(param1:Object, param2:Object, param3:Object) : void
      {
         this._battleHistory = param1.battleHistory;
         this._battleHistory.sortOn("timeResolved",Array.DESCENDING);
         this.syncToData(this._battleHistory);
      }
      
      private function clear() : void
      {
         while(this._infoBoxContainer.numChildren > 0)
         {
            this._infoBoxContainer.removeChildAt(0);
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         this.syncToData(this._battleHistory);
         super.reveal(param1);
      }
      
      private function syncToData(param1:Array) : void
      {
         var _loc2_:PVPHistoryInfoBox = null;
         var _loc8_:Object = null;
         var _loc9_:* = false;
         this._boxes.length = 0;
         this._noHistoryMessage.visible = param1.length === 0;
         this._clip.detailPanel.textFields.visible = param1.length !== 0;
         this._clip.detailPanel.expiredClip.visible = param1.length !== 0;
         this._clip.detailPanel.attackIcon.visible = param1.length !== 0;
         if(param1 === null)
         {
            return;
         }
         this.clear();
         var _loc3_:int = 75;
         var _loc4_:int = 10;
         var _loc5_:int = _system.city.cityIndex;
         var _loc6_:String = _system.nkGatewayUser.loginInfo.id;
         var _loc7_:int = 0;
         for(; _loc7_ < param1.length; _loc7_++)
         {
            _loc8_ = param1[_loc7_];
            _loc9_ = _loc8_.sender.userID === _loc6_;
            if(_loc9_)
            {
               if(_loc8_.sender.cityIndex !== _loc5_)
               {
                  continue;
               }
            }
            else if(_loc8_.target.cityIndex !== _loc5_)
            {
               continue;
            }
            _loc2_ = new PVPHistoryInfoBox();
            _loc2_.syncToData(_loc8_);
            _loc2_.x = 20;
            _loc2_.y = _loc4_;
            _loc2_.selectedSignal.add(this.onBoxSelected);
            _loc4_ = _loc4_ + _loc3_;
            this._infoBoxContainer.addChild(_loc2_);
            this._boxes.push(_loc2_);
         }
         this._scrollBar.fit();
         if(this._boxes.length > 0)
         {
            this._boxes[0].onClick(null);
         }
         else
         {
            this.configureNoBoxSelected();
         }
         if(this._clip.battleStreaks.attackStatus != null)
         {
            this._clip.battleStreaks.attackStatus.text = StatsData.getInstance().totalMvMAttackWins.value + "/" + StatsData.getInstance().totalAttackSent.value;
         }
         if(this._clip.battleStreaks.defenseStatus != null)
         {
            this._clip.battleStreaks.defenseStatus.text = StatsData.getInstance().totalMvMDefensiveWins.value + "/" + StatsData.getInstance().totalAttackReceived.value;
         }
      }
      
      private function configureNoBoxSelected() : void
      {
         this._clip.detailPanel.visible = false;
      }
      
      private function onBoxSelected(param1:Object) : void
      {
         var trackThumbBitmapData:BitmapData = null;
         var trackThumb:Bitmap = null;
         var className:String = null;
         var cashPillage:int = 0;
         var boxData:Object = param1;
         this._clip.detailPanel.visible = true;
         var thumbClassName:String = "";
         if(boxData.info != null && boxData.info.trackName != null && boxData.info.trackName != "null")
         {
            className = "assets.maps." + boxData.info.trackName + "_png_thumb";
            thumbClassName = className;
         }
         else
         {
            thumbClassName = "";
         }
         while(this._trackThumbContainer.numChildren > 0)
         {
            this._trackThumbContainer.removeChildAt(0);
         }
         var ownUserID:String = _system.nkGatewayUser.loginInfo.id;
         var wasAttacker:Boolean = boxData.sender.userID === ownUserID;
         var wasDefender:Boolean = !wasAttacker;
         var thisPlayer:Object = !!wasAttacker?boxData.sender:boxData.target;
         var successfulForThisPlayer:Boolean = wasAttacker && boxData.resolution == "win" || wasDefender && boxData.resolution == "loss" || wasAttacker && boxData.resolution == "expire";
         if(wasAttacker)
         {
            this._clip.detailPanel.attackIcon.visible = true;
            this._clip.detailPanel.defenseIcon.visible = false;
         }
         else
         {
            this._clip.detailPanel.attackIcon.visible = false;
            this._clip.detailPanel.defenseIcon.visible = true;
         }
         if(boxData.info != null)
         {
            this._clip.detailPanel.textFields.roundsField.text = boxData.info.rounds.toString();
            if(boxData.info.totalRounds != null)
            {
               this._clip.detailPanel.textFields.roundsField.appendText(" / " + boxData.info.totalRounds.toString());
            }
            this._bloonIcon.setBloonType(boxData.info.bloonStrength);
            if(wasAttacker === true)
            {
               if(successfulForThisPlayer === true)
               {
                  this._clip.detailPanel.textFields.pillagedCash.visible = true;
                  this._clip.detailPanel.textFields.salvagedBloontonium.visible = false;
                  this._clip.detailPanel.textFields.honorchange.gotoAndStop(1);
                  if(this._clip.detailPanel.textFields.pillagedCash.rewardCash != null)
                  {
                     cashPillage = boxData.cashPillage;
                     if(boxData.info != null)
                     {
                        if(boxData.info.attackerCashReward != null)
                        {
                           cashPillage = boxData.info.attackerCashReward;
                        }
                     }
                     this._clip.detailPanel.textFields.pillagedCash.rewardCash.text = LocalisationConstants.MONEY_SYMBOL + String(cashPillage);
                  }
               }
               else
               {
                  this._clip.detailPanel.textFields.pillagedCash.visible = false;
                  this._clip.detailPanel.textFields.salvagedBloontonium.visible = false;
                  this._clip.detailPanel.textFields.honorchange.gotoAndStop(2);
               }
               if(this._clip.detailPanel.textFields.honorchange.rewardHonor != null)
               {
                  this._clip.detailPanel.textFields.honorchange.rewardHonor.text = "0";
                  if(boxData.sender != null)
                  {
                     if(boxData.sender.honourChange != undefined && boxData.sender.honourChange != null)
                     {
                        this._clip.detailPanel.textFields.honorchange.rewardHonor.text = String(boxData.sender.honourChange);
                     }
                  }
               }
            }
            else
            {
               this._clip.detailPanel.textFields.pillagedCash.visible = false;
               this._clip.detailPanel.textFields.salvagedBloontonium.visible = true;
               this._clip.detailPanel.textFields.honorchange.gotoAndStop(1);
               if(this._clip.detailPanel.textFields.salvagedBloontonium.bloontoniumText != null)
               {
                  if(boxData.info.salvagedBloontonium != null)
                  {
                     this._clip.detailPanel.textFields.salvagedBloontonium.bloontoniumText.text = String(int(boxData.info.salvagedBloontonium));
                  }
                  else
                  {
                     this._clip.detailPanel.textFields.salvagedBloontonium.bloontoniumText.text = "";
                  }
               }
               if(this._clip.detailPanel.textFields.honorchange.rewardHonor != null)
               {
                  this._clip.detailPanel.textFields.honorchange.rewardHonor.text = "0";
                  if(boxData.target != null)
                  {
                     if(boxData.target.honourChange != undefined && boxData.target.honourChange != null)
                     {
                        this._clip.detailPanel.textFields.honorchange.rewardHonor.text = String(boxData.target.honourChange);
                     }
                  }
               }
            }
         }
         else
         {
            this._clip.detailPanel.textFields.roundsField.text = "";
            this._bloonIcon.setBloonType(Constants.RED_BLOON);
            this._clip.detailPanel.textFields.pillagedCash.visible = false;
            this._clip.detailPanel.textFields.salvagedBloontonium.visible = false;
            this._clip.detailPanel.textFields.honorchange.gotoAndStop(2);
         }
         var otherPlayerData:Object = !!wasAttacker?boxData.target:boxData.sender;
         try
         {
            if(thumbClassName != "")
            {
               trackThumbBitmapData = new (getDefinitionByName(thumbClassName) as Class)();
               trackThumb = new Bitmap(trackThumbBitmapData);
               this._trackThumbContainer.addChild(trackThumb);
               this._clip.detailPanel.expiredClip.visible = false;
            }
            else
            {
               this._clip.detailPanel.expiredClip.visible = true;
            }
            return;
         }
         catch(err:Error)
         {
            return;
         }
      }
   }
}
