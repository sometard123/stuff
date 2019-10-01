package ninjakiwi.monkeyTown.town.ui.attack.crates
{
   import com.codecatalyst.promise.Promise;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class CrateGiveGetButtonController
   {
       
      
      private var _clip:CrateGiveGetButtonsClip;
      
      private var _crateSendsLeftCounterField:TextField;
      
      private var _crateManager:CrateManager;
      
      public function CrateGiveGetButtonController(param1:CrateGiveGetButtonsClip)
      {
         this._crateManager = CrateManager.getInstance();
         super();
         this._clip = param1;
         this.init();
      }
      
      private function init() : void
      {
         this._crateSendsLeftCounterField = this._clip.giveCrateButton.counter;
         CrateManager.dataChangedSignal.add(this.onCrateDataChangedSignal);
         this._clip.addEventListener(MouseEvent.ROLL_OVER,this.onGiveButtonRollover);
         this._clip.addEventListener(MouseEvent.ROLL_OUT,this.onGiveButtonRollout);
      }
      
      private function onGiveButtonRollover(param1:MouseEvent) : void
      {
         var _loc2_:int = this._crateManager.cratesAvailable();
         var _loc3_:int = this._crateManager.crateRequestsRemaining;
         var _loc4_:* = "";
         var _loc5_:String = _loc2_ === 1?"":"s";
         var _loc6_:String = _loc2_ === 1?"it":"them";
         if(_loc2_ > 0)
         {
            _loc4_ = "You have " + _loc2_.toString() + " Supply Crate" + _loc5_ + "." + " Attack a tile or Defend a Monkey v Monkey attack to use " + _loc6_ + ".";
         }
         else if(_loc3_ > 0)
         {
            _loc4_ = "You don\'t have any Supply Crates. Click \"Get\" to ask your friends for some.";
         }
         else
         {
            _loc4_ = "You\'ve used all of your Supply Crates. Come back tomorrow and you can get 3 more from friends.";
         }
         TownUI.showToolTipSignal.dispatch(_loc4_);
      }
      
      private function onGiveButtonRollout(param1:MouseEvent) : void
      {
         TownUI.hideToolTipSignal.dispatch();
      }
      
      private function onCrateDataChangedSignal() : void
      {
         this._crateSendsLeftCounterField.text = this._crateManager.crateSendsRemaining.toString();
      }
   }
}
