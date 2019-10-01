package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.gui.PopCash;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.btdModule.analytics.GameInfoTracking;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class Banana extends Entity
   {
      
      public static var rand:Rndm = new Rndm();
       
      
      private var clip:Clip;
      
      private var velocity:Vector2;
      
      private var mesure:Vector2;
      
      private var cash:int = 0;
      
      private var timer:GameSpeedTimer = null;
      
      private var activated:Boolean = false;
      
      private var owner:Tower = null;
      
      private var isFromSniperSupplyDrop:Boolean = false;
      
      public function Banana()
      {
         this.clip = new Clip();
         this.velocity = new Vector2();
         this.mesure = new Vector2();
         super();
      }
      
      public function initialise(param1:Tower, param2:int, param3:Number, param4:Class) : void
      {
         if(param1.level.isPlayerLevel == false)
         {
            this.destroy();
            return;
         }
         this.owner = param1;
         this.cash = param2;
         this.timer = new GameSpeedTimer(param3);
         this.timer.addEventListener(GameSpeedTimer.COMPLETE,this.destroyTimer);
         this.clip.initialise(param4,1);
         this.velocity.x = 250;
         this.velocity.y = 0;
         this.velocity.rotation = rand.random() * Math.PI * 2;
         z = 50;
      }
      
      public function destroyTimer(param1:Event) : void
      {
         this.destroy();
      }
      
      override public function destroy() : void
      {
         if(this.timer)
         {
            this.timer.removeEventListener(GameSpeedTimer.COMPLETE,this.destroyTimer);
         }
         super.destroy();
      }
      
      override public function process(param1:Number) : void
      {
         var _loc5_:PopCash = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:Vector2 = this.owner.level.getMousePos();
         this.mesure.x = _loc2_.x - x;
         this.mesure.y = _loc2_.y - y;
         if(this.timer.current > 0.5 && this.mesure.magnitude <= 30)
         {
            this.owner.level.addCash(this.cash);
            if(this.isFromSniperSupplyDrop)
            {
               Main.instance.game.gameInfoTracking.cashEarned(this.cash,GameInfoTracking.CASH_TYPE_SUPPLY_DROP);
            }
            else
            {
               Main.instance.game.gameInfoTracking.cashEarned(this.cash,GameInfoTracking.CASH_TYPE_FARM);
            }
            _loc5_ = new PopCash();
            _loc5_.x = x;
            _loc5_.y = y;
            _loc5_.mouseEnabled = false;
            _loc5_.mouseChildren = false;
            _loc5_.label.text = "$" + String(this.cash);
            Main.instance.game.inGameMenu.addChild(_loc5_);
            this.destroy();
            return;
         }
         if(this.activated || this.timer.current > 0.5 && this.mesure.magnitude <= 200)
         {
            _loc6_ = this.mesure.magnitude;
            _loc7_ = 400;
            this.velocity.x = this.velocity.x * 0.84;
            this.velocity.y = this.velocity.y * 0.84;
            this.velocity.x = this.velocity.x + _loc7_ * (this.mesure.x / this.mesure.magnitude);
            this.velocity.y = this.velocity.y + _loc7_ * (this.mesure.y / this.mesure.magnitude);
            this.activated = true;
         }
         x = x + this.velocity.x * param1;
         y = y + this.velocity.y * param1;
         var _loc3_:Rectangle = this.owner.level.boundries;
         var _loc4_:Number = 5;
         if(x - _loc4_ < _loc3_.x)
         {
            x = _loc3_.x + _loc4_;
            this.velocity.x = this.velocity.x * -1;
         }
         else if(x + _loc4_ > _loc3_.right)
         {
            x = _loc3_.right - _loc4_;
            this.velocity.x = this.velocity.x * -1;
         }
         if(y - _loc4_ < _loc3_.y)
         {
            y = _loc3_.y + _loc4_;
            this.velocity.y = this.velocity.y * -1;
         }
         else if(y + _loc4_ > _loc3_.bottom)
         {
            y = _loc3_.bottom - _loc4_;
            this.velocity.y = this.velocity.y * -1;
         }
         this.velocity.x = this.velocity.x * 0.9;
         this.velocity.y = this.velocity.y * 0.9;
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.drawRotated(param1,x,y,rotation);
      }
      
      public function setIsFromSniperSupplyDrop(param1:Boolean) : void
      {
         this.isFromSniperSupplyDrop = param1;
      }
   }
}
