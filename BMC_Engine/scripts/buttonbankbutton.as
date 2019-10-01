package
{
   import display.ui.Button;
   import flash.text.TextField;
   
   public dynamic class buttonbankbutton extends Button
   {
       
      
      public var balance_txt:TextField;
      
      public function buttonbankbutton()
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
