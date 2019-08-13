package ninjakiwi.monkeyTown.debug
{
   import assets.ui.DebugDataEntryWindowClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   
   public class DebugEntryPane extends HideRevealView
   {
      
      private static var instance:DebugEntryPane;
       
      
      private var _clip:DebugDataEntryWindowClip;
      
      private var _okButton:ButtonControllerBase;
      
      private var _callback:Function = null;
      
      public function DebugEntryPane(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new DebugDataEntryWindowClip();
         super(param1,param2);
         instance = this;
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._okButton.setClickFunction(this.onOKButtonClicked);
      }
      
      public static function getInstance() : DebugEntryPane
      {
         return instance;
      }
      
      public function getData(param1:String, param2:String, param3:Function, param4:String = "") : void
      {
         this._clip.title.text = param1;
         this._clip.message.text = param2;
         this._clip.entryBox.text = param4;
         this._callback = param3;
         reveal();
      }
      
      private function onOKButtonClicked() : void
      {
         if(this._callback !== null)
         {
            this._callback(this._clip.entryBox.text);
         }
         hide();
      }
   }
}

class SingletonEnforcer#1988
{
    
   
   function SingletonEnforcer#1988()
   {
      super();
   }
}
