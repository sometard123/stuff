package ninjakiwi.monkeyTown.ui
{
   import flash.display.MovieClip;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.town.ui.titleScreen.TitleScreen;
   import org.osflash.signals.Signal;
   
   public class MainMenuView extends MovieClip
   {
       
      
      public var titleScreen:TitleScreen;
      
      private var _currentView:HideRevealView;
      
      public var loginSelectedSignal:Signal;
      
      public var playAsGuestSelectedSignal:Signal;
      
      public var playGameSignal:Signal;
      
      public var newCitySignal:Signal;
      
      public var deleteSaveSignal:Signal;
      
      public function MainMenuView()
      {
         this.loginSelectedSignal = new Signal();
         this.playAsGuestSelectedSignal = new Signal();
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.titleScreen = new TitleScreen(this);
         this.playGameSignal = this.titleScreen.playGameSignal;
         this.deleteSaveSignal = this.titleScreen.deleteSaveSignal;
      }
      
      private function onLoginSelected() : void
      {
         navigateToURL(new URLRequest(Constants.NK_LOGIN_URL),"_blank");
         this.loginSelectedSignal.dispatch();
      }
      
      public function hide() : void
      {
         if(this._currentView)
         {
            this._currentView.hide();
         }
         this._currentView = null;
      }
      
      public function revealHomeScreen() : void
      {
         if(this._currentView !== this.titleScreen)
         {
            this.revealView(this.titleScreen);
         }
      }
      
      private function revealView(param1:HideRevealView) : void
      {
         this.hide();
         param1.reveal();
         this._currentView = param1;
      }
   }
}
