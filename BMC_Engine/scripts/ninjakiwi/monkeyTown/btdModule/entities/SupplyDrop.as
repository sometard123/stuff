package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.projectile.BananaCrate;
   import assets.sound.CrateDrop;
   import assets.towers.OperationDartStorm;
   import display.Clip;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.utils.Rndm;
   
   public class SupplyDrop extends Entity
   {
       
      
      private var clip:Clip;
      
      private var start:Vector2 = null;
      
      private var end:Vector2 = null;
      
      private var flightTime:GameSpeedTimer;
      
      private var crateTimer:GameSpeedTimer;
      
      private var owner:Tower = null;
      
      public function SupplyDrop()
      {
         this.clip = new Clip();
         this.flightTime = new GameSpeedTimer(5);
         this.crateTimer = new GameSpeedTimer(1 + Rndm.random() * (this.flightTime.delay - 2));
         super();
      }
      
      public function initialise(param1:Tower) : void
      {
         var owner:Tower = param1;
         this.owner = owner;
         var levelBoundries:Rectangle = owner.level.boundries;
         this.start = new Vector2(levelBoundries.x,levelBoundries.y + 60 + Rndm.random() * (levelBoundries.height - 60));
         this.end = new Vector2(levelBoundries.right,levelBoundries.y + 60 + Rndm.random() * (levelBoundries.height - 60));
         this.clip.initialise(OperationDartStorm,1);
         this.clip.gotoLabel("Idle");
         this.flightTime.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            destroy();
            flightTime.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
         });
         this.crateTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            var _loc3_:Banana = new Banana();
            _loc3_.setIsFromSniperSupplyDrop(true);
            owner.level.addEntity(_loc3_);
            _loc3_.initialise(owner,Rndm.random() * 1000 + 500,10,BananaCrate);
            _loc3_.x = x;
            _loc3_.y = y;
            crateTimer.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
            new MaxSound(CrateDrop).play();
         });
         var tempRotation:Vector2 = new Vector2(this.end.x - this.start.x,this.end.y - this.start.y);
         rotation = tempRotation.rotation;
         z = 50;
      }
      
      override public function process(param1:Number) : void
      {
         x = this.start.x + (this.end.x - this.start.x) * (this.flightTime.current / this.flightTime.delay);
         y = this.start.y + (this.end.y - this.start.y) * (this.flightTime.current / this.flightTime.delay);
      }
      
      override public function draw(param1:BitmapData) : void
      {
         this.clip.drawRotated(param1,x,y,rotation);
      }
   }
}
