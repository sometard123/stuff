package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.town.data.GameModConstants;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.ui.NotificationUI;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   
   public class PvPNotifications
   {
       
      
      private var _resourceStore:ResourceStore;
      
      public function PvPNotifications()
      {
         this._resourceStore = ResourceStore.getInstance();
         super();
         this.init();
      }
      
      private function init() : void
      {
         PvPSignals.pvpDataUpdatedSignal.add(this.onDataUpdatedSignal);
      }
      
      private function onDataUpdatedSignal(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc4_:NotificationUI = TownUI.getInstance().notificationUI;
         var _loc5_:Array = param1.battleHistory;
         if(_loc5_ == null)
         {
            return;
         }
         if(_loc5_.length > 0)
         {
            _loc6_ = _loc5_.length - 1;
            while(_loc6_ >= 0)
            {
               _loc7_ = _loc5_[_loc6_];
               if(_loc7_.sender.userID == Kloud.userID)
               {
                  if(_loc7_.resolution == "win" || _loc7_.resolution == "expire")
                  {
                     _loc8_ = "Your Bloon attack beat " + _loc7_.target.name;
                     _loc9_ = int(_loc7_.cashPillage);
                     if(_loc7_.info != null && _loc7_.info.attackerCashReward != null)
                     {
                        _loc9_ = int(_loc7_.info.attackerCashReward);
                     }
                     _loc9_ = _loc9_ * GameMods.getModifier(GameModConstants.CASH_EARNED_MOD);
                     _loc8_ = _loc8_ + (" and pillaged " + _loc9_ + " city cash from them.");
                     _loc4_.addMessage(_loc8_,true);
                  }
                  else
                  {
                     _loc4_.addMessage(_loc7_.target.name + " fought off your Bloon attack",true);
                  }
               }
               _loc6_--;
            }
         }
      }
   }
}
