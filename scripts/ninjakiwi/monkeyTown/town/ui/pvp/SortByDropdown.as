package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.PvPSortByContentPane;
   import assets.ui.SortByDropdownClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.FriendCrateInfoBox;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class SortByDropdown
   {
      
      public static const SORT_BY_NAME:String = "Name";
      
      public static const SORT_BY_LEVEL:String = "Level";
      
      public static const SORT_BY_BEST_MATCH:String = "Match";
      
      public static const SORT_BY_CLAN:String = "Clan";
       
      
      private var _clip:SortByDropdownClip;
      
      private var _dropDownButton:ButtonControllerBase;
      
      private var _levelButton:ButtonControllerBase;
      
      private var _clanButton:ButtonControllerBase;
      
      private var _nameButton:ButtonControllerBase;
      
      private var _matchButton:ButtonControllerBase;
      
      private var _content:PvPSortByContentPane;
      
      private var _mask:MovieClip;
      
      private var _maskInitialY:Number;
      
      private var _hoverHightlight:MovieClip;
      
      private var _hoverHighlightLocked:Boolean = false;
      
      private var _selectedField:TextField;
      
      private var _currentSortBy:String = "Name";
      
      public const sortBySignal:Signal = new Signal(String);
      
      public function SortByDropdown(param1:SortByDropdownClip)
      {
         super();
         this._clip = param1;
         this.setup();
      }
      
      public function destroy() : void
      {
         this._clip.removeEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         this._clip.removeEventListener(MouseEvent.ROLL_OUT,this.onRollout);
         this._clip = null;
         this._mask = null;
         this._content.mask = null;
         this._content = null;
         this._hoverHightlight = null;
         this._selectedField = null;
         this._dropDownButton.destroy();
         this._dropDownButton = null;
         this.destroyButton(this._levelButton);
         this.destroyButton(this._clanButton);
         this.destroyButton(this._nameButton);
         this.destroyButton(this._matchButton);
      }
      
      private function setup() : void
      {
         this._mask = this._clip.contentMask;
         this._maskInitialY = this._mask.y;
         this._content = this._clip.content;
         this._hoverHightlight = this._content.hoverHighlight;
         this._selectedField = this._clip.selectedField;
         this._dropDownButton = new ButtonControllerBase(this._clip.dropdownButton);
         this._dropDownButton.lock(1);
         this._nameButton = new ButtonControllerBase(this._content.nameButton);
         this._clanButton = new ButtonControllerBase(this._content.clanButton);
         this._content.mask = this._mask;
         this._clip.addEventListener(MouseEvent.ROLL_OVER,this.onRollover,false,0,true);
         this._clip.addEventListener(MouseEvent.ROLL_OUT,this.onRollout,false,0,true);
         this.initButton(this._nameButton,{"sortBy":SORT_BY_NAME});
         this.initButton(this._clanButton,{"sortBy":SORT_BY_CLAN});
         this.hideContent(0);
      }
      
      private function onButtonClicked(param1:ButtonControllerBase) : void
      {
         if(this._currentSortBy === param1.data.sortBy)
         {
            return;
         }
         this._currentSortBy = param1.data.sortBy;
         this._selectedField.text = this._currentSortBy;
         this.sortBySignal.dispatch(this._currentSortBy);
      }
      
      private function initButton(param1:ButtonControllerBase, param2:Object) : void
      {
         param1.target.addEventListener(MouseEvent.ROLL_OVER,this.hoverButtonRollover,false,0,true);
         param1.setClickFunction(this.onButtonClicked,false,true);
         param1.data = param2;
      }
      
      private function destroyButton(param1:ButtonControllerBase) : void
      {
         param1.target.removeEventListener(MouseEvent.ROLL_OVER,this.hoverButtonRollover);
         param1.destroy();
      }
      
      private function hoverButtonRollover(param1:MouseEvent) : void
      {
         TweenLite.to(this._hoverHightlight,0.2,{
            "y":param1.currentTarget.y + 2,
            "alpha":1
         });
      }
      
      private function onRollover(param1:MouseEvent) : void
      {
         this.showContent();
         this._dropDownButton.lock(2);
      }
      
      private function onRollout(param1:MouseEvent) : void
      {
         this.hideContent();
         this._dropDownButton.lock(1);
      }
      
      private function showContent(param1:Number = 0.3) : void
      {
         TweenLite.to(this._mask,param1,{
            "y":0,
            "ease":Cubic.easeOut
         });
      }
      
      private function hideContent(param1:Number = 0.3) : void
      {
         TweenLite.to(this._mask,param1,{
            "y":this._maskInitialY,
            "ease":Cubic.easeOut
         });
         this.hideHoverHighlight();
      }
      
      private function lockHoverHighlight() : void
      {
         this._hoverHighlightLocked = true;
      }
      
      private function hideHoverHighlight(param1:Number = 0.3) : void
      {
         TweenLite.to(this._hoverHightlight,0.2,{"alpha":0});
      }
   }
}
