package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.KickingOffPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class RemoteLoginMessage extends HideRevealView
   {
       
      
      private var _clip:KickingOffPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      public function RemoteLoginMessage(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new KickingOffPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         super(param1,param2);
         if(stage)
         {
            this.onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         this.isModal = true;
         addChild(this._clip);
         enableDefaultOnResize(this._clip);
         this._okButton.setClickFunction(hide);
      }
   }
}
