package com.ninjakiwi.nkBar.assets
{
   import flash.display.MovieClip;
   
   public dynamic class NKBar_Loader extends MovieClip
   {
       
      
      public var loading_mc:MovieClip;
      
      public var failed_mc:MovieClip;
      
      public function NKBar_Loader()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
