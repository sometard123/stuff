package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.QuestButtonClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class QuestsUIButtonManager
   {
      
      private static const MAX_QUESTS_ON_SCREEN:int = 5;
      
      private static const BUTTON_HEIGHT:int = 55;
      
      private static const CONTAINER_INITIAL_TOP_Y:int = 120;
       
      
      private var _container:Sprite;
      
      public var enable:Boolean = false;
      
      private var _nextPositionToAdd:int = 0;
      
      private var downButton:ButtonControllerBase;
      
      private var upButton:ButtonControllerBase;
      
      private var _questButtons:Vector.<QuestButton>;
      
      private var _topIndex:int = 0;
      
      public const buttonOverSignal:Signal = new Signal(QuestButton);
      
      public const buttonOutSignal:Signal = new Signal(QuestButton);
      
      public const buttonClickSignal:Signal = new Signal(QuestButton);
      
      public const buttonRefreshed:Signal = new Signal(QuestButton);
      
      private var _animationQueue:Vector.<QuestButton>;
      
      private const TERM:Number = 0.1;
      
      private var _pool:Vector.<QuestButtonClip>;
      
      private var _currentSelectedButton:QuestButton = null;
      
      public function QuestsUIButtonManager(param1:DisplayObjectContainer, param2:MovieClip, param3:MovieClip)
      {
         this._questButtons = new Vector.<QuestButton>();
         this._animationQueue = new Vector.<QuestButton>();
         this._pool = new Vector.<QuestButtonClip>();
         super();
         this._container = new Sprite();
         this._container.y = CONTAINER_INITIAL_TOP_Y;
         param1.addChild(this._container);
         this.downButton = new ButtonControllerBase(param3);
         this.upButton = new ButtonControllerBase(param2);
         this.downButton.setClickFunction(this.downClicked);
         this.upButton.setClickFunction(this.upClicked);
         param2.y = CONTAINER_INITIAL_TOP_Y - 10;
         param3.y = CONTAINER_INITIAL_TOP_Y + BUTTON_HEIGHT * MAX_QUESTS_ON_SCREEN + 10;
         var _loc4_:Sprite = new Sprite();
         _loc4_.graphics.beginFill(16777215);
         _loc4_.graphics.drawRect(0,CONTAINER_INITIAL_TOP_Y,100,BUTTON_HEIGHT * MAX_QUESTS_ON_SCREEN);
         _loc4_.graphics.endFill();
         param1.addChild(_loc4_);
         this._container.mask = _loc4_;
         var _loc5_:int = 0;
         while(_loc5_ < MAX_QUESTS_ON_SCREEN)
         {
            this._pool.push(new QuestButtonClip());
            _loc5_++;
         }
         this.refreshScrollStatus();
         GameSignals.TUTORIAL_ENABLE_BUTTONS.add(this.enableButtons);
         GameSignals.TUTORIAL_DISABLE_BASE_BUTTONS.add(this.disableButtons);
      }
      
      public function reset() : void
      {
         var _loc1_:Vector.<QuestButton> = null;
         var _loc2_:int = 0;
         if(this._questButtons != null)
         {
            _loc1_ = new Vector.<QuestButton>();
            _loc2_ = 0;
            while(_loc2_ < this._questButtons.length)
            {
               _loc1_.push(this._questButtons[_loc2_]);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               this.removeQuestButton(_loc1_[_loc2_]);
               _loc2_++;
            }
         }
         this._questButtons = new Vector.<QuestButton>();
      }
      
      private function enableButtons() : void
      {
         this.enable = true;
         this.setButtonsState(this.enable);
      }
      
      private function disableButtons() : void
      {
         this.enable = false;
         this.setButtonsState(this.enable);
      }
      
      private function setButtonsState(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._questButtons.length)
         {
            this._questButtons[_loc2_].enable = param1;
            _loc2_++;
         }
      }
      
      public function refreshButtons(param1:Boolean = false) : void
      {
         if(!this.enable)
         {
            return;
         }
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._animationQueue.length)
         {
            TweenLite.delayedCall(_loc2_,this._animationQueue[_loc3_].reveal,[param1]);
            _loc2_ = _loc2_ + this.TERM;
            _loc3_++;
         }
         this._animationQueue = new Vector.<QuestButton>();
         this.refreshScrollStatus();
      }
      
      public function cancelButtons() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._questButtons.length)
         {
            this._questButtons[_loc1_].checked();
            this._questButtons[_loc1_].cancelSelect();
            _loc1_++;
         }
      }
      
      public function highlightButton(param1:QuestButton) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Number = this._container.y;
         if(param1 != null)
         {
            param1.highlight();
            _loc3_ = this._questButtons.indexOf(param1);
            if(_loc3_ != -1)
            {
               if(!(_loc3_ >= this._topIndex && _loc3_ < this._topIndex + MAX_QUESTS_ON_SCREEN))
               {
                  _loc4_ = _loc3_ - MAX_QUESTS_ON_SCREEN + 1;
                  _loc2_ = this.moveToTheTop(_loc4_);
               }
            }
            _loc2_ = _loc2_ + param1.target.y;
         }
         return _loc2_;
      }
      
      private function refreshScrollStatus() : void
      {
         this.upButton.target.visible = false;
         this.downButton.target.visible = false;
         if(this._topIndex > 0)
         {
            this.upButton.target.visible = true;
         }
         if(this._topIndex < this._questButtons.length - MAX_QUESTS_ON_SCREEN)
         {
            this.downButton.target.visible = true;
         }
      }
      
      private function downClicked() : void
      {
         this.moveToTheTop(this._topIndex + 1);
      }
      
      private function upClicked() : void
      {
         this.moveToTheTop(this._topIndex - 1);
      }
      
      private function moveToTheTop(param1:int) : Number
      {
         var _loc2_:int = param1;
         var _loc3_:int = this._questButtons.length - 1;
         if(param1 + MAX_QUESTS_ON_SCREEN > _loc3_)
         {
            _loc2_ = _loc3_ - MAX_QUESTS_ON_SCREEN + 1;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         var _loc4_:Number = CONTAINER_INITIAL_TOP_Y - _loc2_ * BUTTON_HEIGHT;
         TweenLite.to(this._container,this.TERM,{
            "y":_loc4_,
            "ease":Quad.easeOut,
            "onComplete":this.refreshPosition
         });
         this._topIndex = _loc2_;
         this.refreshScrollStatus();
         return _loc4_;
      }
      
      private function refreshPosition() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._questButtons.length)
         {
            if(this._questButtons[_loc1_].selected)
            {
               this.buttonRefreshed.dispatch(this._questButtons[_loc1_]);
               break;
            }
            _loc1_++;
         }
      }
      
      private function getQuestButtonClip() : QuestButtonClip
      {
         if(this._pool.length > 0)
         {
            return this._pool.pop();
         }
         return new QuestButtonClip();
      }
      
      private function recycleQuestButtonCilp(param1:QuestButtonClip) : void
      {
         this._pool.push(param1);
      }
      
      public function addQuestButton(param1:Quest) : void
      {
         var _loc2_:QuestButton = null;
         _loc2_ = new QuestButton(this.getQuestButtonClip());
         _loc2_.quest = param1;
         if(!QuestsUI.CLICK_FOR_VIEW_DETAIL)
         {
            _loc2_.setLockedOverFunction(this.onOverButton,false,true);
            _loc2_.setLockedOutFunction(this.onOutButton,false,true);
         }
         else
         {
            _loc2_.setLockedClickFunction(this.onClickButton,false,true);
         }
         this._questButtons.push(_loc2_);
         this._animationQueue.push(_loc2_);
         _loc2_.target.y = this._nextPositionToAdd;
         this._nextPositionToAdd = this._nextPositionToAdd + BUTTON_HEIGHT;
         this._container.addChild(_loc2_.target);
      }
      
      public function hideQuestButtonAndRemove(param1:QuestButton) : void
      {
         if(param1 != null)
         {
            param1.finished(this.onButtonHide);
         }
      }
      
      private function onButtonHide(param1:QuestButton) : void
      {
         this.removeQuestButton(param1);
      }
      
      private function removeQuestButton(param1:QuestButton) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            if(this._container.contains(param1.target))
            {
               this._container.removeChild(param1.target);
            }
            this.recycleQuestButtonCilp(param1.target as QuestButtonClip);
            _loc2_ = this._questButtons.indexOf(param1);
            if(_loc2_ != -1)
            {
               _loc3_ = _loc2_ + 1;
               while(_loc3_ < this._questButtons.length)
               {
                  TweenLite.to(this._questButtons[_loc3_].target,this.TERM,{
                     "y":(_loc3_ - 1) * BUTTON_HEIGHT,
                     "ease":Quad.easeOut
                  });
                  _loc3_++;
               }
               this._questButtons.splice(_loc2_,1);
            }
            this._nextPositionToAdd = this._nextPositionToAdd - BUTTON_HEIGHT;
            this.moveToTheTop(this._topIndex);
         }
         param1.destroy();
      }
      
      private function onOverButton(param1:QuestButton) : void
      {
         this.buttonOverSignal.dispatch(param1);
      }
      
      private function onOutButton(param1:QuestButton) : void
      {
         this.buttonOutSignal.dispatch(param1);
      }
      
      private function onClickButton(param1:QuestButton) : void
      {
         this.hideCurrentSelectedButton();
         this._currentSelectedButton = param1;
         this.buttonClickSignal.dispatch(param1);
      }
      
      public function hideCurrentSelectedButton() : void
      {
         if(this._currentSelectedButton != null)
         {
            this._currentSelectedButton.cancelSelect();
            this._currentSelectedButton = null;
         }
      }
      
      public function findQuestButton(param1:Quest) : QuestButton
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._questButtons.length)
         {
            if(this._questButtons[_loc2_].hasQuest(param1))
            {
               return this._questButtons[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getYPositionAtParentContainer(param1:QuestButton) : int
      {
         return this._container.y + param1.target.y;
      }
   }
}
