package
{
   import display.ui.Button;
   
   public dynamic class buttonvertbutton extends Button
   {
       
      
      public function buttonvertbutton()
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