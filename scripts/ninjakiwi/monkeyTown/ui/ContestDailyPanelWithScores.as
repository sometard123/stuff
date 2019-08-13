package ninjakiwi.monkeyTown.ui
{
   import assets.btdmodule.ContestedTerritoryDaily2PanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.LinkifyHTMLText;
   
   public class ContestDailyPanelWithScores extends HideRevealView
   {
       
      
      private var _clip:ContestedTerritoryDaily2PanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _goButton:ButtonControllerBase;
      
      private var _nameFields:Vector.<TextField>;
      
      private var _timeFields:Vector.<TextField>;
      
      public function ContestDailyPanelWithScores(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ContestedTerritoryDaily2PanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._goButton = new ButtonControllerBase(this._clip.go_btn);
         this._nameFields = new Vector.<TextField>();
         this._timeFields = new Vector.<TextField>();
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this,false,true,true);
         this._closeButton.setClickFunction(hide);
         this._goButton.setClickFunction(this.onButtonGo);
         this._nameFields.push(this._clip.playerNameBoardField0);
         this._nameFields.push(this._clip.playerNameBoardField1);
         this._nameFields.push(this._clip.playerNameBoardField2);
         this._nameFields.push(this._clip.playerNameBoardField3);
         this._nameFields.push(this._clip.playerNameBoardField4);
         this._nameFields.push(this._clip.playerNameBoardField5);
         this._timeFields.push(this._clip.heldTimeBoardField0);
         this._timeFields.push(this._clip.heldTimeBoardField1);
         this._timeFields.push(this._clip.heldTimeBoardField2);
         this._timeFields.push(this._clip.heldTimeBoardField3);
         this._timeFields.push(this._clip.heldTimeBoardField4);
         this._timeFields.push(this._clip.heldTimeBoardField5);
         this._clip.winnerBloonstone.visible = false;
         hide();
      }
      
      public function updateInfo(param1:Object) : void
      {
         var _loc2_:Vector.<Object> = ContestPanelHelper.fetchPlayersFromServerResponse(param1);
         ContestPanelHelper.sortPlayersByTimeHeld(_loc2_);
         this._clip.tier.text = LocalisationConstants.CONTEST_TIER.split("<tier>").join(String(param1.levelTier));
         var _loc3_:int = 0;
         while(_loc3_ < ContestedTerritoryPanel.CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            if(_loc3_ >= _loc2_.length)
            {
               this._nameFields[_loc3_].text = "";
               this._timeFields[_loc3_].text = "";
            }
            else
            {
               if(!Kong.isOnKong())
               {
                  LinkifyHTMLText.linkifyTextfield(this._nameFields[_loc3_],_loc2_[_loc3_].userName,Constants.PROFILE_URL_BASE + _loc2_[_loc3_].userName);
               }
               else
               {
                  this._nameFields[_loc3_].text = _loc2_[_loc3_].userName;
               }
               this._timeFields[_loc3_].text = ContestPanelHelper.getTimeStringFromUnixTime(!!_loc2_[_loc3_].score.hasOwnProperty("duration")?Number(_loc2_[_loc3_].score.duration):Number(0));
               this._nameFields[_loc3_].textColor = _loc2_[_loc3_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id?uint(ContestPanelHelper.TEXT_COLOUR_LIGHT):uint(ContestPanelHelper.TEXT_COLOUR_DARK);
               this._timeFields[_loc3_].textColor = _loc2_[_loc3_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id?uint(ContestPanelHelper.TEXT_COLOUR_LIGHT):uint(ContestPanelHelper.TEXT_COLOUR_DARK);
            }
            _loc3_++;
         }
      }
      
      private function onButtonGo() : void
      {
         PanelManager.getInstance().showFreePanel(MonkeyCityMain.getInstance().ui.contestedTerritoryPanel);
         hide();
      }
   }
}
