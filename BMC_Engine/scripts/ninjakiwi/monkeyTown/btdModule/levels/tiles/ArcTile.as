package ninjakiwi.monkeyTown.btdModule.levels.tiles
{
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   
   public class ArcTile extends Tile
   {
       
      
      private var baseCentre:Vector2;
      
      private var baseStart:Vector2;
      
      private var baseEnd:Vector2;
      
      private var reflex:Boolean;
      
      private var clockwise:Boolean;
      
      public function ArcTile()
      {
         super();
      }
      
      public function ini_baseCentre(param1:Vector2) : ArcTile
      {
         this.baseCentre = param1;
         return this;
      }
      
      public function ini_baseStart(param1:Vector2) : ArcTile
      {
         this.baseStart = param1;
         return this;
      }
      
      public function ini_baseEnd(param1:Vector2) : ArcTile
      {
         this.baseEnd = param1;
         return this;
      }
      
      public function ini_reflex(param1:Boolean) : ArcTile
      {
         this.reflex = param1;
         return this;
      }
      
      override public function initialise(param1:Vector.<Tile>) : void
      {
         var _loc2_:Vector2 = null;
         var _loc3_:Vector2 = null;
         var _loc11_:Number = NaN;
         super.initialise(param1);
         _loc2_ = Vector2.subtract(this.baseStart,this.baseCentre,new Vector2());
         _loc3_ = Vector2.subtract(this.baseEnd,this.baseCentre,new Vector2());
         var _loc4_:Number = _loc2_.magnitude;
         var _loc5_:Number = Math.acos(_loc2_.dot(_loc3_) / (_loc2_.magnitude * _loc3_.magnitude));
         if(this.reflex)
         {
            _loc5_ = 2 * Math.PI - _loc5_;
         }
         tileLength = _loc5_ * _loc4_;
         var _loc6_:int = Math.ceil(tileLength / maxSectionLength);
         sectionLength = tileLength / _loc6_;
         var _loc7_:Number = sectionLength / _loc4_;
         var _loc8_:Number = Math.atan2(_loc2_.y,_loc2_.x);
         var _loc9_:Number = Math.atan2(_loc3_.y,_loc3_.x);
         while(_loc9_ > _loc8_ && Math.abs(_loc9_ - _loc8_) > Math.PI)
         {
            _loc9_ = _loc9_ - 2 * Math.PI;
         }
         while(_loc9_ < _loc8_ && Math.abs(_loc9_ - _loc8_) > Math.PI)
         {
            _loc9_ = _loc9_ + 2 * Math.PI;
         }
         this.clockwise = !(_loc9_ < _loc8_ && !this.reflex || _loc9_ > _loc8_ && this.reflex);
         if(this.reflex && Math.abs(_loc9_ - _loc8_) < Math.PI)
         {
            if(this.clockwise)
            {
               _loc9_ = _loc9_ + 2 * Math.PI;
            }
            else
            {
               _loc9_ = _loc9_ - 2 * Math.PI;
            }
         }
         wayPoints = new Vector.<Vector2>();
         var _loc10_:int = 0;
         while(_loc10_ <= _loc6_)
         {
            _loc11_ = _loc8_ + (_loc9_ - _loc8_) * _loc10_ / _loc6_;
            wayPoints.push(new Vector2(this.baseCentre.x + Math.cos(_loc11_) * _loc4_,this.baseCentre.y + Math.sin(_loc11_) * _loc4_));
            _loc10_++;
         }
      }
      
      override public function get startAngle() : Number
      {
         if(this.clockwise)
         {
            return Math.atan2(this.baseCentre.x - this.baseStart.x,this.baseStart.y - this.baseCentre.y);
         }
         return Math.atan2(this.baseStart.x - this.baseCentre.x,this.baseCentre.y - this.baseStart.y);
      }
      
      override public function get endAngle() : Number
      {
         if(!this.clockwise)
         {
            return Math.atan2(this.baseCentre.x - this.baseEnd.x,this.baseEnd.y - this.baseCentre.y);
         }
         return Math.atan2(this.baseEnd.x - this.baseCentre.x,this.baseCentre.y - this.baseEnd.y);
      }
      
      override public function get startX() : Number
      {
         return this.baseStart.x;
      }
      
      override public function get startY() : Number
      {
         return this.baseStart.y;
      }
      
      override public function get endX() : Number
      {
         return this.baseEnd.x;
      }
      
      override public function get endY() : Number
      {
         return this.baseEnd.y;
      }
   }
}
