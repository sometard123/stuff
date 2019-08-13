package assets.town
{
   import flash.display.MovieClip;
   
   public dynamic class TanksFullWordAnimation extends MovieClip
   {
       
      
      public function TanksFullWordAnimation()
      {
         super();
         addFrameScript(29,this.frame30);
      }
      
      function frame30() : *
      {
         gotoAndStop(1);
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}
