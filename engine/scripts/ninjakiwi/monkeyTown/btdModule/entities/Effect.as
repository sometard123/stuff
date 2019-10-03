package ninjakiwi.monkeyTown.btdModule.entities
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   
   public class Effect extends Entity
   {
       
      
      public var clip:MovieClip = null;
      
      private var transform:Matrix;
      
      private var _blendMode:String;
      
      public function Effect(param1:String = null)
      {
         this.transform = new Matrix();
         super();
         this._blendMode = param1;
      }
      
      public function initialise(param1:Class, param2:Number) : void
      {
         this.clip = new param1();
         this.z = param2;
      }
      
      public function initialiseMC(param1:MovieClip, param2:Number) : void
      {
         this.clip = param1;
         this.z = param2;
      }
      
      override public function process(param1:Number) : void
      {
         if(this.clip.currentFrame == this.clip.totalFrames)
         {
            destroy();
         }
         else
         {
            this.clip.gotoAndStop(this.clip.currentFrame + 1);
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
         if(this._blendMode != null)
         {
            this.clip.blendMode = this._blendMode;
            param1.draw(this.clip,this.transform,null,this._blendMode);
         }
         else
         {
            param1.draw(this.clip,this.transform);
         }
      }
   }
}
