package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.sandStorm.SandStormWindAbility;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class BossBlastBack extends Entity
   {
      
      private static const LIFESPAN:int = 30;
       
      
      private var age:int = 0;
      
      private var _bossBloon:Bloon = null;
      
      private var _windForce:Vector2;
      
      protected var _wasPooled:Boolean = false;
      
      public function BossBlastBack()
      {
         super();
      }
      
      public static function create() : BossBlastBack
      {
         var _loc1_:BossBlastBack = Pool.get(BossBlastBack);
         _loc1_._wasPooled = true;
         _loc1_.init();
         Main.instance.game.addEntity(_loc1_);
         return _loc1_;
      }
      
      private function init() : void
      {
         this.age = 0;
         this.spawnChildEffects();
      }
      
      private function spawnChildEffects() : void
      {
         this._bossBloon = SpecialTrackManager.getInstance().getBoss();
         if(this._bossBloon === null)
         {
            return;
         }
         var _loc1_:BossBlastLightning = BossBlastLightning.create();
         _loc1_.x = this._bossBloon.x;
         _loc1_.y = this._bossBloon.y;
         this._windForce = new Vector2(-this._bossBloon.movementDirection.x,-this._bossBloon.movementDirection.y);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         super.draw(param1);
         this.spawnWind();
         this.spawnWind();
         this.spawnWind();
         if(++this.age === LIFESPAN)
         {
            this.clean();
         }
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
      }
      
      private function spawnWind() : void
      {
         if(this._bossBloon == null)
         {
            return;
         }
         var _loc1_:BossBlastWindStreak = BossBlastWindStreak.create(this._windForce);
      }
      
      private function clean() : void
      {
         this.age = 0;
         this._bossBloon = null;
         if(this._wasPooled)
         {
            this._wasPooled = false;
            Pool.release(this);
         }
         Main.instance.game.cull(this);
      }
   }
}
