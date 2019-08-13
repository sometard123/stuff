package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.MaintenancePanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MaintenancePanel extends HideRevealView
   {
       
      
      private const _clip:MaintenancePanelClip = new MaintenancePanelClip();
      
      private const _ok:ButtonControllerBase = new ButtonControllerBase(this._clip.okButton);
      
      public var forceStayOpen:Boolean = false;
      
      public function MaintenancePanel(param1:DisplayObjectContainer, param2:* = null)
      {
         super(param1,param2);
         this._ok.setClickFunction(this.hide);
         this.isModal = true;
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
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
      }
      
      public function setMessage(param1:String) : void
      {
         this._clip.message.text = param1;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         if(this.forceStayOpen)
         {
            return;
         }
         super.hide(param1);
      }
      
      public function setOKButtonVisible(param1:Boolean) : void
      {
         this._clip.okButton.visible = param1;
      }
   }
}
