package ninjakiwi.monkeyTown.btdModule.entities
{
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class Cursor extends Entity
   {
       
      
      public var clip:Clip;
      
      public function Cursor()
      {
         this.clip = new Clip();
         super();
      }
      
      public function initialise(param1:Class) : void
      {
         z = 999999;
         this.clip.initialise(param1,1);
         this.clip.looping = true;
         this.clip.play();
      }
      
      override public function process(param1:Number) : void
      {
         x = Main.instance.mouseX;
         y = Main.instance.mouseY;
         this.clip.process();
      }
      
      override public function draw(param1:BitmapData) : void
      {
         if(rotation == 0)
         {
            this.clip.quickDraw(param1,x,y);
         }
         else
         {
            this.clip.drawRotated(param1,x,y,rotation);
         }
      }
   }
}
