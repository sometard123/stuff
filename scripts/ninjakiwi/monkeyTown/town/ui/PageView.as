package ninjakiwi.monkeyTown.town.ui
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class PageView
   {
       
      
      private var _container:DisplayObjectContainer;
      
      protected var _countPerPage:int = 9;
      
      private var _rowCount:int = 3;
      
      private var _columnCount:int = 3;
      
      protected var _totalPages:int = 0;
      
      private var _prevButton:ButtonControllerBase;
      
      private var _nextButton:ButtonControllerBase;
      
      protected const _contents:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      protected var _pageIndex:int = 0;
      
      private var _page:DisplayObjectContainer;
      
      private var _contentWidth:int = 100;
      
      private var _contentHeight:int = 50;
      
      private var _widthInGrid:int = 100;
      
      private var _heightInGrid:int = 50;
      
      private var _paddingX:int = 10;
      
      private var _paddingY:int = 10;
      
      public function PageView(param1:DisplayObjectContainer, param2:MovieClip, param3:MovieClip)
      {
         super();
         this._container = param1;
         this._prevButton = new ButtonControllerBase(param2);
         this._prevButton.setClickFunction(this.prevClicked);
         this._nextButton = new ButtonControllerBase(param3);
         this._nextButton.setClickFunction(this.nextClicked);
      }
      
      public function destroy() : void
      {
         this._container = null;
         this._prevButton.destroy();
         this._prevButton = null;
         this._nextButton.destroy();
         this._nextButton = null;
         this._contents.length = 0;
      }
      
      public function initPages(param1:int = 100, param2:int = 50, param3:int = 3, param4:int = 3, param5:int = 10, param6:int = 10) : void
      {
         if(param4 < 0 || param3 < 0)
         {
            param4 = 1;
            param3 = 1;
         }
         this._rowCount = param4;
         this._columnCount = param3;
         this._countPerPage = this._rowCount * this._columnCount;
         this._contentWidth = param1;
         this._contentHeight = param2;
         this._paddingX = param5;
         this._paddingY = param6;
         this._widthInGrid = this._contentWidth + this._paddingX;
         this._heightInGrid = this._contentHeight + this._paddingY;
      }
      
      public function refreshPages() : void
      {
         this.setToPage(this._pageIndex);
      }
      
      private function checkValidity() : void
      {
         this._prevButton.lock(3);
         this._nextButton.lock(3);
         if(this._pageIndex > 0)
         {
            this._prevButton.unlock();
         }
         if(this._totalPages > 0 && this._pageIndex < this._totalPages - 1)
         {
            this._nextButton.unlock();
         }
      }
      
      private function prevClicked() : void
      {
         this.setToPage(--this._pageIndex);
      }
      
      private function nextClicked() : void
      {
         this.setToPage(++this._pageIndex);
      }
      
      private function setToPage(param1:int) : void
      {
         if(param1 >= this._totalPages)
         {
            param1 = this._totalPages - 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._pageIndex = param1;
         if(this._page != null && this._container.contains(this._page))
         {
            this._container.removeChild(this._page);
         }
         this._page = new Sprite();
         this.displayContents(this._page);
         this._container.addChild(this._page);
         this.checkValidity();
      }
      
      protected function displayContents(param1:DisplayObjectContainer) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = this._pageIndex * this._countPerPage;
         var _loc4_:int = 0;
         while(_loc4_ < this._countPerPage)
         {
            _loc3_ = _loc4_ + _loc2_;
            if(_loc3_ < this._contents.length)
            {
               _loc5_ = _loc4_ / this._columnCount;
               _loc6_ = _loc4_ % this._rowCount;
               if(this._contents[_loc3_] != null)
               {
                  this._contents[_loc3_].x = this._widthInGrid * _loc6_;
                  this._contents[_loc3_].y = this._heightInGrid * _loc5_;
                  param1.addChild(this._contents[_loc3_]);
               }
            }
            _loc4_++;
         }
      }
      
      public function addContent(param1:DisplayObject, param2:Boolean = true) : void
      {
         this._contents.push(param1);
         if(this._countPerPage == 0)
         {
            this._totalPages = 0;
         }
         else
         {
            this._totalPages = (this._contents.length - 1) / this._countPerPage + 1;
         }
         if(param2)
         {
            this.refreshPages();
         }
      }
   }
}
