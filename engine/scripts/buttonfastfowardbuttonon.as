package
{
   import display.ui.Button;
   
   public dynamic class buttonfastfowardbuttonon extends Button
   {
       
      
      public function buttonfastfowardbuttonon()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         stop();
      }
      
      function frame3() : *
      {
         stop();
      }
   }
}
