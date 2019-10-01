package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.MonkeyKnowledgeInspector;
   import com.codecatalyst.promise.Deferred;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import com.ninjakiwi.gateway.nk.NKBarContainer;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledgePanel extends HideRevealView
   {
      
      public static const xpGoal:Point = new Point();
       
      
      private var _clip:MonkeyKnowledgeInspector;
      
      private var _contentContainer:Sprite;
      
      private var _contentArea:MovieClip;
      
      private var _boxes:Vector.<MonkeyKnowledgePathInfoBox>;
      
      private var _knowledgeTree:MonkeyKnowledgeTree;
      
      private var _buffData:MonkeyKnowledgeBuffData;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _leftArrow:ButtonControllerBase;
      
      private var _rightArrow:ButtonControllerBase;
      
      private var _pageWidth:int;
      
      private var _pageCount:int;
      
      private var _currentPage:int = 0;
      
      private const BOOKS_PER_GRID:int = 6;
      
      private const SCROLL_TIME:Number = 0.6;
      
      public const closeSignal:Signal = new Signal();
      
      public var _wildcardStack:WildcardStack;
      
      public function MonkeyKnowledgePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new MonkeyKnowledgeInspector();
         this._contentContainer = new Sprite();
         this._contentArea = this._clip.contentArea;
         this._boxes = new Vector.<MonkeyKnowledgePathInfoBox>();
         this._knowledgeTree = MonkeyKnowledgeTree.getInstance();
         this._buffData = MonkeyKnowledgeBuffData.getInstance();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._leftArrow = new ButtonControllerBase(this._clip.leftArrow);
         this._rightArrow = new ButtonControllerBase(this._clip.rightArrow);
         super(param1,param2);
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this.init();
      }
      
      private function init() : void
      {
         this._contentContainer.x = this._contentArea.x;
         this._contentContainer.y = this._contentArea.y;
         this._contentArea.visible = false;
         addChild(this._contentContainer);
         this._contentContainer.mask = this._clip.contentMask;
         this._closeButton.setClickFunction(function():void
         {
            closeSignal.dispatch();
            hide();
         });
         this._leftArrow.setClickFunction(this.rollLeft);
         this._rightArrow.setClickFunction(this.rollRight);
         MonkeyKnowledgePathInfoBox.clickedSignal.add(this.pathClicked);
         var stageHeight:int = 600;
         this._wildcardStack = new WildcardStack(this);
         this._wildcardStack.x = 0;
         this._wildcardStack.y = stageHeight;
         addChild(this._wildcardStack);
         this._wildcardStack.updateDragCardAssignSignal.add(this.updateDragWildCardAssign);
         this._wildcardStack.dropCardSignal.add(this.onWildCardAssignDropped);
         this._wildcardStack.dragCardAssignStartSignal.add(this.hideWildcardTip);
         this.build();
      }
      
      private function build() : void
      {
         var _loc5_:MonkeyKnowledgePath = null;
         var _loc6_:MonkeyKnowledgePathDefinition = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:MonkeyKnowledgePathInfoBox = null;
         var _loc1_:Vector.<MonkeyKnowledgePath> = this._knowledgeTree.allPaths;
         var _loc2_:int = 3;
         var _loc3_:int = 220;
         var _loc4_:int = 250;
         this._pageCount = Math.ceil(_loc1_.length / this.BOOKS_PER_GRID);
         this._pageWidth = _loc3_ * _loc2_;
         var _loc7_:Vector.<MonkeyKnowledgePath> = new Vector.<MonkeyKnowledgePath>();
         var _loc8_:int = 0;
         while(_loc8_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc8_];
            _loc6_ = this._buffData.getPathDefinition(_loc5_.id);
            if(_loc6_.displayOrder >= 0)
            {
               _loc7_.push(_loc5_);
            }
            _loc8_++;
         }
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         while(_loc10_ < this._pageCount)
         {
            _loc11_ = _loc10_ * this._pageWidth;
            _loc12_ = 0;
            while(_loc12_ < this.BOOKS_PER_GRID)
            {
               _loc5_ = _loc7_[_loc9_];
               _loc6_ = this._buffData.getPathDefinition(_loc5_.id);
               _loc13_ = new MonkeyKnowledgePathInfoBox(_loc6_,_loc5_);
               _loc13_.x = _loc12_ % _loc2_ * _loc3_ + _loc11_;
               _loc13_.y = Math.floor(_loc12_ / _loc2_) * _loc4_;
               this._contentContainer.addChild(_loc13_);
               this._boxes.push(_loc13_);
               _loc9_++;
               if(_loc9_ >= _loc7_.length)
               {
                  break;
               }
               _loc12_++;
            }
            _loc10_++;
         }
         this._contentContainer.mask = this._clip.contentMask;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         this.resetView();
         this.revealWithoutReset();
      }
      
      private function revealWithoutReset(... rest) : void
      {
         this.sync();
         super.reveal();
         this.hideWildcardTip(0);
         this.revealWildcardTipIfNeeded();
      }
      
      private function pathClicked(param1:MonkeyKnowledgePathInfoBox) : void
      {
         hide();
         TownUI.getInstance().monkeyKnowledgeInfoPanel.sync(param1.path);
         TownUI.getInstance().monkeyKnowledgeInfoPanel.reveal();
         TownUI.getInstance().monkeyKnowledgeInfoPanel.hideStartSignal.addOnce(this.revealWithoutReset);
      }
      
      public function sync() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._boxes.length)
         {
            this._boxes[_loc1_].syncToPath();
            _loc1_++;
         }
         this._wildcardStack.sync();
      }
      
      private function resetView() : void
      {
         this._contentContainer.x = this._contentArea.x;
         this._currentPage = 0;
      }
      
      private function rollRight() : void
      {
         if(this._currentPage === this._pageCount - 1)
         {
            return;
         }
         _loc1_._currentPage = _loc2_;
         TweenLite.to(this._contentContainer,this.SCROLL_TIME,{
            "x":-this._currentPage * this._pageWidth + this._contentArea.x,
            "ease":Cubic.easeOut
         });
      }
      
      private function rollLeft() : void
      {
         if(this._currentPage === 0)
         {
            return;
         }
         _loc1_._currentPage = _loc2_;
         TweenLite.to(this._contentContainer,this.SCROLL_TIME,{
            "x":-this._currentPage * this._pageWidth + this._contentArea.x,
            "ease":Cubic.easeOut
         });
      }
      
      private function updateDragWildCardAssign(param1:Point) : void
      {
         var _loc4_:MonkeyKnowledgePathInfoBox = null;
         var _loc5_:Rectangle = null;
         var _loc2_:int = this._currentPage * this.BOOKS_PER_GRID;
         var _loc3_:int = _loc2_ + this.BOOKS_PER_GRID;
         if(_loc3_ > this._boxes.length - 1)
         {
            _loc3_ = this._boxes.length;
         }
         var _loc6_:int = _loc2_;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = this._boxes[_loc6_];
            _loc5_ = _loc4_.getRect(this._wildcardStack);
            _loc4_.assignXPGlowVisible = _loc5_.containsPoint(param1) && _loc4_.path.rank < MonkeyKnowledge.MAX_RANK;
            _loc6_++;
         }
      }
      
      private function onWildCardAssignDropped(param1:Point, param2:MonkeyKnowledgeToken, param3:Function) : void
      {
         var _loc6_:MonkeyKnowledgePathInfoBox = null;
         var _loc7_:Rectangle = null;
         var _loc9_:String = null;
         var _loc4_:int = this._currentPage * this.BOOKS_PER_GRID;
         var _loc5_:int = _loc4_ + this.BOOKS_PER_GRID;
         if(_loc5_ > this._boxes.length)
         {
            _loc5_ = this._boxes.length;
         }
         var _loc8_:int = _loc4_;
         while(_loc8_ < _loc5_)
         {
            _loc6_ = this._boxes[_loc8_];
            _loc7_ = _loc6_.getRect(this._wildcardStack);
            if(_loc7_.containsPoint(param1) && _loc6_.path.rank < MonkeyKnowledge.MAX_RANK)
            {
               _loc9_ = _loc6_.path.id;
               MonkeyKnowledgeTree.getInstance().awardPoints(_loc9_,param2.points);
               _loc6_.assignXPGlowVisible = false;
               _loc6_.onCardTransmuted(param2,_loc9_);
               xpGoal.copyFrom(_loc6_.getXPDropTarget());
               xpGoal.x = xpGoal.x + this._contentContainer.x;
               xpGoal.y = xpGoal.y + this._contentContainer.y;
               this._contentContainer;
               param3(true);
               this.revealWildcardTipIfNeeded();
               return;
            }
            _loc8_++;
         }
         this.revealWildcardTipIfNeeded();
         param3(false);
      }
      
      private function revealWildcardTipIfNeeded() : void
      {
         if(this._wildcardStack.hasVisibleCards)
         {
            this.revealWildcardTip();
         }
         else
         {
            this.hideWildcardTip();
         }
      }
      
      private function revealWildcardTip(param1:Number = 0.5) : void
      {
         TweenLite.to(this._clip.wildcardMessage,param1,{"alpha":1});
      }
      
      private function hideWildcardTip(param1:Number = 0.5) : void
      {
         TweenLite.to(this._clip.wildcardMessage,param1,{"alpha":0});
      }
   }
}
