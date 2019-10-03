package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.TracksAndMissionsInfoBox;
   import assets.town.TracksAndMissionsPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.ui.HideRevealViewBottomUIPanel;
   import ninjakiwi.monkeyTown.ui.ScrollBar;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class SpecialTracksPanel extends HideRevealViewBottomUIPanel
   {
       
      
      private var _clip:TracksAndMissionsPanelClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _scrollBar:ScrollBar;
      
      private var _contentContainer:Sprite;
      
      private var _contentArea:MovieClip;
      
      private const PADDING:int = 15;
      
      public function SpecialTracksPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new TracksAndMissionsPanelClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._contentContainer = new Sprite();
         this._contentArea = this._clip.contentArea;
         super(param1,param2);
         isModal = true;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._closeButton.setClickFunction(hide);
         this._clip.addChild(this._contentContainer);
         this._contentContainer.x = this._clip.contentArea.x + this.PADDING;
         this._contentContainer.y = this._clip.contentArea.y + this.PADDING;
         this._scrollBar = new ScrollBar(this._clip.scrollbar,this._contentContainer,this._contentArea,true,Constants.MOUSE_WHEEL_SCROLL_SPEED);
      }
      
      public function build() : void
      {
         var _loc1_:TracksAndMissionsInfoBox = null;
         _loc1_ = new TracksAndMissionsInfoBox();
      }
   }
}
