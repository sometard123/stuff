package ninjakiwi.monkeyTown.ui
{
   import assets.btdmodule.ContestedTerritoryLoseWeekPanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class ContestLoseWeekPanel extends HideRevealView
   {
      
      public static const doneViewing:Signal = new Signal(Boolean);
      
      private static const EVENT_ALL_NAMES_LOADED:String = "AllNamesLoaded";
       
      
      private var _clip:ContestedTerritoryLoseWeekPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _goButton:ButtonControllerBase;
      
      private var _nameFields:Vector.<TextField>;
      
      private var _timeFields:Vector.<TextField>;
      
      private var _pins:Vector.<MovieClip>;
      
      private var _players:Vector.<Object>;
      
      public function ContestLoseWeekPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ContestedTerritoryLoseWeekPanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._goButton = new ButtonControllerBase(this._clip.go_btn);
         this._nameFields = new Vector.<TextField>();
         this._timeFields = new Vector.<TextField>();
         this._pins = new Vector.<MovieClip>();
         this._players = new Vector.<Object>();
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this,false,true,true);
         this._closeButton.setClickFunction(this.onHideButton);
         this._goButton.setClickFunction(this.onGoButton);
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
         this._pins.push(this._clip.playerArrow0);
         this._pins.push(this._clip.playerArrow1);
         this._pins.push(this._clip.playerArrow2);
         this._pins.push(this._clip.playerArrow3);
         this._pins.push(this._clip.playerArrow4);
         this._pins.push(this._clip.playerArrow5);
         hide();
      }
      
      public function updateInfo(param1:Vector.<Object>, param2:int) : void
      {
         this._players = param1;
         this._clip.tier.text = LocalisationConstants.CONTEST_TIER.split("<tier>").join(String(param2));
         var _loc3_:int = 0;
         while(_loc3_ < ContestedTerritoryPanel.CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            if(_loc3_ >= this._players.length)
            {
               this._nameFields[_loc3_].text = "";
               this._timeFields[_loc3_].text = "";
               this._pins[_loc3_].visible = false;
            }
            else
            {
               this._timeFields[_loc3_].text = ContestPanelHelper.getTimeStringFromUnixTime(!!this._players[_loc3_].score.hasOwnProperty("duration")?Number(this._players[_loc3_].score.duration):Number(0));
               if(this._players[_loc3_].hasOwnProperty("userName") && this._players[_loc3_].userName != null)
               {
                  this._nameFields[_loc3_].text = this._players[_loc3_].userName;
               }
               else if(this._players[_loc3_].hasOwnProperty("userID") && this._players[_loc3_].userID != null)
               {
                  this._nameFields[_loc3_].text = this._players[_loc3_].userID;
               }
               else
               {
                  this._nameFields[_loc3_].text = "";
               }
               this._nameFields[_loc3_].textColor = this._players[_loc3_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id?uint(ContestPanelHelper.TEXT_COLOUR_LIGHT):uint(ContestPanelHelper.TEXT_COLOUR_DARK);
               this._timeFields[_loc3_].textColor = this._players[_loc3_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id?uint(ContestPanelHelper.TEXT_COLOUR_LIGHT):uint(ContestPanelHelper.TEXT_COLOUR_DARK);
               this._pins[_loc3_].visible = this._players[_loc3_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id;
            }
            _loc3_++;
         }
      }
      
      private function onHideButton() : void
      {
         hide();
         doneViewing.dispatch(false);
      }
      
      private function onGoButton() : void
      {
         hide();
         doneViewing.dispatch(true);
      }
   }
}
