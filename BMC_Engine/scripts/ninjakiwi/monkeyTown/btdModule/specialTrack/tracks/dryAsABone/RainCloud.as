package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.dryAsABone
{
   import assets.maps.dryasabone.RainCloudClip;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class RainCloud extends Entity
   {
       
      
      public var clip:Clip;
      
      public function RainCloud()
      {
         this.clip = new Clip();
         super();
         z = int.MAX_VALUE;
         this.clip.initialise(RainCloudClip,1);
         this.clip.play();
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
         this.clip.process();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.quickDraw(param1,x,y);
      }
   }
}
