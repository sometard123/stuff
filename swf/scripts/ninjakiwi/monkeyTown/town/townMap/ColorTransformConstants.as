package ninjakiwi.monkeyTown.town.townMap
{
   import com.lgrey.utils.RGBA#113;
   import fl.motion.AdjustColor;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   
   public class ColorTransformConstants
   {
      
      private static const YELLOW:Number = 15132160;
      
      private static const BLUE:Number = 10473962;
      
      private static const GREEN:Number = 59392;
      
      private static const ORANGE:Number = 16750848;
      
      private static const RED:Number = 16711680;
      
      private static const MAGENTA:Number = 12717899;
      
      private static const PURPLE:Number = 10027165;
      
      public static var HOVER_BAD_COLOR_TRANSFORM:ColorTransform = new ColorTransform(2,1.1,1.1,1);
      
      public static var HOVER_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1.3,1.3,1.3,1);
      
      public static var FLOATING_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1.1,1.1,1.1,0.9);
      
      public static var FLOATING_BAD_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.5,0.5,0.5,0.75,155);
      
      public static var TRIVIAL_COLOR_TRANSFORM:ColorTransform = getColorTransform(GREEN);
      
      public static var EASY_COLOR_TRANSFORM:ColorTransform = getColorTransform(YELLOW);
      
      public static var MEDIUM_COLOR_TRANSFORM:ColorTransform = getColorTransform(ORANGE);
      
      public static var HARD_COLOR_TRANSFORM:ColorTransform = getColorTransform(RED);
      
      public static var VERY_HARD_COLOR_TRANSFORM:ColorTransform = getColorTransform(MAGENTA);
      
      public static var IMPOPPABLE_COLOR_TRANSFORM:ColorTransform = getColorTransform(PURPLE);
      
      public static var HEAT_MAP_DESATURATE_FILTER:ColorMatrixFilter = null;
      
      private static var colorFilter:AdjustColor = new AdjustColor();
      
      private static var matrix:Array = [];
      
      {
         colorFilter.hue = 0;
         colorFilter.saturation = -90;
         colorFilter.brightness = 0;
         colorFilter.contrast = 0;
         matrix = colorFilter.CalculateFinalFlatArray();
         HEAT_MAP_DESATURATE_FILTER = new ColorMatrixFilter(matrix);
         colorFilter = null;
      }
      
      public function ColorTransformConstants()
      {
         super();
      }
      
      private static function getColorTransform(param1:uint) : ColorTransform
      {
         var _loc2_:ColorTransform = null;
         var _loc3_:RGBA = hextoargb(param1);
         var _loc4_:Number = 0.4;
         _loc2_ = new ColorTransform(1,1,1,1,_loc3_.red * _loc4_,_loc3_.green * _loc4_,_loc3_.blue * _loc4_,_loc3_.alpha);
         return _loc2_;
      }
      
      public static function hextoargb(param1:uint) : RGBA#113
      {
         var _loc2_:RGBA = new RGBA#113();
         _loc2_.alpha = param1 >> 24 & 255;
         _loc2_.red = param1 >> 16 & 255;
         _loc2_.green = param1 >> 8 & 255;
         _loc2_.blue = param1 & 255;
         return _loc2_;
      }
      
      public static function getColorTransformForDifficulty(param1:int) : ColorTransform
      {
         if(param1 > 5)
         {
            return IMPOPPABLE_COLOR_TRANSFORM;
         }
         switch(param1)
         {
            case -1:
               return HOVER_COLOR_TRANSFORM;
            case 0:
            default:
               return TRIVIAL_COLOR_TRANSFORM;
            case 1:
               return EASY_COLOR_TRANSFORM;
            case 2:
               return MEDIUM_COLOR_TRANSFORM;
            case 3:
               return HARD_COLOR_TRANSFORM;
            case 4:
               return VERY_HARD_COLOR_TRANSFORM;
            case 5:
               return IMPOPPABLE_COLOR_TRANSFORM;
         }
      }
   }
}
