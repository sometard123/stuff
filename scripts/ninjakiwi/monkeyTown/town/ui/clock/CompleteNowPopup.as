package ninjakiwi.monkeyTown.town.ui.clock
{
   import assets.ui.FinishNowToolTipClip;
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   
   public class CompleteNowPopup extends Sprite
   {
       
      
      private var _clip:FinishNowToolTipClip;
      
      private var _target:DisplayObject;
      
      public function CompleteNowPopup(param1:DisplayObject)
      {
         super();
         this._target = param1;
         this.init();
      }
      
      public function setCost(param1:int) : void
      {
         this._clip.bloonStoneFinishTxt.text = param1.toString();
      }
      
      protected function init() : void
      {
         this._clip = new FinishNowToolTipClip();
         this._clip.mouseEnabled = false;
         this._clip.mouseChildren = false;
         addChild(this._clip);
         this._clip.y = -17;
         this._clip.scaleX = this._clip.scaleY = 0;
         this._clip.visible = false;
         this._target.addEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         this._target.addEventListener(MouseEvent.ROLL_OUT,this.onRollout);
      }
      
      protected function onRollover(param1:MouseEvent) : void
      {
         if(MonkeyCityMain.getInstance().mouseManager.state)
         {
            this._clip.visible = true;
            TweenLite.to(this._clip,0.2,{
               "scaleX":1,
               "scaleY":1
            });
         }
      }
      
      protected function onRollout(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         TweenLite.to(this._clip,0.2,{
            "scaleX":0,
            "scaleY":0,
            "onComplete":function():void
            {
               _clip.visible = false;
            }
         });
      }
   }
}
