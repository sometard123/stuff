package ninjakiwi.monkeyTown.btdModule.entities
{
   import assets.effects.CrateAnimation;
   import assets.effects.HelpFromFriendsPlaneFlyover;
   import assets.sound.AirDropCrate;
   import assets.sound.AirDropFlyBy;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   
   public class SupplyDropHelpFromFriends extends Sprite
   {
      
      public static var STARTING_CASH_MULTIPLIER:Number = 0.15;
      
      public static var CRATE_LIFETIME:Number = 10;
      
      public static var PLANE_COMPLETE:String = "PlaneComplete";
       
      
      private var _crateClip:MovieClip;
      
      private var _planeFlyoverClip:MovieClip;
      
      private var _interactiveCrate:SupplyCrate;
      
      private var _isCrateInteractive:Boolean;
      
      private const airDropFlyBySound:MaxSound = new MaxSound(AirDropFlyBy);
      
      private const airDropCrateSound:MaxSound = new MaxSound(AirDropCrate);
      
      public function SupplyDropHelpFromFriends()
      {
         this._crateClip = new CrateAnimation();
         this._planeFlyoverClip = new HelpFromFriendsPlaneFlyover();
         this._interactiveCrate = new SupplyCrate();
         super();
      }
      
      public function initialise(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
         this.z = 50;
         this.addChild(this._crateClip);
         this.addChild(this._planeFlyoverClip);
         this._planeFlyoverClip.x = this._planeFlyoverClip.x - param1;
         this._interactiveCrate.initialise(Main.instance.game.gameRequest.startingMoney * STARTING_CASH_MULTIPLIER,CRATE_LIFETIME,this,this.onCrateCollect);
         this.reset();
      }
      
      public function reset() : void
      {
         this._interactiveCrate.deactivate();
         this._isCrateInteractive = false;
         this._crateClip.gotoAndStop(1);
         this._crateClip.visible = false;
         this._planeFlyoverClip.gotoAndStop(1);
         this._planeFlyoverClip.visible = false;
         this._crateClip.removeEventListener("CrateImpact",this.onCrateImpact);
         this._crateClip.removeEventListener(Event.COMPLETE,this.onCrateAnimComplete);
         this._planeFlyoverClip.removeEventListener(Event.COMPLETE,this.onPlaneAnimComplete);
         Main.instance.game.level.removeEventListener(BloonEvent.ADD,this.dispatchPlane);
      }
      
      public function callDrop() : void
      {
         this.reset();
         Main.instance.usedCrateSignal.dispatch();
         Main.instance.game.level.addEventListener(BloonEvent.ADD,this.dispatchPlane);
      }
      
      private function dispatchPlane(param1:BloonEvent) : void
      {
         this._planeFlyoverClip.addEventListener(Event.COMPLETE,this.onPlaneAnimComplete);
         this._planeFlyoverClip.visible = true;
         this._planeFlyoverClip.play();
         this.airDropFlyBySound.play();
         Main.instance.game.level.removeEventListener(BloonEvent.ADD,this.dispatchPlane);
      }
      
      public function process(param1:Number) : void
      {
         if(false == this._isCrateInteractive)
         {
            return;
         }
         this._interactiveCrate.process(param1);
      }
      
      private function onCrateImpact(param1:Event) : void
      {
         this.airDropCrateSound.play();
         this._crateClip.removeEventListener("CrateImpact",this.onCrateImpact);
      }
      
      private function onCrateAnimComplete(param1:Event) : void
      {
         this._crateClip.removeEventListener(Event.COMPLETE,this.onCrateAnimComplete);
         this._crateClip.stop();
         this._interactiveCrate.activate();
         this._isCrateInteractive = true;
      }
      
      private function onPlaneAnimComplete(param1:Event) : void
      {
         this._planeFlyoverClip.removeEventListener(Event.COMPLETE,this.onPlaneAnimComplete);
         this._planeFlyoverClip.visible = false;
         this._planeFlyoverClip.stop();
         this._crateClip.addEventListener("CrateImpact",this.onCrateImpact);
         this._crateClip.addEventListener(Event.COMPLETE,this.onCrateAnimComplete);
         this._crateClip.visible = true;
         this._crateClip.play();
      }
      
      private function onCrateCollect() : void
      {
         this._crateClip.visible = false;
      }
      
      public function get isCrateInteractive() : Boolean
      {
         return this._isCrateInteractive;
      }
   }
}
