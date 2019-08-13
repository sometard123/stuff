package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import assets.town.MyTracksPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MyTracksPanel extends HideRevealViewBottomUIPanel
   {
       
      
      private var _clip:MyTracksPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _myTowerButton:ButtonControllerBase;
      
      private var _specialItemsButton:ButtonControllerBase;
      
      private var _pageContainer:DisplayObjectContainer;
      
      private var _pageView:MyTracksPageView;
      
      private var _viewIsActive:Boolean = false;
      
      public function MyTracksPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
      }
      
      private function initView() : void
      {
         if(this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = true;
         this._clip = new MyTracksPanelClip();
         this.addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this.isModal = true;
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._closeButton.setClickFunction(hide);
         this._myTowerButton = new ButtonControllerBase(this._clip.myMonkeyButton);
         this._myTowerButton.setClickFunction(this.myTowerClicked);
         this._specialItemsButton = new ButtonControllerBase(this._clip.specialItemsButton);
         this._specialItemsButton.setClickFunction(this.specialItemsClicked);
         this._pageContainer = new Sprite();
         this._clip.trackLayer.addChild(this._pageContainer);
         this._pageView = new MyTracksPageView(this._pageContainer,this._clip.prevButton,this._clip.nextButton,this._clip.page_Number,this._clip.stats_txt,this._clip.numberOfArchivesInPrevPage,this._clip.numberOfArchivesInNextPage);
         this._pageView.initPages();
         if(ResourceStore.getInstance().townLevel >= Constants.MIN_MYTRACK_LEVEL)
         {
            this._clip.unlockClip.visible = false;
         }
      }
      
      private function buildView() : void
      {
         this._pageView.refreshPages();
      }
      
      private function destroyView() : void
      {
         if(!this._viewIsActive)
         {
            return;
         }
         this._viewIsActive = false;
         this._closeButton.destroy();
         this._closeButton = null;
         this._myTowerButton.destroy();
         this._myTowerButton = null;
         if(this._pageContainer != null)
         {
            if(this._clip.trackLayer.contains(this._pageContainer))
            {
               this._clip.trackLayer.removeChild(this._pageContainer);
            }
         }
         this._pageView.destroy();
         this._pageView = null;
         if(this.contains(this._clip))
         {
            this.removeChild(this._clip);
         }
         this._clip = null;
      }
      
      private function myTowerClicked() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().myTowersPanel);
      }
      
      private function specialItemsClicked() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().specialItemsPanel);
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         this.initView();
         this.buildView();
         MCSound.getInstance().playSound(MCSound.OPEN_PANEL);
         super.reveal(param1);
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this.destroyView();
      }
   }
}
