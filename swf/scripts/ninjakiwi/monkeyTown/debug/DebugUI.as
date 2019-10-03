package ninjakiwi.monkeyTown.debug
{
   import flash.display.Sprite;
   import flash.utils.setTimeout;
   
   public class DebugUI extends Sprite
   {
       
      
      public var debugDataEntryWindow:DebugEntryPane;
      
      public function DebugUI()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.debugDataEntryWindow = new DebugEntryPane(this);
      }
   }
}
