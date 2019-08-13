package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class BountySecretCardFlipLeadin extends MovieClip
   {
       
      
      public function BountySecretCardFlipLeadin()
      {
         super();
         addFrameScript(39,this.frame40);
      }
      
      function frame40() : *
      {
         stop();
         if(parent && parent.contains(this))
         {
            this.parent.removeChild(this);
         }
      }
   }
}
