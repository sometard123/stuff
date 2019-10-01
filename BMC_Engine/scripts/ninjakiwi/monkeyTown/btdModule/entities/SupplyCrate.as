package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.gui.PopCash;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.btdModule.analytics.GameInfoTracking;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class SupplyCrate
   {
      
      public static var rand:Rndm = new Rndm();
       
      
      private var crateSprite:Sprite;
      
      private var velocity:Vector2;
      
      private var distance:Vector2;
      
      private var cash:int = 0;
      
      private var activated:Boolean = false;
      
      private var moving:Boolean = false;
      
      private var onCollectFunction:Function;
      
      public function SupplyCrate()
      {
         this.velocity = new Vector2();
         this.distance = new Vector2();
         super();
      }
      
      public function initialise(param1:int, param2:Number, param3:Sprite, param4:Function) : void
      {
         this.cash = param1;
         this.crateSprite = param3;
         this.onCollectFunction = param4;
         this.activated = false;
         this.moving = false;
      }
      
      public function activate() : void
      {
         this.activated = true;
         this.moving = false;
      }
      
      public function deactivate() : void
      {
         this.activated = false;
         this.moving = false;
      }
      
      private function collect() : void
      {
         Main.instance.game.level.addCash(this.cash);
         Main.instance.game.gameInfoTracking.cashEarned(this.cash,GameInfoTracking.CASH_TYPE_HELP_FROM_FRIENDS);
         var _loc1_:PopCash = new PopCash();
         _loc1_.x = this.crateSprite.x;
         _loc1_.y = this.crateSprite.y;
         _loc1_.mouseEnabled = false;
         _loc1_.mouseChildren = false;
         _loc1_.label.text = "$" + String(this.cash);
         Main.instance.game.inGameMenu.addChild(_loc1_);
         this.activated = false;
         this.moving = false;
         this.onCollectFunction();
      }
      
      public function process(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(false == this.activated)
         {
            return;
         }
         var _loc2_:Vector2 = Main.instance.game.level.getMousePos();
         this.distance.x = _loc2_.x - this.crateSprite.x;
         this.distance.y = _loc2_.y - this.crateSprite.y;
         if(this.distance.magnitude <= 30)
         {
            this.collect();
            return;
         }
         if(this.moving || this.distance.magnitude <= 200)
         {
            _loc5_ = this.distance.magnitude;
            _loc6_ = 400;
            this.velocity.x = this.velocity.x * 0.84;
            this.velocity.y = this.velocity.y * 0.84;
            this.velocity.x = this.velocity.x + _loc6_ * (this.distance.x / this.distance.magnitude);
            this.velocity.y = this.velocity.y + _loc6_ * (this.distance.y / this.distance.magnitude);
            this.moving = true;
            this.crateSprite.x = this.crateSprite.x + this.velocity.x * param1;
            this.crateSprite.y = this.crateSprite.y + this.velocity.y * param1;
            var _loc3_:Rectangle = Main.instance.game.level.boundries;
            var _loc4_:Number = 5;
            if(this.crateSprite.x - _loc4_ < _loc3_.x)
            {
               this.crateSprite.x = _loc3_.x + _loc4_;
               this.velocity.x = this.velocity.x * -1;
            }
            else if(this.crateSprite.x + _loc4_ > _loc3_.right)
            {
               this.crateSprite.x = _loc3_.right - _loc4_;
               this.velocity.x = this.velocity.x * -1;
            }
            if(this.crateSprite.y - _loc4_ < _loc3_.y)
            {
               this.crateSprite.y = _loc3_.y + _loc4_;
               this.velocity.y = this.velocity.y * -1;
            }
            else if(this.crateSprite.y + _loc4_ > _loc3_.bottom)
            {
               this.crateSprite.y = _loc3_.bottom - _loc4_;
               this.velocity.y = this.velocity.y * -1;
            }
            this.velocity.x = this.velocity.x * 0.9;
            this.velocity.y = this.velocity.y * 0.9;
            return;
         }
      }
   }
}
