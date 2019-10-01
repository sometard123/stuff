package com.ninjakiwi.gateway.nk
{
   import com.ninjakiwi.nkBar.assets.NKBar_Loader;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.osflash.signals.Signal;
   
   public class NKBarContainer extends Sprite
   {
       
      
      public const retrySignal:Signal = new Signal();
      
      private const indicator:NKBar_Loader = new NKBar_Loader();
      
      public function NKBarContainer()
      {
         super();
         addChild(this.indicator);
         this.indicator.failed_mc.tryAgain_mc.buttonMode = true;
         this.indicator.failed_mc.tryAgain_mc.addEventListener(MouseEvent.CLICK,function tryAgain(param1:MouseEvent):void
         {
            retrySignal.dispatch();
         });
      }
      
      function showStatus(param1:String) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc2_:int = 0;
         while(_loc2_ < this.indicator.numChildren)
         {
            _loc3_ = this.indicator.getChildAt(_loc2_);
            _loc4_ = _loc3_.name.indexOf("_mc") == -1;
            _loc5_ = _loc3_.name.indexOf(param1) == 0;
            _loc3_.visible = _loc4_ || _loc5_;
            _loc2_++;
         }
      }
      
      function showErrorMessage(param1:String) : void
      {
         this.indicator.failed_mc.message_txt.text = param1;
      }
   }
}
