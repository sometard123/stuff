package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class BuildingMoveButtonClip extends MovieClip
   {
       
      
      public function BuildingMoveButtonClip()
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
