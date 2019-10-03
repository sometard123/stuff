package assets.module
{
   import display.ui.Button;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class useTactics_btn extends Button
   {
       
      
      public var coolDown_mc:MovieClip;
      
      public var holder_mc:MovieClip;
      
      public var qty_txt:TextField;
      
      public function useTactics_btn()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,19,this.frame20);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame10() : *
      {
         stop();
      }
      
      function frame20() : *
      {
         stop();
      }
   }
}
