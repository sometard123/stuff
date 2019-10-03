package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.NotEnoughBloonstonesPanelClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.DisplayObjectContainer;
   
   public class NotEnoughBloonstonesSidePanel
   {
       
      
      private var _clip:NotEnoughBloonstonesPanelClip;
      
      public function NotEnoughBloonstonesSidePanel(param1:DisplayObjectContainer)
      {
         this._clip = new NotEnoughBloonstonesPanelClip();
         super();
         param1.addChild(this._clip);
         this._clip.visible = false;
      }
      
      public function reveal() : void
      {
         var fadeTime:Number = NaN;
         if(this._clip.visible)
         {
            return;
         }
         this._clip.visible = true;
         this._clip.alpha = 0;
         fadeTime = 0.2;
         TweenLite.to(this._clip,fadeTime,{
            "alpha":1,
            "ease":Cubic.easeIn
         });
         TweenLite.delayedCall(2,function():void
         {
            TweenLite.to(_clip,fadeTime,{
               "alpha":0,
               "ease":Cubic.easeOut
            });
            TweenLite.delayedCall(fadeTime,function():void
            {
               _clip.visible = false;
            });
         });
      }
   }
}
