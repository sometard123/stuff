package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class VictoryGenericPanelClip extends MovieClip
   {
       
      
      public var okButton:MovieClip;
      
      public function VictoryGenericPanelClip()
      {
         super();
         addFrameScript(15,this.frame16);
      }
      
      function frame16() : *
      {
         stop();
      }
   }
}
