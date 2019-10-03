package ninjakiwi.monkeyTown.btdModule.effects
{
   import display.Frame;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class Burst extends Entity
   {
       
      
      private var frame:Frame;
      
      private var drawn:Boolean = false;
      
      private var level:Level;
      
      public function Burst()
      {
         this.frame = Main.instance.frameFactory.getFrames(assets.Burst,10)[0];
         super();
         z = 5;
      }
      
      public function initialise(param1:Number, param2:Number, param3:Level) : void
      {
         this.x = param1;
         this.y = param2;
         this.level = param3;
         this.drawn = false;
         rotation = Math.random() * 6.28;
         param3.addEntity(this);
      }
      
      override public function process(param1:Number) : void
      {
         if(this.drawn)
         {
            this.level.cull(this);
            Pool.release(this);
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.frame.drawRotated(param1,x,y,rotation);
         this.drawn = true;
      }
   }
}
