package ninjakiwi.monkeyTown.ui
{
   import assets.ui.LoadingBTDTransitionClip;
   import assets.ui.LoadingBTDTransitionClipContest;
   import assets.ui.LoadingCityTransitionClipLose;
   import assets.ui.LoadingCityTransitionClipLoseContest;
   import assets.ui.LoadingCityTransitionClipWin;
   import assets.ui.LoadingCityTransitionClipWinContest;
   import com.lgrey.utils.LGDisplayListUtil;
   import com.lgrey.utils.LGMathUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btd.BTDView;
   import ninjakiwi.monkeyTown.sound.MCMusic;
   
   public class LoadingTransition extends HideRevealView
   {
      
      public static var instance:LoadingTransition;
       
      
      private var _clipLoadingBTD:LoadingBTDTransitionClip;
      
      private var _clipLoadingContest:LoadingBTDTransitionClipContest;
      
      private var _clipLoadingCityLose:LoadingCityTransitionClipLose;
      
      private var _clipLoadingCityWin:LoadingCityTransitionClipWin;
      
      private var _clipLoadingContestLose:LoadingCityTransitionClipLoseContest;
      
      private var _clipLoadingContestWin:LoadingCityTransitionClipWinContest;
      
      private var _currentClip:MovieClip;
      
      private var DisplayListUtil:LGDisplayListUtil;
      
      private var _viewArea:Sprite;
      
      private const btdProgressBarAllowance:Number = 0.7;
      
      private var shareBarWithBTDModule:Boolean = false;
      
      private var btdLoadProgress:Number = 0;
      
      private var trackLoadProgress:Number = 0;
      
      private var audioLoadProgress:Number = 0;
      
      private var audioTrackID:String = null;
      
      private var btdStartingProgress:Number = 0;
      
      private var btdHasLoaded:Boolean = false;
      
      private var _progressAtReveal:Number = 0;
      
      private var _btdGameIsNowReady:Boolean;
      
      private var _trackAudioIsNowReady:Boolean;
      
      private var _audioProgress:Number = 0;
      
      private var _isLaunchingContested:Boolean = false;
      
      public function LoadingTransition(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clipLoadingBTD = new LoadingBTDTransitionClip();
         this._clipLoadingContest = new LoadingBTDTransitionClipContest();
         this._clipLoadingCityLose = new LoadingCityTransitionClipLose();
         this._clipLoadingCityWin = new LoadingCityTransitionClipWin();
         this._clipLoadingContestLose = new LoadingCityTransitionClipLoseContest();
         this._clipLoadingContestWin = new LoadingCityTransitionClipWinContest();
         this._currentClip = this._clipLoadingBTD;
         this.DisplayListUtil = LGDisplayListUtil.getInstance();
         this._viewArea = this._clipLoadingBTD.viewArea;
         instance = this;
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._clipLoadingBTD);
         this.sleep();
         this._clipLoadingBTD.addEventListener("openAnimationComplete",this.onOpenAnimationComplete);
         this._clipLoadingBTD.addEventListener("closeAnimationComplete",this.onCloseAnimationComplete);
         this._clipLoadingContest.addEventListener("openAnimationComplete",this.onOpenAnimationComplete);
         this._clipLoadingContest.addEventListener("closeAnimationComplete",this.onCloseAnimationComplete);
         this._clipLoadingCityWin.addEventListener("openAnimationComplete",this.onOpenAnimationComplete);
         this._clipLoadingCityWin.addEventListener("closeAnimationComplete",this.onCloseAnimationComplete);
         this._clipLoadingCityLose.addEventListener("openAnimationComplete",this.onOpenAnimationComplete);
         this._clipLoadingCityLose.addEventListener("closeAnimationComplete",this.onCloseAnimationComplete);
         this._clipLoadingContestWin.addEventListener("openAnimationComplete",this.onOpenAnimationComplete);
         this._clipLoadingContestWin.addEventListener("closeAnimationComplete",this.onCloseAnimationComplete);
         this._clipLoadingContestLose.addEventListener("openAnimationComplete",this.onOpenAnimationComplete);
         this._clipLoadingContestLose.addEventListener("closeAnimationComplete",this.onCloseAnimationComplete);
         TransitionSignals.beganLoadingContestedGame.add(this.onBeganLoadingContestedGame);
         this.initListeners();
         _system.flashStage.addEventListener(Event.RESIZE,this.onResizeHandler);
         this._viewArea.visible = false;
         this._clipLoadingCityWin.viewArea.visible = false;
         this._clipLoadingCityLose.viewArea.visible = false;
         this._clipLoadingContestWin.viewArea.visible = false;
         this._clipLoadingContestLose.viewArea.visible = false;
         this._clipLoadingContest.viewArea.visible = false;
         this.setProgressGraphic(0);
         this.onResizeHandler();
         BTDView.btdLoadProgressSignal.add(this.onBTDModuleLoadProgress);
         TransitionSignals.gameSwfLoadProgressSignal.add(this.onTrackLoadProgress);
      }
      
      private function onBeganLoadingContestedGame() : void
      {
         this._isLaunchingContested = true;
      }
      
      public function showBTDLoadScreen() : void
      {
         if(this.contains(this._clipLoadingCityWin))
         {
            this.removeChild(this._clipLoadingCityWin);
         }
         if(this.contains(this._clipLoadingCityLose))
         {
            this.removeChild(this._clipLoadingCityLose);
         }
         if(this.contains(this._clipLoadingContestWin))
         {
            this.removeChild(this._clipLoadingContestWin);
         }
         if(this.contains(this._clipLoadingContestLose))
         {
            this.removeChild(this._clipLoadingContestLose);
         }
         if(this.contains(this._clipLoadingBTD))
         {
            this.removeChild(this._clipLoadingBTD);
         }
         if(this.contains(this._clipLoadingContest))
         {
            this.removeChild(this._clipLoadingContest);
         }
         if(this._isLaunchingContested)
         {
            this.addChild(this._clipLoadingContest);
            this._currentClip = this._clipLoadingContest;
         }
         else
         {
            this.addChild(this._clipLoadingBTD);
            this._currentClip = this._clipLoadingBTD;
         }
      }
      
      public function showCityLoadScreen(param1:Boolean, param2:Boolean = false) : void
      {
         if(this.contains(this._clipLoadingBTD))
         {
            this.removeChild(this._clipLoadingBTD);
         }
         if(this.contains(this._clipLoadingContest))
         {
            this.removeChild(this._clipLoadingContest);
         }
         if(param2)
         {
            if(param1)
            {
               this.addChild(this._clipLoadingContestWin);
               this._currentClip = this._clipLoadingContestWin;
            }
            else
            {
               this.addChild(this._clipLoadingContestLose);
               this._currentClip = this._clipLoadingContestLose;
            }
         }
         else if(param1)
         {
            this.addChild(this._clipLoadingCityWin);
            this._currentClip = this._clipLoadingCityWin;
         }
         else
         {
            this.addChild(this._clipLoadingCityLose);
            this._currentClip = this._clipLoadingCityLose;
         }
         this._isLaunchingContested = false;
      }
      
      private function onTrackLoadProgress(param1:Number) : void
      {
         this.trackLoadProgress = param1;
      }
      
      private function onBTDModuleLoadProgress(param1:Number) : void
      {
         this.btdLoadProgress = param1;
      }
      
      private function onBTDModuleLoadComplete() : void
      {
         BTDView.btdLoadProgressSignal.remove(this.onBTDModuleLoadProgress);
         BTDView.btdLoadCompleteSignal.remove(this.onBTDModuleLoadComplete);
         this.btdHasLoaded = true;
      }
      
      private function update(param1:Event) : void
      {
         var _loc2_:Number = this.getTotalProgress();
         if(this._progressAtReveal > _loc2_)
         {
            this._progressAtReveal = _loc2_;
         }
         var _loc3_:Number = LGMathUtil.getInstance().remapValueToRange(_loc2_,this._progressAtReveal,1,0,1);
         if(isNaN(_loc3_))
         {
            _loc3_ = 1;
         }
         this.setProgressGraphic(_loc3_);
      }
      
      private function getTotalProgress() : Number
      {
         var _loc1_:int = 3;
         this._audioProgress = MCMusic.getProgressOfTrack(BTDView.currentMusicID);
         return (this.btdLoadProgress + this.trackLoadProgress + this._audioProgress) / _loc1_;
      }
      
      public function setProgressGraphic(param1:Number) : void
      {
         if(!this._currentClip || !this._currentClip.background || !this._currentClip.background.loadingBar)
         {
            return;
         }
         param1 = param1 < 0?Number(0):Number(param1);
         param1 = param1 > 1?Number(1):Number(param1);
         this._currentClip.background.loadingBar.scaleX = param1;
      }
      
      private function initListeners() : void
      {
         TransitionSignals.beganLoadingBTDGame.add(function():void
         {
            resetFlags();
            showBTDLoadScreen();
            reveal();
            addEventListener(Event.ENTER_FRAME,update);
         });
         TransitionSignals.btdGameIsNowReady.add(this.onBTDGameReadySignal);
         BTDView.audioTrackLoadComplete.add(this.onAudioTrackLoadComplete);
         TransitionSignals.beginTransitionFromBTDToCity.add(function(param1:Boolean, param2:Boolean = false):void
         {
            showCityLoadScreen(param1,param2);
            reveal();
         });
         TransitionSignals.endTransitionFromBTDToCity.add(this.hide);
      }
      
      private function resetFlags() : void
      {
         this._btdGameIsNowReady = false;
         this._trackAudioIsNowReady = false;
         this._progressAtReveal = 1;
         this.trackLoadProgress = 0;
      }
      
      private function onBTDGameReadySignal() : void
      {
         this._btdGameIsNowReady = true;
         this.checkForAllReady();
      }
      
      private function onAudioTrackLoadComplete() : void
      {
         this._trackAudioIsNowReady = true;
         this.checkForAllReady();
      }
      
      private function checkForAllReady() : void
      {
         if(this._btdGameIsNowReady && this._trackAudioIsNowReady)
         {
            this.resetFlags();
            this.hide();
         }
      }
      
      private function onResizeHandler(param1:Event = null) : void
      {
         this._clipLoadingBTD.x = int(_system.flashStage.stageWidth * 0.5);
         this._clipLoadingBTD.scaleX = this._clipLoadingBTD.scaleY = _system.flashStage.stageHeight / this._viewArea.height;
         this._clipLoadingCityWin.x = int(_system.flashStage.stageWidth * 0.5);
         this._clipLoadingCityWin.scaleX = this._clipLoadingCityWin.scaleY = _system.flashStage.stageHeight / this._viewArea.height;
         this._clipLoadingCityLose.x = int(_system.flashStage.stageWidth * 0.5);
         this._clipLoadingCityLose.scaleX = this._clipLoadingCityLose.scaleY = _system.flashStage.stageHeight / this._viewArea.height;
         this._clipLoadingContestWin.x = int(_system.flashStage.stageWidth * 0.5);
         this._clipLoadingContestWin.scaleX = this._clipLoadingContestWin.scaleY = _system.flashStage.stageHeight / this._viewArea.height;
         this._clipLoadingContestLose.x = int(_system.flashStage.stageWidth * 0.5);
         this._clipLoadingContestLose.scaleX = this._clipLoadingContestLose.scaleY = _system.flashStage.stageHeight / this._viewArea.height;
         this._clipLoadingContest.x = int(_system.flashStage.stageWidth * 0.5);
         this._clipLoadingContest.scaleX = this._clipLoadingContest.scaleY = _system.flashStage.stageHeight / this._viewArea.height;
      }
      
      private function onOpenAnimationComplete(param1:Event) : void
      {
         TransitionSignals.closeCurtainCompleteSignal.dispatch();
      }
      
      private function onCloseAnimationComplete(param1:Event) : void
      {
         super.hide(0);
         TransitionSignals.raiseCurtainCompleteSignal.dispatch();
         this.sleep();
      }
      
      override public function reveal(param1:Number = 0) : void
      {
         if(parent)
         {
            parent.addChild(this);
         }
         this.wake();
         this.setProgressGraphic(0);
         super.reveal(0);
         this.DisplayListUtil.setPlayStateOfAllChildMovieClips(this._currentClip,true,true,true);
         this._clipLoadingBTD.gotoAndPlay(1);
      }
      
      override public function hide(param1:Number = 0) : void
      {
         this._currentClip.gotoAndPlay("out");
         removeEventListener(Event.ENTER_FRAME,this.update);
      }
      
      private function sleep() : void
      {
         this.DisplayListUtil.setPlayStateOfAllChildMovieClips(this._clipLoadingBTD,false,true,true);
         this.DisplayListUtil.setPlayStateOfAllChildMovieClips(this._clipLoadingCityWin,false,true,true);
         this.DisplayListUtil.setPlayStateOfAllChildMovieClips(this._clipLoadingCityLose,false,true,true);
         this.DisplayListUtil.setPlayStateOfAllChildMovieClips(this._clipLoadingContestWin,false,true,true);
         this.DisplayListUtil.setPlayStateOfAllChildMovieClips(this._clipLoadingContestLose,false,true,true);
      }
      
      private function wake() : void
      {
         this.DisplayListUtil.setPlayStateOfAllChildMovieClips(this._currentClip,true,true,true);
      }
      
      override protected function onGlobalResetSignal() : void
      {
      }
   }
}
