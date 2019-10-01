package ninjakiwi.monkeyTown.ui
{
   import assets.btdmodule.ContestedTerritoryWinWeekPanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.contestedTerritory.ContestPanelHelper;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class ContestWinWeekPanel extends HideRevealView
   {
      
      public static const rewardClaimedSignal:Signal = new Signal();
      
      public static const doneViewing:Signal = new Signal(Boolean);
      
      private static const EVENT_ALL_NAMES_LOADED:String = "AllNamesLoaded";
      
      private static const BLOONSTONE_POSITION_Y_SPACING:Number = 16.75;
       
      
      private const TITLES:Array = ["WINNER!","SECOND!","THIRD!"];
      
      private var _clip:ContestedTerritoryWinWeekPanelClip;
      
      private var _collectButton:ButtonControllerBase;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _goButton:ButtonControllerBase;
      
      private var _notHeldLongEnoughClip:MovieClip;
      
      private var _newContestedTerritoryClip:MovieClip;
      
      private var _titleText:TextField;
      
      private var _nameFields:Vector.<TextField>;
      
      private var _timeFields:Vector.<TextField>;
      
      private var _players:Vector.<Object>;
      
      private var _bloonstoneReward:INumber;
      
      private var _winnerBloonstoneYOrigin:Number = 0;
      
      private var _collectedBloonstones:Boolean = false;
      
      public function ContestWinWeekPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ContestedTerritoryWinWeekPanelClip();
         this._collectButton = new ButtonControllerBase(this._clip.collectButton);
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._goButton = new ButtonControllerBase(this._clip.go_btn);
         this._notHeldLongEnoughClip = this._clip.notHeld24hrs;
         this._newContestedTerritoryClip = this._clip.newContestedTerritory;
         this._titleText = this._clip.winnerTitle.title;
         this._nameFields = new Vector.<TextField>();
         this._timeFields = new Vector.<TextField>();
         this._players = new Vector.<Object>();
         this._bloonstoneReward = DancingShadows.getOne();
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this,false,true,true);
         this._collectButton.setClickFunction(this.onCollectButton);
         this._closeButton.setClickFunction(this.onCloseButton);
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
         this.hide();
         this.bloonstoneReward = 0;
         this._winnerBloonstoneYOrigin = this._clip.winnerBloonstone.y;
      }
      
      public function updateInfo(param1:Vector.<Object>, param2:int, param3:int, param4:Boolean) : void
      {
         this._players = param1;
         this.bloonstoneReward = ContestPanelHelper.CONTESTED_TERRITORY_BLOONSTONES_REWARDS[param2];
         this._titleText.text = this.TITLES[param2];
         this.setCanPlayerHaveBloonstones(param4);
         this._clip.tier.text = LocalisationConstants.CONTEST_TIER.split("<tier>").join(String(param3));
         this._clip.winnerBloonstone.y = this._winnerBloonstoneYOrigin + BLOONSTONE_POSITION_Y_SPACING * param2;
         var _loc5_:int = 0;
         while(_loc5_ < ContestedTerritoryPanel.CONTESTED_TERRITORY_NUM_OF_CITIES)
         {
            if(_loc5_ >= this._players.length)
            {
               this._nameFields[_loc5_].text = "";
               this._timeFields[_loc5_].text = "";
            }
            else
            {
               this._timeFields[_loc5_].text = ContestPanelHelper.getTimeStringFromUnixTime(!!this._players[_loc5_].score.hasOwnProperty("duration")?Number(this._players[_loc5_].score.duration):Number(0));
               if(this._players[_loc5_].hasOwnProperty("userName") && this._players[_loc5_].userName != null)
               {
                  this._nameFields[_loc5_].text = this._players[_loc5_].userName;
               }
               else if(this._players[_loc5_].hasOwnProperty("userID") && this._players[_loc5_].userID != null)
               {
                  this._nameFields[_loc5_].text = this._players[_loc5_].userID;
               }
               else
               {
                  this._nameFields[_loc5_].text = "";
               }
               this._nameFields[_loc5_].textColor = this._players[_loc5_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id?uint(ContestPanelHelper.TEXT_COLOUR_LIGHT):uint(ContestPanelHelper.TEXT_COLOUR_DARK);
               this._timeFields[_loc5_].textColor = this._players[_loc5_].userID == MonkeySystem.getInstance().nkGatewayUser.loginInfo.id?uint(ContestPanelHelper.TEXT_COLOUR_LIGHT):uint(ContestPanelHelper.TEXT_COLOUR_DARK);
            }
            _loc5_++;
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         this._clip.templeBanana.play();
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         this._clip.templeBanana.stop();
         super.hide(param1);
      }
      
      private function onCollectButton() : void
      {
         if(this._collectedBloonstones)
         {
            return;
         }
         rewardClaimedSignal.dispatch();
         this._collectedBloonstones = true;
         this._collectButton.disableMouseInteraction();
         this._collectButton.fadeOut(0);
         this._closeButton.enableMouseInteraction();
         this._closeButton.fadeIn(0);
         this._goButton.enableMouseInteraction();
         this._goButton.fadeIn(0);
         this._clip.winnerBloonstone.visible = false;
         this._clip.notHeld24hrs.visible = false;
         this._clip.newContestedTerritory.visible = true;
      }
      
      private function onGoButton() : void
      {
         this.hide();
         doneViewing.dispatch(true);
      }
      
      private function onCloseButton() : void
      {
         this.hide();
         doneViewing.dispatch(false);
      }
      
      private function setCanPlayerHaveBloonstones(param1:Boolean) : void
      {
         if(param1)
         {
            this._collectButton.enableMouseInteraction();
            this._collectButton.fadeIn(0);
            this._closeButton.disableMouseInteraction();
            this._closeButton.fadeOut(0);
            this._goButton.disableMouseInteraction();
            this._goButton.fadeOut(0);
            this._clip.winnerBloonstone.visible = true;
            this._clip.notHeld24hrs.visible = false;
            this._clip.newContestedTerritory.visible = false;
            this._collectedBloonstones = false;
            this._clip.bloonstones.text = this.bloonstoneReward.toString();
         }
         else
         {
            this._collectButton.disableMouseInteraction();
            this._collectButton.fadeOut(0);
            this._closeButton.enableMouseInteraction();
            this._closeButton.fadeIn(0);
            this._goButton.enableMouseInteraction();
            this._goButton.fadeIn(0);
            this._clip.winnerBloonstone.visible = false;
            this._clip.notHeld24hrs.visible = true;
            this._clip.newContestedTerritory.visible = false;
            this._collectedBloonstones = true;
         }
      }
      
      public function get bloonstoneReward() : int
      {
         return this._bloonstoneReward.value;
      }
      
      public function set bloonstoneReward(param1:int) : void
      {
         this._bloonstoneReward.value = param1;
      }
   }
}
