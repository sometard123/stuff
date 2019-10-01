package ninjakiwi.monkeyTown.ui.panelManager
{
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   
   public class FreePanelManager
   {
       
      
      private var _freePopups:Vector.<HideRevealView>;
      
      public function FreePanelManager()
      {
         this._freePopups = new Vector.<HideRevealView>();
         super();
      }
      
      public function showPopup(param1:HideRevealView) : void
      {
         param1.onHideSignal.addOnce(this.onPanelHide);
         if(this._freePopups.indexOf(param1) === -1)
         {
            this._freePopups.push(param1);
         }
         param1.reveal();
      }
      
      private function onPanelHide(param1:HideRevealView) : void
      {
         var _loc2_:int = this._freePopups.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._freePopups.splice(_loc2_,1);
         }
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._freePopups.length)
         {
            this._freePopups[_loc1_].hide(0);
            _loc1_++;
         }
         this._freePopups.length = 0;
      }
      
      public function hasOpenPanel() : Boolean
      {
         return this._freePopups.length > 0;
      }
   }
}
