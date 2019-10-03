package ninjakiwi.monkeyTown.town.ui.cursor
{
   import assets.cursors.DartCursorClip;
   import assets.cursors.HammerCursorClip;
   import assets.cursors.MagnifyingGlassIconClip;
   import assets.cursors.NotAllowedCursor;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.mouseManager.MouseManager;
   import ninjakiwi.monkeyTown.ui.cursor.CursorManager;
   
   public class MonkeyCityCursorManager extends CursorManager
   {
       
      
      private var _mouseManager:MouseManager;
      
      public const ATTACK_CURSOR:String = "AttackCursor";
      
      public const NOT_ALLOWED_CURSOR:String = "NotAllowedCursor";
      
      public const BUILD_CURSOR:String = "assets.cursors.HammerCursorClip";
      
      public const INSPECT_CURSOR:String = "InspectCursor";
      
      public function MonkeyCityCursorManager(param1:DisplayObjectContainer, param2:MouseManager)
      {
         super(param1);
         this.initCursorManager();
         this._mouseManager = param2;
         this._mouseManager.signals.mouseMoveSignal.add(this.onMouseMove);
      }
      
      private function initCursorManager() : void
      {
         makeAndRegisterCursor(DartCursorClip,this.ATTACK_CURSOR).setHideSystemCursorOnReveal(false);
         makeAndRegisterCursor(NotAllowedCursor,this.NOT_ALLOWED_CURSOR).setHideSystemCursorOnReveal(false);
         makeAndRegisterCursor(MagnifyingGlassIconClip,this.INSPECT_CURSOR).setHideSystemCursorOnReveal(false);
         makeAndRegisterCursor(HammerCursorClip,this.BUILD_CURSOR).setHideSystemCursorOnReveal(false);
      }
      
      private function onMouseMove(param1:Number, param2:Number) : void
      {
         update();
      }
   }
}
