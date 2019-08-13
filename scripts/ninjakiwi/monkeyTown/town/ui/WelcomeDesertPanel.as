package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.WelcomeDesertPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class WelcomeDesertPanel extends HideRevealView
   {
       
      
      private const SECOND_CITY_WELCOME_QUEST_STRING:String = "newCityWelcome";
      
      private var _clip:WelcomeDesertPanelClip;
      
      private var _adventureButton:ButtonControllerBase;
      
      public function WelcomeDesertPanel(param1:DisplayObjectContainer)
      {
         this._clip = new WelcomeDesertPanelClip();
         this._adventureButton = new ButtonControllerBase(this._clip.btnNewCity);
         super(param1);
         this.isModal = true;
         addChild(this._clip);
         this._adventureButton.setClickFunction(hide);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEnd);
      }
      
      private function onBuildWorldEnd() : void
      {
         var _loc1_:int = 0;
         if(MonkeySystem.getInstance().city.cityIndex == 1)
         {
            _loc1_ = int(QuestCounter.getInstance().getCustomValue(this.SECOND_CITY_WELCOME_QUEST_STRING));
            if(_loc1_ == 0)
            {
               PanelManager.getInstance().showPanel(this,null,0);
            }
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         QuestCounter.getInstance().setCustomValue(this.SECOND_CITY_WELCOME_QUEST_STRING,1);
         super.reveal(param1);
      }
   }
}
