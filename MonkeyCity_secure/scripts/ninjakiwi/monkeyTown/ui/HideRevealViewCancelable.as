package ninjakiwi.monkeyTown.ui
{
   import flash.display.DisplayObjectContainer;
   import flash.events.KeyboardEvent;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class HideRevealViewCancelable extends HideRevealView
   {
       
      
      public function HideRevealViewCancelable(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
      }
      
      override protected function onRevealComplete() : void
      {
         super.onRevealComplete();
         if(MonkeySystem.getInstance().flashStage != null)
         {
            MonkeySystem.getInstance().flashStage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         if(MonkeySystem.getInstance().flashStage != null)
         {
            MonkeySystem.getInstance().flashStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         super.hide(param1);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
      }
      
      protected function onESC() : void
      {
         this.hide();
      }
   }
}
