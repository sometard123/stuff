package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import org.osflash.signals.Signal;
   
   public class WildcardStack extends Sprite
   {
       
      
      private var _mkPanel:MonkeyKnowledgePanel;
      
      private var _cardContainer:Sprite;
      
      private var _cardViews:Vector.<WildCardFront>;
      
      private var _cardHomePosition:Point;
      
      private var _cardVisiblePosition:Point;
      
      private var _cardHiddenPosition:Point;
      
      private var _currentCard:WildCardFront;
      
      public const dragCardAssignStartSignal:Signal = new Signal();
      
      public const updateDragCardAssignSignal:Signal = new Signal(Point);
      
      public const startDragCardSignal:Signal = new Signal(WildCardFront);
      
      public const dropCardSignal:Signal = new Signal(Point,MonkeyKnowledgeToken,Function);
      
      private var _hasVisibleCards:Boolean = false;
      
      private var _dragOffset:Point;
      
      private var _stage:Stage;
      
      private var _mousePos:Point;
      
      public function WildcardStack(param1:MonkeyKnowledgePanel)
      {
         this._cardContainer = new Sprite();
         this._cardViews = new Vector.<WildCardFront>();
         this._cardHomePosition = new Point(70,15);
         this._cardVisiblePosition = new Point(70,-80);
         this._cardHiddenPosition = new Point(70,100);
         this._dragOffset = new Point();
         this._mousePos = new Point();
         super();
         this._mkPanel = param1;
         this.init();
      }
      
      private function init() : void
      {
         addChild(this._cardContainer);
         this.useHandCursor = true;
         this.addHoverMouseEvents();
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.startDragCard();
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         this.returnCardToHome();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         TweenLite.to(this._currentCard,0.3,{
            "x":this._cardVisiblePosition.x,
            "y":this._cardVisiblePosition.y,
            "ease":Cubic.easeOut
         });
      }
      
      private function startDragCard() : void
      {
         this.dragCardAssignStartSignal.dispatch();
         this._stage = MonkeySystem.getInstance().flashStage;
         this._dragOffset.x = this._currentCard.mouseX;
         this._dragOffset.y = this._currentCard.mouseY;
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragMouseMove);
         this._stage.addEventListener(MouseEvent.MOUSE_UP,this.onDrop);
         this.removeHoverMouseEvents();
      }
      
      private function onDragMouseMove(param1:MouseEvent) : void
      {
         this._mousePos.x = mouseX;
         this._mousePos.y = mouseY;
         this.updateDragCardAssignSignal.dispatch(this._mousePos);
         this._currentCard.x = mouseX - this._dragOffset.x;
         this._currentCard.y = mouseY - this._dragOffset.y;
      }
      
      private function onDrop(param1:MouseEvent) : void
      {
         this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragMouseMove);
         this._stage.removeEventListener(MouseEvent.MOUSE_UP,this.onDrop);
         this.dropCardSignal.dispatch(this._mousePos,this._currentCard.token,this.onDropOnBookCallback);
         this._mousePos.x = -1000;
         this._mousePos.y = -1000;
      }
      
      private function onDropOnBookCallback(param1:Boolean) : void
      {
         if(param1)
         {
            MonkeyKnowledgeTree.getInstance().consumeWildcard(this._currentCard.token);
            this._currentCard.transmuteCard(this._mkPanel);
            this._cardContainer.removeChild(this._currentCard);
            this.sync();
         }
         else
         {
            this.returnCardToHome(0.6);
         }
         this.addHoverMouseEvents();
      }
      
      private function returnCardToHome(param1:Number = 0.3) : void
      {
         TweenLite.to(this._currentCard,param1,{
            "x":this._cardHomePosition.x,
            "y":this._cardHomePosition.y,
            "ease":Cubic.easeOut
         });
      }
      
      private function addHoverMouseEvents() : void
      {
         this.addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
      
      private function removeHoverMouseEvents() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
      
      public function sync() : void
      {
         var _loc2_:WildCardFront = null;
         var _loc4_:MonkeyKnowledgeToken = null;
         var _loc1_:Array = MonkeyKnowledgeTree.getInstance().wildCards;
         this._hasVisibleCards = false;
         this._cardContainer.removeChildren();
         this._cardViews.length = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            if(false != MonkeyKnowledgeOpenPacksScreen.instance.isCardTransmuted(_loc4_))
            {
               _loc2_ = new WildCardFront(_loc4_);
               this._cardViews.push(_loc2_);
               _loc2_.x = this._cardHiddenPosition.x;
               _loc2_.y = this._cardHiddenPosition.y;
               this._hasVisibleCards = true;
            }
            _loc3_++;
         }
         if(_loc2_ !== null)
         {
            this._currentCard = _loc2_;
            this._cardContainer.addChild(_loc2_);
            this.returnCardToHome();
         }
      }
      
      public function get hasVisibleCards() : Boolean
      {
         return this._hasVisibleCards;
      }
   }
}
