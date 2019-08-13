package ninjakiwi.display.gfx.bitClip
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class PBMDParams
   {
       
      
      public var clip:MovieClip;
      
      public var clipHolder:DisplayObjectContainer;
      
      public var frame:uint;
      
      public var angle:Number;
      
      public var pbmd_out:PositionedBMD;
      
      public function PBMDParams(param1:MovieClip, param2:DisplayObjectContainer, param3:uint, param4:Number, param5:PositionedBMD)
      {
         super();
         this.clip = param1;
         this.clipHolder = param2;
         this.frame = param3;
         this.angle = param4;
         this.pbmd_out = param5;
      }
   }
}
