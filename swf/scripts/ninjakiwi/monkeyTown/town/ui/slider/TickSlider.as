package ninjakiwi.monkeyTown.town.ui.slider
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import org.osflash.signals.Signal;
   
   public class TickSlider extends Slider
   {
       
      
      private var _minIndex:int = 0;
      
      private var _maxIndex:int = 0;
      
      private var _positionList:Vector.<Number>;
      
      private var _currentIndex:int = 0;
      
      public const indexChanged:Signal = new Signal(int);
      
      public function TickSlider(param1:MovieClip, param2:MovieClip, param3:Vector.<Number>, param4:Stage, param5:String = "horizontal")
      {
         super(param1,param2,param4,param5);
         this._positionList = param3;
      }
      
      private function checkPosition(param1:int) : Boolean
      {
         if(this._positionList != null && this._positionList.length > param1)
         {
            return true;
         }
         return false;
      }
      
      public function setMinIndex(param1:int) : void
      {
         this._minIndex = param1;
         if(this.checkPosition(this._minIndex))
         {
            setMin(this.getProportion(this._positionList[this._minIndex]));
         }
      }
      
      public function setMaxIndex(param1:int) : void
      {
         this._maxIndex = param1;
         if(this.checkPosition(this._maxIndex))
         {
            setMax(this.getProportion(this._positionList[this._maxIndex]));
         }
      }
      
      private function getProportion(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         if(sliderMode == VERTICAL)
         {
            _loc2_ = (param1 - _sliderGuide.y) / _sliderGuide.height;
         }
         else
         {
            _loc2_ = (param1 - _sliderGuide.x) / _sliderGuide.width;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public function set currentIndex(param1:int) : void
      {
         var _loc2_:int = this._currentIndex;
         this._currentIndex = param1;
         if(this.checkPosition(this._currentIndex))
         {
            switch(sliderMode)
            {
               case VERTICAL:
                  setPosition((this._positionList[this._currentIndex] - _sliderGuide.y) / _sliderGuide.height);
                  break;
               default:
               case HORIZONTAL:
                  setPosition((this._positionList[this._currentIndex] - _sliderGuide.x) / _sliderGuide.width);
            }
            if(this._currentIndex != _loc2_)
            {
               this.indexChanged.dispatch(param1);
            }
         }
      }
      
      override protected function clampHandle() : void
      {
         super.clampHandle();
         if(this._currentIndex < this._minIndex)
         {
            this._currentIndex = this._minIndex;
         }
         else if(this._currentIndex > this._maxIndex)
         {
            this._currentIndex = this._maxIndex;
         }
      }
      
      public function get currentIndex() : int
      {
         return this._currentIndex;
      }
      
      override protected function updateHorizontalDrag(param1:MouseEvent) : void
      {
         this.updateDrag(_sliderGuide.parent.mouseX);
      }
      
      override protected function updateVerticalDrag(param1:MouseEvent) : void
      {
         this.updateDrag(_sliderGuide.parent.mouseY);
      }
      
      private function updateDrag(param1:Number) : void
      {
         var _loc2_:int = this.findClosestIndex(param1);
         if(_loc2_ != -1)
         {
            this.currentIndex = _loc2_;
         }
         this.clampHandle();
         if(_lock)
         {
            return;
         }
         dragUpdateSignal.dispatch();
      }
      
      private function findClosestIndex(param1:Number) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._positionList != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this._positionList.length)
            {
               if(param1 == this._positionList[_loc2_])
               {
                  return _loc2_;
               }
               if(param1 < this._positionList[_loc2_])
               {
                  _loc3_ = _loc2_ - 1;
                  if(_loc3_ >= 0)
                  {
                     if(param1 - this._positionList[_loc3_] < this._positionList[_loc2_] - param1)
                     {
                        return _loc3_;
                     }
                     return _loc2_;
                  }
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         return -1;
      }
   }
}
