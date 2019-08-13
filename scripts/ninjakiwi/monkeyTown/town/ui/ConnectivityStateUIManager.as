package ninjakiwi.monkeyTown.town.ui
{
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.net.RequestQueuer;
   
   public class ConnectivityStateUIManager
   {
       
      
      public function ConnectivityStateUIManager()
      {
         super();
         RequestQueuer.longTermConnectivityErrorSignal.add(this.onLongTermConnectivityErrorSignal);
         RequestQueuer.resetSignal.add(this.onResetSignal);
         RequestQueuer.underMaintainanceSignal.add(this.onUnderMaintainanceSignal);
         RequestQueuer.errorKickUserSignal.add(this.onErrorKickUserSignal);
         RequestQueuer.connectionLostSignal.add(this.onConnectionLostSignal);
         RequestQueuer.requestCompleteSignal.add(this.onRequestComplete);
         RequestQueuer.serverErrorSignal.add(this.onServerErrorSignal);
      }
      
      private function onLongTermConnectivityErrorSignal() : void
      {
         Main.instance.connectionLostPanel.hide();
         Main.instance.unLockReturnToHomeScreen();
         Main.instance.returnToHomeScreen();
      }
      
      private function onResetSignal(param1:Function) : void
      {
         Main.instance.connectionLostPanel.tryReconnectSignal.remove(param1);
      }
      
      private function onUnderMaintainanceSignal() : void
      {
         Main.instance.unLockReturnToHomeScreen();
         Main.instance.returnToHomeScreen();
      }
      
      private function onConnectionLostSignal(param1:Function) : void
      {
         Main.instance.connectionLostPanel.tryReconnectSignal.addOnce(param1);
         Main.instance.connectionLostPanel.reveal();
      }
      
      private function onErrorKickUserSignal() : void
      {
         Main.instance.unLockReturnToHomeScreen();
         Main.instance.returnToHomeScreen();
      }
      
      private function onRequestComplete() : void
      {
         Main.instance.connectionLostPanel.hide();
      }
      
      private function onServerErrorSignal(... rest) : void
      {
         Main.instance.connectionLostPanel.hide();
      }
   }
}
