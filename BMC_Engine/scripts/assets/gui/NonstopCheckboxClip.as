package assets.gui
{
   import display.ui.Button;
   
   public dynamic class NonstopCheckboxClip extends Button
   {
       
      
      public function NonstopCheckboxClip()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4);
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
      
      function frame4() : *
      {
         stop();
      }
   }
}
