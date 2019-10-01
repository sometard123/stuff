package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.GeneratingWorldMessageClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   
   public class GeneratingWorldMessage extends HideRevealView
   {
       
      
      private var _clip:GeneratingWorldMessageClip;
      
      public function GeneratingWorldMessage(param1:DisplayObjectContainer)
      {
         this._clip = new GeneratingWorldMessageClip();
         super(param1);
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
      }
      
      public function setMessage(param1:String) : void
      {
         this._clip.messageField.htmlText = param1;
      }
      
      override public function reveal(param1:Number = 0.5) : void
      {
         if(_stage)
         {
            x = int(_stage.stageWidth * 0.5);
            y = int(_stage.stageHeight * 0.5);
         }
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.5) : void
      {
         super.hide(param1);
      }
   }
}
