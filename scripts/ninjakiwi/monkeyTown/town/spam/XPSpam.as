package ninjakiwi.monkeyTown.town.spam
{
   import assets.town.XPWord;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.utils.Flatten;
   
   public class XPSpam extends Sprite
   {
      
      public static const TWEEN_TIME:Number = 2;
      
      public static const TWEEN_HEIGHT:Number = 50;
       
      
      public function XPSpam(param1:int, param2:int, param3:int)
      {
         super();
         this.init(param1,param2,param3);
         this.animate();
      }
      
      private function init(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:XPWord = new XPWord();
         _loc4_.xpField.text = param1.toString() + "XP";
         _loc4_.xpField.width = _loc4_.xpField.textWidth + 20;
         addChild(_loc4_);
         Flatten.flatten(_loc4_);
         this.x = param2;
         this.y = param3;
         WorldView.addOverlayFlashItems(this);
      }
      
      private function animate() : void
      {
         var that:XPSpam = null;
         this.alpha = 0;
         that = this;
         TweenLite.to(this,TWEEN_TIME,{
            "y":y - TWEEN_HEIGHT,
            "ease":Cubic.easeOut,
            "onComplete":function():void
            {
               WorldView.removeOverlayFlashItem(that);
            }
         });
         var fadePortion:Number = 0.2;
         TweenLite.to(this,TWEEN_TIME * fadePortion,{"alpha":1});
         TweenLite.to(this,TWEEN_TIME * fadePortion,{
            "alpha":0,
            "delay":TWEEN_TIME - TWEEN_TIME * fadePortion
         });
      }
   }
}
