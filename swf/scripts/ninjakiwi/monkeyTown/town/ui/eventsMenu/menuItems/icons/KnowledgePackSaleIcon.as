package ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons
{
   import assets.ui.KnowledgeEventIconClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventItem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.ui.CountdownTimer;
   
   public class KnowledgePackSaleIcon extends MovieClip
   {
       
      
      private var _countdownTimer:CountdownTimer = null;
      
      private var _clip:KnowledgeEventIconClip;
      
      private var _saleItem:SaleEventItem = null;
      
      public var DisplayUtil:LGDisplayListUtil;
      
      public function KnowledgePackSaleIcon(param1:SaleEventItem)
      {
         this._clip = new KnowledgeEventIconClip();
         this.DisplayUtil = LGDisplayListUtil.getInstance();
         super();
         addChild(this._clip);
         this._countdownTimer = new CountdownTimer(this._clip.timeField,param1.endTime);
         this._saleItem = param1;
         this.selectIconFrame();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      private function addedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         this._countdownTimer.start();
         this.selectIconFrame();
      }
      
      private function removedFromStage(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         this._countdownTimer.stop();
      }
      
      public function selectIconFrame() : void
      {
         var _loc1_:String = this._saleItem.dataID;
         this._clip.addEventListener(Event.FRAME_CONSTRUCTED,this.onClipFrameConstructed);
         if(this.DisplayUtil.hasLabel(this._clip,_loc1_))
         {
            this._clip.gotoAndStop(_loc1_);
         }
         else
         {
            this._clip.gotoAndStop(1);
         }
      }
      
      private function onClipFrameConstructed(param1:Event) : void
      {
         this._clip.removeEventListener(Event.FRAME_CONSTRUCTED,this.onClipFrameConstructed);
         this._countdownTimer.setTextfield(this._clip.timeField);
      }
   }
}
