package
{
   import display.ui.Button;
   
   public dynamic class upgrade_over_btn extends Button
   {
       
      
      public function upgrade_over_btn()
      {
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame6() : *
      {
         stop();
      }
      
      function frame11() : *
      {
         stop();
      }
   }
}
