package ninjakiwi.monkeyTown.btdModule.entities
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Matrix;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class TimedEffect extends Entity
   {
       
      
      public var clip:MovieClip = null;
      
      private var transform:Matrix;
      
      private var timer:GameSpeedTimer = null;
      
      private var tower:Tower = null;
      
      public function TimedEffect()
      {
         this.transform = new Matrix();
         super();
      }
      
      public function initialise(param1:Class, param2:Number, param3:Number, param4:Tower = null) : void
      {
         this.tower = param4;
         this.clip = new param1();
         this.timer = new GameSpeedTimer(param3);
         this.timer.start();
         this.z = param2;
      }
      
      public function initialiseMC(param1:MovieClip, param2:Number) : void
      {
         this.clip = param1;
         this.z = param2;
      }
      
      override public function destroy() : void
      {
         dispatchEvent(new Event("done"));
         super.destroy();
      }
      
      override public function process(param1:Number) : void
      {
         if(this.clip.currentFrame == this.clip.totalFrames)
         {
            this.clip.gotoAndStop("Loop");
         }
         else
         {
            this.clip.gotoAndStop(this.clip.currentFrame + 1);
         }
         if(this.timer != null && !this.timer.running || this.tower != null && this.tower.def == null)
         {
            this.destroy();
         }
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.transform.identity();
         if(rotation != 0)
         {
            this.transform.rotate(rotation);
         }
         this.transform.translate(x,y);
         this.transform.scale(Main.instance.scale,Main.instance.scale);
         param1.draw(this.clip,this.transform);
      }
   }
}
