package ContestedTerritory_fla_fla
{
   import flash.display.MovieClip;
   
   public dynamic class Padding_2 extends MovieClip
   {
       
      
      public function Padding_2()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.alpha = 0;
      }
   }
}
