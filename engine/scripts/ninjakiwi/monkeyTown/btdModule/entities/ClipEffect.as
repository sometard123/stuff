package ninjakiwi.monkeyTown.btdModule.entities
{
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class ClipEffect extends Entity
   {
      
      public static const DONE:String = "done";
       
      
      public var clip:Clip;
      
      public function ClipEffect()
      {
         this.clip = new Clip();
         super();
      }
      
      public function initialise(param1:Class) : void
      {
         this.clip.initialise(param1,1);
      }
      
      override public function process(param1:Number) : void
      {
         if(this.clip.frameIndex == this.clip.frameCount - 1)
         {
            dispatchEvent(new Event(DONE));
            destroy();
            return;
         }
         this.clip.process();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.quickDraw(param1,x,y);
      }
   }
}
