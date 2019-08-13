package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class CollectedValueText extends MovieClip
   {
       
      
      public var txtContainer:CollectedValueTxtContainer;
      
      public function CollectedValueText()
      {
         super();
         addFrameScript(21,this.frame22);
      }
      
      function frame22() : *
      {
         stop();
      }
   }
}
