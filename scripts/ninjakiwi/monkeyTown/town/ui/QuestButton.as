package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.QuestButtonClip;
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class QuestButton extends ButtonControllerBase
   {
       
      
      private var _quest:Quest;
      
      private var _symbol:MovieClip;
      
      private const STATE_NONE:int = 0;
      
      private const STATE_NORMAL:int = 1;
      
      private const STATE_POP:int = 2;
      
      private var _currentState:int = 0;
      
      private const COLOUR_NORMAL:int = 2;
      
      private const COLOUR_DARK:int = 1;
      
      private const COLOUR_HIGHTLIGHT:int = 3;
      
      private const COLOUR_NEW:int = 3;
      
      private const SET_INITIAL_ANIMATION:Boolean = true;
      
      private const OUT_X:Number = -60;
      
      private const NORMAL_X:Number = 0;
      
      private const POP_X:Number = 28;
      
      private var _checked:Boolean = true;
      
      public var selected:Boolean = false;
      
      public var enable:Boolean = true;
      
      private var _endCallback:Function = null;
      
      public function QuestButton(param1:QuestButtonClip)
      {
         super(param1);
         this._symbol = param1.questSymbol;
         lock(this.COLOUR_DARK);
         if(_target != null)
         {
            _target.x = this.OUT_X;
         }
      }
      
      public function hasQuest(param1:Quest) : Boolean
      {
         if(param1 == this._quest)
         {
            return true;
         }
         return false;
      }
      
      public function set quest(param1:Quest) : void
      {
         this._quest = param1;
         if(this._symbol != null)
         {
            this._symbol.gotoAndStop(this._quest.symbolFrame);
         }
         this._checked = false;
         this.selected = false;
      }
      
      public function get quest() : Quest
      {
         return this._quest;
      }
      
      public function isEmpty() : Boolean
      {
         if(this._quest == null)
         {
            return true;
         }
         return false;
      }
      
      private function initAnimation() : Boolean
      {
         if(_target != null)
         {
            TweenLite.killTweensOf(_target,true);
            return true;
         }
         return false;
      }
      
      public function reveal(param1:Boolean = false) : void
      {
         var isDefaultCall:Boolean = param1;
         if(this.initAnimation())
         {
            if(this.SET_INITIAL_ANIMATION)
            {
               _target.x = this.OUT_X;
            }
            if(isDefaultCall)
            {
               this._checked = true;
            }
            TweenLite.to(_target,0.2,{"x":this.POP_X});
            TweenLite.delayedCall(0.2,function():void
            {
               backToNormalAnimation();
            });
         }
      }
      
      public function hide(param1:Function = null) : void
      {
         this._endCallback = param1;
         if(this.initAnimation())
         {
            if(this.SET_INITIAL_ANIMATION)
            {
               _target.x = this.NORMAL_X;
            }
            TweenLite.to(_target,0.2,{"x":this.OUT_X});
            TweenLite.delayedCall(0.2,this.onHideComplete);
         }
         this._currentState = this.STATE_NONE;
      }
      
      private function onHideComplete() : void
      {
         if(this._endCallback != null)
         {
            this._endCallback(this);
         }
         this._endCallback = null;
      }
      
      override protected function lockedMouseOverHandler(param1:MouseEvent = null) : void
      {
         if(this.selected)
         {
            return;
         }
         super.lockedMouseOverHandler(param1);
         if(this.initAnimation())
         {
            TweenLite.to(_target,0.1,{"x":this.POP_X});
         }
      }
      
      override protected function lockedMouseOutHandler(param1:MouseEvent = null) : void
      {
         if(this.selected)
         {
            return;
         }
         super.lockedMouseOutHandler(param1);
         this.backToNormalAnimation();
      }
      
      protected function backToNormalAnimation() : void
      {
         if(this.initAnimation())
         {
            if(!this._checked)
            {
               lock(this.COLOUR_NEW);
            }
            else
            {
               lock(this.COLOUR_DARK);
               TweenLite.to(_target,0.1,{"x":this.NORMAL_X});
            }
         }
      }
      
      public function checked() : void
      {
         this._checked = true;
      }
      
      override protected function lockedMouseClickHandler(param1:MouseEvent = null) : void
      {
         if(!this.enable)
         {
            return;
         }
         if(QuestsUI.CLICK_FOR_VIEW_DETAIL)
         {
            this.selected = true;
            this._checked = true;
            if(this.initAnimation())
            {
               lock(this.COLOUR_NORMAL);
               _target.x = this.POP_X;
            }
         }
         super.lockedMouseClickHandler(param1);
      }
      
      public function cancelSelect() : void
      {
         this.backToNormalAnimation();
         this.selected = false;
      }
      
      public function highlight() : void
      {
         if(this._quest != null)
         {
            if(this.initAnimation())
            {
               this.selected = true;
               if(!this._checked)
               {
                  lock(this.COLOUR_NEW);
               }
               else
               {
                  lock(this.COLOUR_NORMAL);
               }
               TweenLite.to(_target,0.05,{"x":this.POP_X});
            }
         }
      }
      
      public function finished(param1:Function = null) : void
      {
         this._quest = null;
         this.hide(param1);
      }
   }
}
