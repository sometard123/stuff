package assets.gui
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MinusBloonstones extends MovieClip
   {
       
      
      public var label:TextField;
      
      public function MinusBloonstones()
      {
         super();
         addFrameScript(30,this.frame31);
      }
      
      function frame31() : *
      {
         stop();
      }
   }
}
