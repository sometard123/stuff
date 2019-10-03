package assets.flare
{
   import flash.display.MovieClip;
   
   public dynamic class DemolishEffectWithoutXPClip extends MovieClip
   {
       
      
      public function DemolishEffectWithoutXPClip()
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
