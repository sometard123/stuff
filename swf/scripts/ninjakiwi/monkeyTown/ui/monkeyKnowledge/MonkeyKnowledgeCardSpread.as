package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.EventsMenuPlaceholderIcon;
   import assets.ui.MonkeyKnowledgeCardLayout;
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.utils.widgets.Wafter;
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledgeCardSpread extends MovieClip
   {
      
      private static const CARDS_PER_DECK:int = 4;
      
      public static const cardSpreadAnimationCompleteSignal:Signal = new Signal();
      
      public static const allCardsTransmutedSignal:Signal = new Signal();
       
      
      private var _layout:MonkeyKnowledgeCardLayout;
      
      private var _wafter:Wafter;
      
      private var _waftRange:Number = 5;
      
      private var _layoutTargets:Array;
      
      private var _waftOffsets:Vector.<Point>;
      
      private var _cards:Vector.<MonkeyKnowledgeCard>;
      
      private var _pack:MonkeyKnowledgePack;
      
      public function MonkeyKnowledgeCardSpread(param1:MonkeyKnowledgePack)
      {
         this._layout = new MonkeyKnowledgeCardLayout();
         this._wafter = new Wafter();
         this._layoutTargets = [this._layout.card1,this._layout.card2,this._layout.card3,this._layout.card4];
         this._waftOffsets = new Vector.<Point>();
         this._cards = new Vector.<MonkeyKnowledgeCard>();
         super();
         this._pack = param1;
         this.init();
      }
      
      private function init() : void
      {
         var _loc2_:MonkeyKnowledgeCard = null;
         var _loc1_:int = 0;
         while(_loc1_ < CARDS_PER_DECK)
         {
            _loc2_ = new MonkeyKnowledgeCard(this._pack.tokens[_loc1_]);
            this._cards.push(_loc2_);
            this._waftOffsets.push(new Point(Math.random() * int.MAX_VALUE,Math.random() * int.MAX_VALUE));
            _loc1_++;
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function playSpreadAnimation() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._cards.length)
         {
            addChild(this._cards[_loc1_]);
            _loc1_++;
         }
         this._layout.gotoAndPlay(0);
         this.updateAnimation();
         this._layout.addEventListener(Event.COMPLETE,this.onAnimationComplete);
         addEventListener(Event.ENTER_FRAME,this.updateAnimation);
      }
      
      public function dissolveRemainingCards() : void
      {
         var _loc3_:MonkeyKnowledgeCard = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._cards.length)
         {
            _loc3_ = this._cards[_loc2_];
            if(!_loc3_.hasBeenTransmuted)
            {
               _loc3_.poof();
               _loc1_++;
            }
            _loc2_++;
         }
         if(_loc1_ > 0)
         {
            MCSound.getInstance().playSound(MCSound.KNOWLEDGE_CARD_POOF);
         }
         this._cards.length = 0;
      }
      
      public function destroyRemainingCards() : void
      {
         var _loc2_:MonkeyKnowledgeCard = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._cards.length)
         {
            _loc2_ = this._cards[_loc1_];
            _loc2_.isFlipped = true;
            _loc2_.hasBeenTransmuted = true;
            _loc2_.release();
            _loc1_++;
         }
         this._cards.length = 0;
      }
      
      public function isCardFlipped(param1:MonkeyKnowledgeToken) : Boolean
      {
         var _loc3_:MonkeyKnowledgeCard = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._cards.length)
         {
            _loc3_ = this._cards[_loc2_];
            if(_loc3_.token == param1)
            {
               return _loc3_.isFlipped;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function isCardTransmuted(param1:MonkeyKnowledgeToken) : Boolean
      {
         var _loc3_:MonkeyKnowledgeCard = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._cards.length)
         {
            _loc3_ = this._cards[_loc2_];
            if(_loc3_.token == param1)
            {
               return _loc3_.hasBeenTransmuted;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function updateAnimation(param1:Event = null) : void
      {
         var _loc3_:MonkeyKnowledgeCard = null;
         var _loc4_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._cards.length)
         {
            _loc3_ = this._cards[_loc2_];
            _loc4_ = this._layoutTargets[_loc2_];
            _loc3_.transform.matrix = _loc4_.transform.matrix;
            _loc2_++;
         }
      }
      
      private function onAnimationComplete(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.updateAnimation);
         addEventListener(Event.ENTER_FRAME,this.updateWaft);
         this._wafter.rangeX = 0;
         this._wafter.rangeY = 0;
         TweenLite.to(this._wafter,5,{
            "rangeX":this._waftRange,
            "rangeY":this._waftRange
         });
         cardSpreadAnimationCompleteSignal.dispatch();
      }
      
      private function updateWaft(param1:Event) : void
      {
         this._wafter.update();
         if(this._cards.length > CARDS_PER_DECK)
         {
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._cards.length)
         {
            if(false == this._cards[_loc2_].hasBeenTransmuted)
            {
               this._wafter.waftTarget(this._cards[_loc2_],this._waftOffsets[_loc2_],this._layoutTargets[_loc2_]);
            }
            _loc2_++;
         }
      }
   }
}
