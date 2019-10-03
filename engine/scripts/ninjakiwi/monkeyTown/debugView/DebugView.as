package ninjakiwi.monkeyTown.debugView
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.graphing.Graphing;
   import ninjakiwi.monkeyTown.ui.HideRevealViewSimple;
   
   public class DebugView extends HideRevealViewSimple
   {
      
      public static const instance:DebugView = new DebugView(null);
       
      
      public var graph:Graphing;
      
      public function DebugView(param1:DisplayObjectContainer)
      {
         this.graph = new Graphing();
         super(param1);
         addChild(this.graph);
         var _loc2_:MovieClip = new MovieClip();
         _loc2_.graphics.beginFill(16777215,0.4);
         _loc2_.graphics.drawRect(0,0,800,600);
         _loc2_.graphics.endFill();
         addChild(_loc2_);
         this.graph.canvasWidth = 650;
         this.graph.canvasHeight = 450;
      }
      
      public function revealGraph() : void
      {
         this.graph.visible = true;
      }
      
      public function hideGraph() : void
      {
         this.graph.visible = false;
      }
   }
}
