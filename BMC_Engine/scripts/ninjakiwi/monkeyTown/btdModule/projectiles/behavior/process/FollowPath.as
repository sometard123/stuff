package ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.math.CubicBezier;
   import ninjakiwi.monkeyTown.btdModule.math.CubicBezierDef;
   import ninjakiwi.monkeyTown.btdModule.math.SmoothPath;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class FollowPath extends BehaviorProcess
   {
      
      private static var displayOrder:Vector.<String> = null;
       
      
      private var path_:Vector.<CubicBezierDef>;
      
      private var _cubicBeziers:Vector.<CubicBezier>;
      
      private var _smoothParth:SmoothPath;
      
      private var _timeRatio:Number;
      
      public function FollowPath()
      {
         this._cubicBeziers = new Vector.<CubicBezier>();
         this._smoothParth = new SmoothPath();
         super();
      }
      
      public static function getDisplayOrder() : Vector.<String>
      {
         if(displayOrder == null)
         {
            displayOrder = new Vector.<String>();
            displayOrder.push("path");
         }
         return displayOrder;
      }
      
      public function set path(param1:Vector.<CubicBezierDef>) : void
      {
         if(this.path_ != param1)
         {
            this.path_ = param1;
            this.initialisePath();
            dispatchEvent(new PropertyModEvent("path"));
         }
      }
      
      public function get path() : Vector.<CubicBezierDef>
      {
         return this.path_;
      }
      
      public function Path(param1:Array) : FollowPath
      {
         var _loc2_:CubicBezierDef = null;
         if(this.path == null)
         {
            this.path = new Vector.<CubicBezierDef>();
         }
         for each(_loc2_ in param1)
         {
            this.path.push(_loc2_);
         }
         this.initialisePath();
         return this;
      }
      
      private function initialisePath() : void
      {
         var _loc1_:CubicBezierDef = null;
         var _loc2_:CubicBezier = null;
         this._cubicBeziers = new Vector.<CubicBezier>();
         for each(_loc1_ in this.path)
         {
            _loc2_ = new CubicBezier();
            _loc2_.initialise(_loc1_);
            this._cubicBeziers.push(_loc2_);
         }
         this._smoothParth = new SmoothPath();
         this._smoothParth.initialise(this._cubicBeziers);
      }
      
      override public function execute(param1:Projectile, param2:Number) : void
      {
         var _loc3_:Vector2 = null;
         var _loc4_:Vector2 = null;
         _loc3_ = Pool.get(Vector2);
         _loc3_.x = 24;
         _loc3_.y = 12;
         _loc3_.rotateBy(param1.velocity.rotation);
         this._timeRatio = param1.lifeSpanTimer.current / param1.lifeSpanTimer.delay;
         _loc4_ = new Vector2();
         this._smoothParth.getTransformedValue(this._timeRatio,_loc4_,param1.velocity.rotation,param1.owner.x + _loc3_.x,param1.owner.y + _loc3_.y);
         Pool.release(_loc3_);
         param1.x = _loc4_.x;
         param1.y = _loc4_.y;
         param1.rotation = this._timeRatio * 18.8495559215388;
      }
   }
}
