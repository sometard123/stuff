package ninjakiwi.monkeyTown.btdModule.entities
{
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class MapElement extends Entity
   {
       
      
      public var clip:Clip;
      
      public var theZ:Number = 0;
      
      public var id:String = null;
      
      public function MapElement(param1:String = null)
      {
         this.clip = new Clip();
         super();
         this.id = param1;
      }
      
      public function initialise(param1:Class, param2:Number, param3:int = 1) : void
      {
         this.theZ = param2;
         this.clip.initialise(param1,param3);
         this.clip.play();
         this.clip.looping = true;
         z = param2;
      }
      
      override public function process(param1:Number) : void
      {
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
