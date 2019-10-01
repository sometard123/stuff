package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class GoochProfiler extends Sprite
   {
       
      
      public var current:String = null;
      
      public const displayColours:Vector.<uint> = Vector.<uint>([4280427042,4294901760,4278255360,4278190335,4278242559,4294902015,4284901068,4294967040,4288256256,4278216396,4294927872,4289374890]);
      
      public var sectionList:Vector.<String>;
      
      public var startTimes:Dictionary;
      
      public var accumulators:Dictionary;
      
      public var lastRecalc:int = 0;
      
      public var recalcInterval:int = 5000;
      
      public var clip:MovieClip = null;
      
      public var textField:TextField;
      
      public var pieRadius:Number = 30;
      
      public var showUnprofiledUsage:Boolean = false;
      
      public function GoochProfiler()
      {
         this.sectionList = new Vector.<String>();
         this.startTimes = new Dictionary();
         this.accumulators = new Dictionary();
         this.textField = new TextField();
         super();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.mouseEnabled = false;
         this.mouseChildren = false;
         var _loc1_:String = ".profile{ font-size:10px; leading:-1px; font-family: arial; color:#000000; }";
         var _loc2_:StyleSheet = new StyleSheet();
         _loc2_.parseCSS(_loc1_);
         this.textField.styleSheet = _loc2_;
         this.textField.filters = [new GlowFilter(16777215,1,2,2,4,3)];
         this.show();
      }
      
      public function start(param1:String) : void
      {
         this.end();
         this.current = param1;
         this.startTimes[param1] = getTimer();
      }
      
      public function end() : String
      {
         if(!this.current)
         {
            return null;
         }
         if(isNaN(this.accumulators[this.current]))
         {
            this.accumulators[this.current] = 0;
            this.sectionList.push(this.current);
         }
         this.accumulators[this.current] = this.accumulators[this.current] + (getTimer() - this.startTimes[this.current]);
         var _loc1_:String = this.current;
         this.current = null;
         return _loc1_;
      }
      
      public function update() : void
      {
         var _loc1_:String = null;
         if(this.showUnprofiledUsage)
         {
            this.end();
         }
         if(getTimer() - this.lastRecalc > this.recalcInterval)
         {
            this.draw();
            for each(_loc1_ in this.sectionList)
            {
               this.accumulators[_loc1_] = 0;
            }
            this.lastRecalc = getTimer();
         }
         if(this.showUnprofiledUsage)
         {
            this.start("other");
         }
      }
      
      public function draw() : void
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         this.clip.graphics.clear();
         var _loc1_:Number = 0;
         for each(_loc2_ in this.sectionList)
         {
            _loc1_ = _loc1_ + this.accumulators[_loc2_];
         }
         _loc3_ = 0;
         _loc4_ = 0;
         for each(_loc2_ in this.sectionList)
         {
            _loc5_ = this.accumulators[_loc2_] / _loc1_;
            this.drawSector(_loc3_,_loc5_,this.displayColours[_loc4_++]);
            _loc3_ = _loc3_ + _loc5_;
         }
         this.drawKey();
      }
      
      private function drawKey() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc1_:String = "";
         for each(_loc2_ in this.sectionList)
         {
            _loc1_ = _loc1_ + (_loc2_ + "\n");
         }
         _loc1_.substr(0,_loc1_.length - 1);
         this.textField.htmlText = "<span class = \"profile\">" + _loc1_ + "<span>";
         this.textField.x = -(this.textField.textWidth + this.pieRadius + 10);
         this.textField.y = -this.pieRadius;
         _loc3_ = 0;
         while(_loc3_ < this.sectionList.length)
         {
            this.clip.graphics.beginFill(this.displayColours[_loc3_]);
            this.clip.graphics.drawRect(this.textField.x - 10,this.textField.y + 5 + 10 * _loc3_,8,8);
            this.clip.graphics.endFill();
            _loc3_++;
         }
      }
      
      private function drawSector(param1:Number, param2:Number, param3:int) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc4_:Number = 1 / this.pieRadius;
         var _loc5_:int = int(Math.PI * 2 / _loc4_);
         var _loc6_:int = int(param1 * _loc5_);
         var _loc7_:int = Math.ceil((param1 + param2) * _loc5_);
         this.clip.graphics.beginFill(param3);
         this.clip.graphics.moveTo(0,0);
         var _loc8_:int = _loc6_;
         while(_loc8_ <= _loc7_)
         {
            _loc9_ = _loc8_ * _loc4_ - Math.PI / 2;
            _loc10_ = Math.cos(_loc9_) * this.pieRadius;
            _loc11_ = Math.sin(_loc9_) * this.pieRadius;
            this.clip.graphics.lineTo(_loc10_,_loc11_);
            _loc8_++;
         }
         this.clip.graphics.lineTo(0,0);
         this.clip.graphics.endFill();
      }
      
      public function show() : void
      {
         if(!this.clip)
         {
            this.clip = new MovieClip();
            this.clip.addChild(this.textField);
            addChild(this.clip);
         }
      }
      
      public function hide() : void
      {
         if(this.clip)
         {
            if(this.contains(this.clip))
            {
               removeChild(this.clip);
            }
            this.clip = null;
         }
      }
   }
}
