package assets.flare
{
   import flash.display.MovieClip;
   
   public dynamic class DemolishEffectClip extends MovieClip
   {
       
      
      public function DemolishEffectClip()
      {
         super();
         addFrameScript(39,this.frame40);
      }
      
      function frame40() : *
      {
         gotoAndStop(1);
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
      }
   }
}
