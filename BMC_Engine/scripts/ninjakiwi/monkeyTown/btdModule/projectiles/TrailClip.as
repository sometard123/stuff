package ninjakiwi.monkeyTown.btdModule.projectiles
{
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class TrailClip extends Entity
   {
       
      
      private var clip:Clip = null;
      
      public function TrailClip()
      {
         super();
      }
      
      public function Initialise(param1:Class, param2:int) : void
      {
         this.clip = new Clip();
         this.clip.initialise(param1,64);
         this.clip.gotoAndPlay(param2);
      }
      
      override public function process(param1:Number) : void
      {
         if(this.clip.frameIndex == this.clip.frameCount - 1)
         {
            destroy();
         }
         this.clip.process();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.drawRotated(param1,x,y,rotation);
      }
   }
}
