package assests.effects
{
   import flash.display.MovieClip;
   
   public dynamic class UpEffect extends MovieClip
   {
       
      
      public function UpEffect()
      {
         super();
         addFrameScript(34,this.frame35);
      }
      
      function frame35() : *
      {
         stop();
      }
   }
}
