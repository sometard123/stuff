package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.PVPIncomingRaidInfoBoxClip;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   
   public class PVPIncomingRaidInfoBox extends PvPInfoBox
   {
      
      public static const selectionGroup:String = "raidInfoBoxGroup";
      
      private static const _pool:Vector.<PVPIncomingRaidInfoBox> = new Vector.<PVPIncomingRaidInfoBox>();
       
      
      private var _clip:PVPIncomingRaidInfoBoxClip;
      
      private var _timeRemainingField:TextField;
      
      public var incomingRaid:IncomingRaid;
      
      public function PVPIncomingRaidInfoBox()
      {
         this._clip = new PVPIncomingRaidInfoBoxClip();
         this._timeRemainingField = this._clip.timeRemainingField;
         super();
         super.setClip(this._clip);
         _selectionGroupID = selectionGroup;
      }
      
      public static function getInfoBox() : PVPIncomingRaidInfoBox
      {
         var _loc1_:PVPIncomingRaidInfoBox = null;
         if(_pool.length > 0)
         {
            _loc1_ = _pool.pop();
            _loc1_.setSelected(false);
            return _loc1_;
         }
         return new PVPIncomingRaidInfoBox();
      }
      
      public static function recycleInfoBox(param1:PVPIncomingRaidInfoBox) : void
      {
         if(_pool.indexOf(param1) == -1)
         {
            param1.reset();
            _pool.push(param1);
         }
      }
      
      public function setTimeRemaining(param1:String) : void
      {
         this._timeRemainingField.text = param1 + " Left";
      }
   }
}
