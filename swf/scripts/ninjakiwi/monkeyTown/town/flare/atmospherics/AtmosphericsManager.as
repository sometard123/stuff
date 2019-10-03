package ninjakiwi.monkeyTown.town.flare.atmospherics
{
   import com.lgrey.vectors.LGVector2D;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.entity.SpriteEntityManager;
   
   public class AtmosphericsManager
   {
       
      
      public var lowEntityManager:SpriteEntityManager;
      
      public var midEntityManager:SpriteEntityManager;
      
      public var topEntityManager:SpriteEntityManager;
      
      private const _system:MonkeySystem = MonkeySystem.getInstance();
      
      public var windSpeed:LGVector2D;
      
      public function AtmosphericsManager()
      {
         this.lowEntityManager = new SpriteEntityManager();
         this.midEntityManager = new SpriteEntityManager();
         this.topEntityManager = new SpriteEntityManager();
         this.windSpeed = new LGVector2D(0.3,0);
         super();
      }
      
      public function generate() : void
      {
         this.clear();
         var _loc1_:int = 0;
         while(_loc1_ < 1)
         {
            this.makeCloud();
            _loc1_++;
         }
      }
      
      public function tick() : void
      {
         this.lowEntityManager.tick();
         this.midEntityManager.tick();
         this.topEntityManager.tick();
      }
      
      private function makeCloud() : void
      {
         var _loc1_:Cloud = null;
         _loc1_ = new Cloud(this);
         this.topEntityManager.register(_loc1_);
         _loc1_.x = this._system.TOWN_MAP_PIXEL_WIDTH * Math.random();
         _loc1_.y = this._system.TOWN_MAP_PIXEL_HEIGHT * 0.5 + (Math.random() * 2 - 1) * (this._system.TOWN_MAP_PIXEL_HEIGHT * 0.25);
      }
      
      public function clear() : void
      {
         this.lowEntityManager.clear();
         this.midEntityManager.clear();
         this.topEntityManager.clear();
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         this.lowEntityManager.render(param1,param2);
         this.midEntityManager.render(param1,param2);
         this.topEntityManager.render(param1,param2);
      }
   }
}
