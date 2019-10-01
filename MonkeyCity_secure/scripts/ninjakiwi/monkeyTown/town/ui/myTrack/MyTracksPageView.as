package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import assets.ui.NotificationNumber;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.townMap.TrackManager;
   import ninjakiwi.monkeyTown.town.ui.PageView;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MyTracksPageView extends PageView
   {
       
      
      private var _pageNumber:TextField;
      
      private var _unlockedNumber:TextField;
      
      private var _prevNewUnlocked:NotificationNumber;
      
      private var _nextNewUnlocked:NotificationNumber;
      
      public function MyTracksPageView(param1:DisplayObjectContainer, param2:MovieClip, param3:MovieClip, param4:TextField, param5:TextField, param6:NotificationNumber, param7:NotificationNumber)
      {
         super(param1,param2,param3);
         var _loc8_:Vector.<TrackData> = TrackManager.getInstance().tracks;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_.length)
         {
            addContent(null,false);
            _loc9_++;
         }
         this._pageNumber = param4;
         this._unlockedNumber = param5;
         this._prevNewUnlocked = param6;
         this._nextNewUnlocked = param7;
         this._prevNewUnlocked.gotoAndStop(2);
         this._nextNewUnlocked.gotoAndStop(2);
         this._unlockedNumber.text = TrackManager.getInstance().totalUnlocked + " / " + _loc8_.length;
         MyTrackThumbNailClip.trackSelected.add(this.onTrackSelect);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         MyTrackThumbNailClip.trackSelected.remove(this.onTrackSelect);
         this.clearPrevPage();
      }
      
      override public function initPages(param1:int = 160, param2:int = 120, param3:int = 3, param4:int = 3, param5:int = 23, param6:int = 10) : void
      {
         super.initPages(param1,param2,param3,param4,param5,param6);
      }
      
      private function clearPrevPage() : void
      {
         var _loc1_:MyTrackThumbNailClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < _contents.length)
         {
            if(_contents[_loc2_] != null)
            {
               if(_contents[_loc2_] is MyTrackThumbNailClip)
               {
                  _loc1_ = _contents[_loc2_] as MyTrackThumbNailClip;
                  MyTrackThumbNailClip.recycleThumbNail(_loc1_);
                  _contents[_loc2_] = null;
               }
            }
            _loc2_++;
         }
      }
      
      override protected function displayContents(param1:DisplayObjectContainer) : void
      {
         var _loc4_:int = 0;
         this.clearPrevPage();
         var _loc2_:int = _pageIndex * _countPerPage;
         var _loc3_:Vector.<TrackData> = TrackManager.getInstance().tracks;
         var _loc5_:int = 0;
         while(_loc5_ < _countPerPage)
         {
            _loc4_ = _loc5_ + _loc2_;
            if(_loc4_ < _contents.length && _loc4_ < _loc3_.length)
            {
               _contents[_loc4_] = MyTrackThumbNailClip.getThumbNail(_loc3_[_loc4_]);
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(_pageIndex <= 0)
         {
            this._prevNewUnlocked.visible = false;
         }
         else
         {
            this._prevNewUnlocked.visible = true;
            _loc6_ = _pageIndex * _countPerPage;
            _loc7_ = TrackManager.getInstance().getNewUnlockedTrackCount(0,_loc6_);
            if(_loc7_ <= 0)
            {
               this._prevNewUnlocked.visible = false;
            }
            else
            {
               this._prevNewUnlocked.numberField.text = String(_loc7_);
            }
         }
         if(_pageIndex >= _totalPages - 1)
         {
            this._nextNewUnlocked.visible = false;
         }
         else
         {
            this._nextNewUnlocked.visible = true;
            _loc6_ = (_totalPages - _pageIndex - 1) * _countPerPage;
            _loc7_ = TrackManager.getInstance().getNewUnlockedTrackCount((_pageIndex + 1) * _countPerPage,_loc6_);
            if(_loc7_ <= 0)
            {
               this._nextNewUnlocked.visible = false;
            }
            else
            {
               this._nextNewUnlocked.numberField.text = String(_loc7_);
            }
         }
         super.displayContents(param1);
         this._pageNumber.text = _pageIndex + 1 + " / " + _totalPages;
      }
      
      private function onTrackSelect(param1:TrackData) : void
      {
         TownUI.getInstance().trackReplayPanel.setTrack(param1);
         PanelManager.getInstance().showPanel(TownUI.getInstance().trackReplayPanel);
      }
   }
}
