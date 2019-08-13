package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class MonkeyKnowledgeSaleIntroPanelClip extends MovieClip
   {
       
      
      public var background:MovieClip;
      
      public var buyButton:MovieClip;
      
      public var closeButton:MovieClip;
      
      public function MonkeyKnowledgeSaleIntroPanelClip()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
