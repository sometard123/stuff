package ninjakiwi.monkeyTown.btdModule.math
{
   import flash.geom.Matrix;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class SmoothPath
   {
       
      
      private var curves:Vector.<CubicBezier>;
      
      private var curveLengths:Vector.<Number>;
      
      public var totalLength:Number = 0;
      
      public function SmoothPath()
      {
         this.curveLengths = new Vector.<Number>();
         super();
      }
      
      public function initialise(param1:Vector.<CubicBezier>) : void
      {
         var _loc2_:CubicBezier = null;
         var _loc3_:Number = NaN;
         this.curves = param1;
         this.curveLengths.splice(0,this.curveLengths.length);
         this.totalLength = 0;
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.length;
            this.curveLengths.push(_loc3_);
            this.totalLength = this.totalLength + _loc3_;
         }
      }
      
      public function getTransformedValue(param1:Number, param2:Vector2, param3:Number, param4:Number, param5:Number) : Vector2
      {
         var _loc7_:Matrix = null;
         param1 = param1 * this.totalLength;
         var _loc6_:int = 0;
         while(_loc6_ < this.curveLengths.length)
         {
            if(param1 - this.curveLengths[_loc6_] > 0)
            {
               param1 = param1 - this.curveLengths[_loc6_];
               _loc6_++;
               continue;
            }
            this.curves[_loc6_].getValue(param1 = Number(param1 / this.curveLengths[_loc6_]),param2);
            _loc7_ = Pool.get(Matrix);
            _loc7_.identity();
            _loc7_.rotate(param3);
            _loc7_.translate(param4,param5);
            param2.applyTransform(_loc7_);
            Pool.release(_loc7_);
            return param2;
         }
         return null;
      }
   }
}
