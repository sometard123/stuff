package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import com.lgrey.vectors.LGVector2D;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class SmokeParticle extends Entity
   {
       
      
      public var clip:Clip;
      
      public var velocity:LGVector2D;
      
      public function SmokeParticle(param1:Class, param2:int = 1)
      {
         this.clip = new Clip();
         this.velocity = new LGVector2D();
         super();
         z = param2;
         this.clip.initialise(param1,1);
         this.clip.play();
         Main.instance.game.level.addEntity(this);
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
         this.clip.process();
         x = x + this.velocity.x;
         y = y + this.velocity.y;
         if(this.clip.frameIndex === this.clip.frameCount - 1)
         {
            this.clean();
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.quickDraw(param1,x,y);
      }
      
      protected function clean() : void
      {
         this.clip.stop();
         this.clip = null;
         Main.instance.game.level.cull(this);
      }
   }
}
