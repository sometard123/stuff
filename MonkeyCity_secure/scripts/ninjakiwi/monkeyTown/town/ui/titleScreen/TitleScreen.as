package ninjakiwi.monkeyTown.town.ui.titleScreen
{
   import assets.ui.MobilePromoButtonTitleClip;
   import assets.ui.TitleScreenClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.greensock.easing.Elastic;
   import com.greensock.easing.Sine;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.net.MaintenanceChecker;
   import ninjakiwi.monkeyTown.signals.LoginSignals;
   import ninjakiwi.monkeyTown.town.ui.MaintenancePanel;
   import ninjakiwi.monkeyTown.town.ui.RemoteLoginMessage;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.promo.MobilePromoButton;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import org.osflash.signals.Signal;
   
   public class TitleScreen extends HideRevealView
   {
       
      
      private var _parallaxManager:ParallaxManager;
      
      private var _clip:TitleScreenClip;
      
      private var _isRevealed:Boolean = false;
      
      public const playGameSignal:Signal = new Signal();
      
      public const deleteSaveSignal:Signal = new Signal();
      
      public var _playButton:ButtonControllerBase;
      
      private var _playButtonPlayMessage:MovieClip;
      
      private var _playButtonLoginMessage:MovieClip;
      
      public var _deleteSaveButton:ButtonControllerBase;
      
      private var _townHall:MovieClip;
      
      private var _dartHouseDarts:MovieClip;
      
      private var _mayor:MovieClip;
      
      private var _fenceMonkey:MovieClip;
      
      private var _fenceMonkeyFront:MovieClip;
      
      private var _windmillMonkey:MovieClip;
      
      private var _bank:MovieClip;
      
      private var _bananaTrees:MovieClip;
      
      private var _boomerangHut:MovieClip;
      
      private var _sky:MovieClip;
      
      private var _hills:MovieClip;
      
      private var _buildingsBackground:MovieClip;
      
      private var _mid:MovieClip;
      
      private var _foreground:MovieClip;
      
      private var _viewArea:MovieClip;
      
      private const DisplayUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      private var hillsLayerY:Number;
      
      private var buildingsBackgroundLayerY:Number;
      
      private var midLayerY:Number;
      
      private var foregroundLayerY:Number;
      
      private var _playButtonHomePosition:IntPoint2D;
      
      private var _playButtonIsUp:Boolean = false;
      
      private var _optionsButton:ButtonControllerBase;
      
      public var remoteLoginMessage:RemoteLoginMessage;
      
      private var _maintenanceWindow:MaintenancePanel;
      
      private var _noticeBoard:NoticeBoard;
      
      private var _lockOut:Boolean = false;
      
      private var _mobilePromo:MobilePromoButton;
      
      private var clockSyncTimeoutID = null;
      
      private var _fenceMonkeyAnimationPlaying:Boolean = false;
      
      private var _fenceMonkeyAnimationClosing:Boolean = false;
      
      private var _mouseIsOverPlayButton:Boolean;
      
      private var _windmillMonkeyPlaying:Boolean = false;
      
      private var _bananaTreeAnimationIsPlaying:Boolean = false;
      
      private var _dartHouseAnimationIsPlaying:Boolean = false;
      
      private var _bankAnimationIsPlaying:Boolean = false;
      
      private var _boomerangAnimationIsPlaying:Boolean = false;
      
      private var _mayorAnimationIsPlaying:Boolean = false;
      
      public function TitleScreen(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new TitleScreenClip();
         this._playButton = new ButtonControllerBase(this._clip.foreground.playButton);
         this._playButtonPlayMessage = this._clip.foreground.playButton.playMessage;
         this._playButtonLoginMessage = this._clip.foreground.playButton.loginMessage;
         this._deleteSaveButton = new ButtonControllerBase(this._clip.deleteSaveButton);
         this._townHall = this._clip.mid.townHall;
         this._dartHouseDarts = this._clip.mid.firingDarts;
         this._mayor = this._clip.mid.mayor;
         this._fenceMonkey = this._clip.foreground.fenceMonkey;
         this._fenceMonkeyFront = this._clip.foreground.fenceMonkeyFront;
         this._windmillMonkey = this._clip.mid.windmill.monkeyGuy;
         this._bank = this._clip.mid.bank;
         this._bananaTrees = this._clip.mid.bananaTrees;
         this._boomerangHut = this._clip.mid.boomerangHut;
         this._sky = this._clip.sky;
         this._hills = this._clip.hills;
         this._buildingsBackground = this._clip.buildingsBackground;
         this._mid = this._clip.mid;
         this._foreground = this._clip.foreground;
         this._viewArea = this._clip.viewArea;
         this._playButtonHomePosition = new IntPoint2D();
         this._noticeBoard = new NoticeBoard(this._clip.foreground.noticeBoard);
         this._mobilePromo = new MobilePromoButton(new MobilePromoButtonTitleClip());
         super(param1,param2);
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         this._playButtonHomePosition.set(this._playButton.target.x,this._playButton.target.y);
         this._playButton.target.y = this._playButton.target.y + 500;
         this.hillsLayerY = this._hills.y;
         this.buildingsBackgroundLayerY = this._buildingsBackground.y;
         this.midLayerY = this._mid.y;
         this.foregroundLayerY = this._foreground.y;
         this._optionsButton = new ButtonControllerBase(this._clip.optionsButton);
         this._optionsButton.setClickFunction(this.onOptionsButtonClick);
         this.showConnectingMessage();
         LoginSignals.showLoginPrompt.add(this.showLoginPrompt);
         LoginSignals.showPlayPrompt.add(this.showPlayPrompt);
         this.remoteLoginMessage = new RemoteLoginMessage(this);
         this._maintenanceWindow = new MaintenancePanel(this);
         this._noticeBoard.hide(0);
         this._clip.buildNumber.text = "build: " + Constants.BUILD_DATE + " - " + Constants.CLIENT_VERSION;
      }
      
      private function onOptionsButtonClick() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().optionsPanel);
      }
      
      private function tweenInPlayButton() : void
      {
         this._playButtonIsUp = true;
         TweenLite.to(this._playButton.target,0.5,{
            "delay":0.5,
            "y":this._playButtonHomePosition.y,
            "ease":Back.easeOut
         });
         if(this._clip.foreground.connectingMessage.visible)
         {
            TweenLite.to(this._clip.foreground.connectingMessage,0.3,{
               "alpha":0,
               "onComplete":function():void
               {
                  _clip.foreground.connectingMessage.visible = false;
               }
            });
         }
      }
      
      private function pulsePlayButton() : void
      {
         var _loc1_:Number = 0.2;
         var _loc2_:Number = 1.5;
         TweenLite.to(this._playButton.target,_loc1_,{
            "scaleX":_loc2_,
            "scaleY":_loc2_,
            "ease":Sine.easeInOut
         });
         TweenLite.to(this._playButton.target,_loc1_ * 2.5,{
            "delay":_loc1_,
            "scaleX":1,
            "scaleY":1,
            "ease":Elastic.easeOut
         });
      }
      
      private function showConnectingMessage() : void
      {
         this._clip.foreground.connectingMessage.visible = true;
         this._playButton.target.y = this._playButtonHomePosition.y + 500;
      }
      
      private function showPlayPrompt(param1:Boolean = false) : void
      {
         var isKicking:Boolean = param1;
         if(this._lockOut)
         {
            return;
         }
         var maintenanceChecker:MaintenanceChecker = new MaintenanceChecker(function(param1:int, param2:String):void
         {
            var result:int = param1;
            var message:String = param2;
            t.obj(result);
            if(result == MaintenanceChecker.RESULT_NETWORK_ERROR && !Constants.BYPASS_MAINTENANCE_MODE)
            {
               remoteLoginMessage.hide(0);
               _maintenanceWindow.hide(0);
               Main.instance.connectionLostPanel.tryReconnectSignal.addOnce(showPlayPrompt);
               Main.instance.connectionLostPanel.reveal();
            }
            else if((result == MaintenanceChecker.RESULT_UNDER_MAINTENANCE || result == MaintenanceChecker.RESULT_SERVER_FULL) && !Constants.BYPASS_MAINTENANCE_MODE)
            {
               remoteLoginMessage.hide(0);
               Main.instance.connectionLostPanel.hide(0);
               _maintenanceWindow.setMessage(message);
               _maintenanceWindow.onHideSignal.addOnce(showPlayPrompt);
               _maintenanceWindow.reveal();
            }
            else if(result == MaintenanceChecker.RESULT_SERVER_REFRESH)
            {
               _maintenanceWindow.setMessage("PLEASE REFRESH! This version of the game is out of date. Refresh the page to load the new client.");
               _maintenanceWindow.onHideSignal.addOnce(showPlayPrompt);
               _maintenanceWindow.reveal();
            }
            else
            {
               _maintenanceWindow.hide(0);
               Main.instance.connectionLostPanel.hide(0);
               if(isKicking)
               {
                  remoteLoginMessage.reveal();
               }
               else
               {
                  remoteLoginMessage.hide(0);
               }
               _playButtonLoginMessage.visible = false;
               _playButtonPlayMessage.visible = true;
               _playButton.setClickFunction(function():void
               {
                  playGameSignal.dispatch();
               });
               if(_playButtonIsUp)
               {
                  pulsePlayButton();
                  return;
               }
               tweenInPlayButton();
            }
         });
         maintenanceChecker.checkStatus();
      }
      
      public function showRequireSWFRefreshMessage() : void
      {
         setTimeout(function():void
         {
            _maintenanceWindow.setMessage("PLEASE REFRESH! This version of the game is out of date. Refresh the page to load the new client.");
            _maintenanceWindow.onHideSignal.addOnce(_maintenanceWindow.reveal);
            _maintenanceWindow.forceStayOpen = true;
            _maintenanceWindow.setOKButtonVisible(false);
            _maintenanceWindow.reveal();
            _clip.foreground.connectingMessage.visible = false;
            _lockOut = true;
         },300);
      }
      
      override protected function onGlobalResetSignal() : void
      {
      }
      
      private function showLoginPrompt() : void
      {
         this._playButtonLoginMessage.visible = true;
         this._playButtonPlayMessage.visible = false;
         this._playButton.setClickFunction(this.goToLoginPage);
         if(this._playButton.target !== this._clip.foreground.playButton)
         {
         }
         if(this._playButtonIsUp)
         {
            this.pulsePlayButton();
            return;
         }
         this.tweenInPlayButton();
      }
      
      private function goToLoginPage() : void
      {
         var _loc1_:URLRequest = null;
         if(Kong.isOnKong())
         {
            Kong.showSignInBox();
         }
         else
         {
            _loc1_ = new URLRequest(Constants.NK_LOGIN_URL);
            navigateToURL(_loc1_);
         }
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.init();
         stage.addEventListener(Event.RESIZE,this.onResizeHandler);
         this.onResizeHandler();
      }
      
      private function init() : void
      {
         this._playButton.setClickFunction(this.goToLoginPage);
         this._deleteSaveButton.target.visible = false;
         this._viewArea.visible = false;
         addChild(this._clip);
         this.setUpDefaultPlayStates();
         this._clip.mid.bananaTreeHit.addEventListener(MouseEvent.ROLL_OVER,this.onBananaTreeOver);
         this._bananaTrees.addEventListener(Event.COMPLETE,this.onBananaTreeAnimationComplete);
         this._clip.mid.dartHouseHit.addEventListener(MouseEvent.ROLL_OVER,this.onDartHouseOver);
         this._clip.mid.dartHouseHit.addEventListener(MouseEvent.ROLL_OUT,this.onDartHouseOut);
         this._dartHouseDarts.addEventListener(Event.COMPLETE,this.onDartHouseDartsAnimationComplete);
         this._clip.mid.bankHit.addEventListener(MouseEvent.ROLL_OVER,this.onBankOver);
         this._bank.addEventListener(Event.COMPLETE,this.onBankAnimationComplete);
         this._clip.mid.townHallHit.addEventListener(MouseEvent.ROLL_OVER,this.onTownHallOver);
         this._mayor.addEventListener(Event.COMPLETE,this.onTownHallComplete);
         this._clip.mid.boomerangHutHit.addEventListener(MouseEvent.ROLL_OVER,this.onBoomerangHutOver);
         this._boomerangHut.addEventListener(Event.COMPLETE,this.onBoomerangHutAnimationComplete);
         this._playButton.target.addEventListener(MouseEvent.ROLL_OVER,this.playButtonOverHandler);
         this._playButton.target.addEventListener(MouseEvent.ROLL_OUT,this.playButtonOutHandler);
         this._fenceMonkey.addEventListener(Event.COMPLETE,this.onFenceMonkeyAnimationComplete);
         this._fenceMonkey.addEventListener("revealComplete",this.onFenceMonkeyAnimationRevealComplete);
         this._clip.mid.windmillHit.addEventListener(MouseEvent.ROLL_OVER,this.onWindmillOver);
         this._windmillMonkey.addEventListener(Event.COMPLETE,this.onWindmillMonkeyAnimationComplete);
         this._clip.mid.bananaTreeHit.alpha = 0;
         this._clip.mid.bankHit.alpha = 0;
         this._clip.mid.dartHouseHit.alpha = 0;
         this._clip.mid.townHallHit.alpha = 0;
         this._clip.mid.boomerangHutHit.alpha = 0;
         this._clip.mid.windmillHit.alpha = 0;
         this.syncTimeToLocal();
         this.setHourHand(12);
         this.setMinuteHand(0);
         this._mobilePromo.hide();
         addChild(this._mobilePromo);
      }
      
      private function setUpDefaultPlayStates() : void
      {
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,true,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._townHall,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._dartHouseDarts,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._mayor,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._windmillMonkey,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._fenceMonkey,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._fenceMonkeyFront,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._bank,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._bananaTrees,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._boomerangHut,false,true);
         this._playButton.target.gotoAndStop(1);
         this._deleteSaveButton.target.gotoAndStop(1);
         this._optionsButton.target.gotoAndStop(1);
      }
      
      private function introReveal() : void
      {
         var tweenTime:Number = NaN;
         if(this._isRevealed)
         {
            return;
         }
         this.visible = true;
         this._isRevealed = true;
         var low:Number = -150;
         tweenTime = 0.5;
         var offset:Number = 400;
         var delay:Number = 0.2;
         this._hills.y = this.hillsLayerY + offset;
         this._buildingsBackground.y = this.buildingsBackgroundLayerY + offset;
         this._mid.y = this.midLayerY + offset;
         this._foreground.y = this.foregroundLayerY + offset;
         TweenLite.to(this._hills,tweenTime,{
            "delay":delay * 3.4,
            "y":this.hillsLayerY,
            "ease":Back.easeOut
         });
         TweenLite.to(this._buildingsBackground,tweenTime,{
            "delay":delay * 3,
            "y":this.buildingsBackgroundLayerY,
            "ease":Back.easeOut
         });
         TweenLite.to(this._mid,tweenTime,{
            "delay":delay * 2,
            "y":this.midLayerY,
            "ease":Back.easeOut
         });
         TweenLite.to(this._foreground,tweenTime,{
            "delay":delay,
            "y":this.foregroundLayerY,
            "ease":Back.easeOut
         });
         this._clip.sky.clouds.visible = false;
         TweenLite.delayedCall(delay * 6,function():void
         {
            _clip.sky.clouds.visible = true;
            _clip.sky.clouds.alpha = 0;
            TweenLite.to(_clip.sky.clouds,0.4,{"alpha":1});
            _clip.sky.clouds.gotoAndPlay(1);
         });
         this._clip.mainTitleText.y = -200;
         TweenLite.delayedCall(delay * 7,function():void
         {
            TweenLite.to(_clip.mainTitleText,0.8,{
               "y":25,
               "ease":Elastic.easeOut
            });
         });
         this._clip.godRay.visible = false;
         TweenLite.delayedCall(delay * 8,function():void
         {
            _clip.godRay.visible = true;
            _clip.godRay.alpha = 0;
            TweenLite.to(_clip.godRay,2,{"alpha":0.32});
         });
         TweenLite.delayedCall(1.6,this._mobilePromo.reveal);
      }
      
      private function syncTimeToLocal() : void
      {
         var _loc1_:Date = new Date();
         this.setHourHand(_loc1_.getHours() + _loc1_.getMinutes() / 60);
         this.setMinuteHand(_loc1_.getMinutes());
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(0);
         this.setUpDefaultPlayStates();
         this.visible = false;
         TweenLite.delayedCall(0.5,this.introReveal);
         this.syncTimeToLocal();
         if(this.clockSyncTimeoutID !== null)
         {
            clearInterval(this.clockSyncTimeoutID);
         }
         this.clockSyncTimeoutID = setInterval(this.syncTimeToLocal,10000);
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(0);
         this._isRevealed = false;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,false,true);
         this.remoteLoginMessage.hide(0);
         if(this.clockSyncTimeoutID !== null)
         {
            clearInterval(this.clockSyncTimeoutID);
         }
      }
      
      private function setHourHand(param1:Number) : void
      {
         param1 = param1 % 12;
         this._mid.townHall.clock.hourHand.gotoAndStop(int(60 / 12 * param1 + 1));
      }
      
      private function setMinuteHand(param1:Number) : void
      {
         param1 = param1 % 60;
         this._mid.townHall.clock.minuteHand.gotoAndStop(int(param1 + 1));
      }
      
      private function setUpNight() : void
      {
         this.setLightLevel(0);
         this._clip.sky.clouds.visible = false;
         this._clip.sky.clouds.gotoAndStop(1);
         this._clip.godRay.visible = false;
      }
      
      public function setLightLevel(param1:Number) : void
      {
         var _loc2_:ColorTransform = new ColorTransform(param1,param1,param1,1,0,0,0,0);
         this._foreground.transform.colorTransform = _loc2_;
         this._mid.transform.colorTransform = _loc2_;
         this._buildingsBackground.transform.colorTransform = _loc2_;
      }
      
      private function playButtonOverHandler(param1:MouseEvent) : void
      {
         this._mouseIsOverPlayButton = true;
         this.showFenceMonkey();
      }
      
      private function showFenceMonkey() : void
      {
         if(this._fenceMonkeyAnimationPlaying)
         {
            return;
         }
         this._fenceMonkeyAnimationPlaying = true;
         this._fenceMonkey.gotoAndPlay(1);
         this._fenceMonkeyFront.gotoAndPlay(1);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._fenceMonkey,true,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._fenceMonkeyFront,true,true);
      }
      
      private function onFenceMonkeyAnimationRevealComplete(param1:Event) : void
      {
         if(!this._mouseIsOverPlayButton)
         {
            this.closeFenceMonkey();
         }
      }
      
      private function playButtonOutHandler(param1:MouseEvent) : void
      {
         this._mouseIsOverPlayButton = false;
         this.closeFenceMonkey();
      }
      
      private function closeFenceMonkey() : void
      {
         if(this._fenceMonkeyAnimationClosing)
         {
            return;
         }
         this._fenceMonkeyAnimationClosing = true;
         this._fenceMonkey.gotoAndPlay(150);
         this._fenceMonkeyFront.gotoAndPlay(150);
      }
      
      private function onFenceMonkeyAnimationComplete(param1:Event) : void
      {
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._fenceMonkey,false,true);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._fenceMonkeyFront,false,true);
         this._fenceMonkeyAnimationPlaying = false;
         this._fenceMonkeyAnimationClosing = false;
         if(this._mouseIsOverPlayButton)
         {
            this.showFenceMonkey();
         }
      }
      
      private function onWindmillOver(param1:MouseEvent) : void
      {
         this.playWindmillMonkeyAnimation();
      }
      
      private function playWindmillMonkeyAnimation() : void
      {
         if(this._windmillMonkeyPlaying)
         {
            return;
         }
         this._windmillMonkeyPlaying = true;
         this._windmillMonkey.gotoAndPlay(1);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._windmillMonkey,true,true);
      }
      
      private function onWindmillMonkeyAnimationComplete(param1:Event) : void
      {
         this._windmillMonkeyPlaying = false;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._windmillMonkey,false,true);
      }
      
      private function onBananaTreeOver(param1:MouseEvent) : void
      {
         if(this._bananaTreeAnimationIsPlaying)
         {
            return;
         }
         this._bananaTreeAnimationIsPlaying = true;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._bananaTrees,true,true);
      }
      
      private function onBananaTreeAnimationComplete(param1:Event) : void
      {
         this._bananaTreeAnimationIsPlaying = false;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._bananaTrees,false,true);
      }
      
      private function onDartHouseOver(param1:MouseEvent) : void
      {
         if(this._dartHouseAnimationIsPlaying)
         {
            return;
         }
         this._dartHouseAnimationIsPlaying = true;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._dartHouseDarts,true,true);
      }
      
      private function onDartHouseOut(param1:MouseEvent) : void
      {
         this._dartHouseAnimationIsPlaying = false;
      }
      
      private function onDartHouseDartsAnimationComplete(param1:Event) : void
      {
         if(!this._dartHouseAnimationIsPlaying)
         {
            this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._dartHouseDarts,false,true);
         }
      }
      
      private function onBankOver(param1:MouseEvent) : void
      {
         if(this._bankAnimationIsPlaying)
         {
            return;
         }
         this._bankAnimationIsPlaying = true;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._bank,true,true);
      }
      
      private function onBankAnimationComplete(param1:Event) : void
      {
         this._bankAnimationIsPlaying = false;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._bank,false,true);
      }
      
      private function onBoomerangHutOver(param1:MouseEvent) : void
      {
         if(this._boomerangAnimationIsPlaying)
         {
            return;
         }
         this._boomerangAnimationIsPlaying = true;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._boomerangHut,true,true);
      }
      
      private function onBoomerangHutAnimationComplete(param1:Event) : void
      {
         this._boomerangAnimationIsPlaying = false;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._boomerangHut,false,true);
      }
      
      private function onTownHallOver(param1:MouseEvent) : void
      {
         if(this._mayorAnimationIsPlaying)
         {
            return;
         }
         this._mayorAnimationIsPlaying = true;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._mayor,true,true);
      }
      
      private function onTownHallComplete(param1:Event) : void
      {
         this._mayorAnimationIsPlaying = false;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._mayor,false,true);
      }
      
      private function onResizeHandler(param1:Event = null) : void
      {
         this._clip.x = int(_stage.stageWidth * 0.5);
         this._clip.scaleX = this._clip.scaleY = _stage.stageHeight / this._viewArea.height;
      }
   }
}
