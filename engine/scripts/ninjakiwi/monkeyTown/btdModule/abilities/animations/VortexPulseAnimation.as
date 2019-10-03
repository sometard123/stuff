package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   import assets.effects.VortexPulseGraphic;
   import display.Clip;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiTowerAbilities.VortexStunPulseAntiTowerAbility;
   import ninjakiwi.monkeyTown.btdModule.bloons.bossBloons.BossConstants;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   
   public class VortexPulseAnimation extends Entity
   {
      
      private static const ASSET_SIZE:Number = 100;
      
      private static const R1:Number = VortexStunPulseAntiTowerAbility.RADIUS_1_EXTENSTION;
      
      private static const R2:Number = VortexStunPulseAntiTowerAbility.RADIUS_2_EXTENSTION;
      
      private static const R3:Number = VortexStunPulseAntiTowerAbility.RADIUS_3_EXTENSTION;
      
      private static const R4:Number = VortexStunPulseAntiTowerAbility.RADIUS_4_EXTENSTION;
      
      private static const VORTEX_RADIUS:Number = BossConstants.VORTEX_RADIUS;
      
      private static const CLIP_SCALES:Array = [(R1 + VORTEX_RADIUS) / ASSET_SIZE + 1,(R2 + VORTEX_RADIUS) / ASSET_SIZE + 1,(R3 + VORTEX_RADIUS) / ASSET_SIZE + 1,(R4 + VORTEX_RADIUS) / ASSET_SIZE + 1];
       
      
      private var _tierClip:Clip = null;
      
      private var _clips:Vector.<Clip>;
      
      private var _wasPooled:Boolean = false;
      
      public function VortexPulseAnimation()
      {
         this._clips = new Vector.<Clip>();
         super();
         z = 99999;
         this.init();
      }
      
      public static function create(param1:int = 0) : VortexPulseAnimation
      {
         param1 = Math.max(0,Math.min(param1,3));
         var _loc2_:VortexPulseAnimation = Pool.get(VortexPulseAnimation);
         _loc2_._wasPooled = true;
         _loc2_.selectTier(param1);
         Main.instance.game.level.addEntity(_loc2_);
         return _loc2_;
      }
      
      private function init() : void
      {
         var _loc2_:Clip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = new Clip();
            _loc2_.initialise(VortexPulseGraphic,1,false,CLIP_SCALES[_loc1_]);
            this._clips.push(_loc2_);
            _loc1_++;
         }
      }
      
      public function selectTier(param1:int) : void
      {
         this._tierClip = this._clips[param1];
         this._tierClip.play();
      }
      
      override public function process(param1:Number) : void
      {
         super.process(param1);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this._tierClip.quickDraw(param1,x,y);
         this._tierClip.process();
         if(this._tierClip.frameIndex === this._tierClip.frameCount - 1)
         {
            this.clean();
         }
      }
      
      private function clean() : void
      {
         this._tierClip = null;
         Main.instance.game.level.cull(this);
         var _loc1_:int = 0;
         while(_loc1_ < this._clips.length)
         {
            this._clips[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
         if(this._wasPooled)
         {
            this._wasPooled = false;
            Pool.release(this);
         }
      }
   }
}
