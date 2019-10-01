package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.vortex
{
   import assets.bloons.VortexEntryPortalClip;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class VortexAnimationBack extends Entity
   {
       
      
      public var clip:Clip;
      
      public var visible:Boolean = true;
      
      public function VortexAnimationBack()
      {
         this.clip = new Clip();
         super();
         this.clip.initialise(VortexEntryPortalClip,1);
         this.clip.looping = true;
         z = -0.002;
         Main.instance.game.level.addEntity(this);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(this.visible)
         {
            this.clip.quickDraw(param1,x,y);
         }
      }
      
      override public function destroy() : void
      {
         Main.instance.game.cull(this);
         super.destroy();
      }
   }
}
