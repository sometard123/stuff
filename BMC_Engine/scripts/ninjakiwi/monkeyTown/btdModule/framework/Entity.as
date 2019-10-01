package ninjakiwi.monkeyTown.btdModule.framework
{
   import flash.display.BitmapData;
   
   public class Entity extends Drawable implements Processable
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var rotation_:Number = 0;
      
      public var scene:Scene;
      
      public function Entity()
      {
         super();
      }
      
      public function destroy() : void
      {
         if(this.scene != null)
         {
            this.scene.cull(this);
            this.scene = null;
         }
      }
      
      public function process(param1:Number) : void
      {
      }
      
      override public function draw(param1:BitmapData) : void
      {
      }
      
      public function get rotation() : Number
      {
         return this.rotation_;
      }
      
      public function set rotation(param1:Number) : void
      {
         this.rotation_ = param1;
      }
   }
}
