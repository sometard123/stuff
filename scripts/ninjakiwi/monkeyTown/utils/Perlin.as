package ninjakiwi.monkeyTown.utils
{
   public class Perlin
   {
      
      private static const ARRAY_LENGTH:int = 256;
      
      private static const DEFAULT_Z:Number = 48454.5;
      
      private static const kensPermutation:Array = [151,160,137,91,90,15,131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,190,6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,88,237,149,56,87,174,20,125,136,171,168,68,175,74,165,71,134,139,48,27,166,77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,102,143,54,65,25,63,161,1,216,80,73,209,76,132,187,208,89,18,169,200,196,135,130,116,188,159,86,164,100,109,198,173,186,3,64,52,217,226,250,124,123,5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,223,183,170,213,119,248,152,2,44,154,163,70,221,153,101,155,167,43,172,9,129,22,39,253,19,98,108,110,79,113,224,232,178,185,112,104,218,246,97,228,251,34,242,193,238,210,144,12,191,179,162,241,81,51,145,235,249,14,239,107,49,192,214,31,181,199,106,157,184,84,204,176,115,121,50,45,127,4,150,254,138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180];
       
      
      private var p:Array;
      
      private var numOctaves:int;
      
      private var frequencies:Array;
      
      private var amplitudes:Array;
      
      public function Perlin(param1:int, param2:uint, param3:Number = 0.5)
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         super();
         this.numOctaves = param1;
         this.frequencies = [];
         this.amplitudes = [];
         var _loc5_:Number = 0;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc7_ = Math.pow(2,_loc4_);
            _loc8_ = Math.pow(param3,_loc4_);
            this.frequencies[_loc4_] = _loc7_;
            this.amplitudes[_loc4_] = _loc8_;
            _loc5_ = _loc5_ + _loc8_;
            _loc4_++;
         }
         var _loc6_:Number = 1 / _loc5_;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            this.amplitudes[_loc4_] = this.amplitudes[_loc4_] * _loc6_;
            _loc4_++;
         }
         if(param2 == 0)
         {
            this.p = kensPermutation.concat();
         }
         else
         {
            this.p = this.shuffleCopy(new Random(param2),kensPermutation);
         }
         _loc4_ = 0;
         while(_loc4_ < ARRAY_LENGTH)
         {
            this.p[_loc4_ + ARRAY_LENGTH] = this.p[_loc4_];
            _loc4_++;
         }
      }
      
      public function noise(param1:Number, param2:Number, param3:Number = 48454.5) : Number
      {
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         while(_loc5_ < this.numOctaves)
         {
            _loc6_ = this.frequencies[_loc5_];
            _loc7_ = this.amplitudes[_loc5_];
            _loc8_ = this.simpleNoise(param1 * _loc6_,param2 * _loc6_,param3 * _loc6_);
            _loc4_ = _loc4_ + _loc8_ * _loc7_;
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function simpleNoise(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc4_:* = int(Math.floor(param1)) & 255;
         var _loc5_:* = int(Math.floor(param2)) & 255;
         var _loc6_:* = int(Math.floor(param3)) & 255;
         param1 = param1 - Math.floor(param1);
         param2 = param2 - Math.floor(param2);
         param3 = param3 - Math.floor(param3);
         var _loc7_:Number = this.fade(param1);
         var _loc8_:Number = this.fade(param2);
         var _loc9_:Number = this.fade(param3);
         var _loc10_:int = this.p[_loc4_] + _loc5_;
         var _loc11_:int = this.p[_loc10_] + _loc6_;
         var _loc12_:int = this.p[_loc10_ + 1] + _loc6_;
         var _loc13_:int = this.p[_loc4_ + 1] + _loc5_;
         var _loc14_:int = this.p[_loc13_] + _loc6_;
         var _loc15_:int = this.p[_loc13_ + 1] + _loc6_;
         return this.lerp(_loc9_,this.lerp(_loc8_,this.lerp(_loc7_,this.grad(this.p[_loc11_],param1,param2,param3),this.grad(this.p[_loc14_],param1 - 1,param2,param3)),this.lerp(_loc7_,this.grad(this.p[_loc12_],param1,param2 - 1,param3),this.grad(this.p[_loc15_],param1 - 1,param2 - 1,param3))),this.lerp(_loc8_,this.lerp(_loc7_,this.grad(this.p[_loc11_ + 1],param1,param2,param3 - 1),this.grad(this.p[_loc14_ + 1],param1 - 1,param2,param3 - 1)),this.lerp(_loc7_,this.grad(this.p[_loc12_ + 1],param1,param2 - 1,param3 - 1),this.grad(this.p[_loc15_ + 1],param1 - 1,param2 - 1,param3 - 1))));
      }
      
      private function fade(param1:Number) : Number
      {
         return param1 * param1 * param1 * (param1 * (param1 * 6 - 15) + 10);
      }
      
      private function lerp(param1:Number, param2:Number, param3:Number) : Number
      {
         return param2 + param1 * (param3 - param2);
      }
      
      private function grad(param1:int, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:uint = param1 & 15;
         var _loc6_:Number = _loc5_ < 8?Number(param2):Number(param3);
         var _loc7_:Number = _loc5_ < 4?Number(param3):_loc5_ == 12 || _loc5_ == 14?Number(param2):Number(param4);
         _loc6_ = (_loc5_ & 1) == 0?Number(_loc6_):Number(-_loc6_);
         _loc7_ = (_loc5_ & 2) == 0?Number(_loc7_):Number(-_loc7_);
         return _loc6_ + _loc7_;
      }
      
      private function shuffleCopy(param1:Random, param2:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:Array = [param2[0]];
         var _loc4_:int = 1;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param1.nextInteger() % (_loc4_ + 1);
            _loc3_[_loc4_] = _loc3_[_loc5_];
            _loc3_[_loc5_] = param2[_loc4_];
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
