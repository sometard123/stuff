package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.ui.PVPHistoryinfoBoxClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.ui.UIConstants;
   import org.osflash.signals.Signal;
   
   public class PVPHistoryInfoBox extends Sprite
   {
      
      private static var _selectedInstances:Dictionary = new Dictionary();
      
      private static const DEFAULT_SELECTION_GROUP:String = "default_selection_group";
      
      private static const selectedGlowFilter:GlowFilter = new GlowFilter(16777215,1,5,5,2000,1);
      
      private static const _system:MonkeySystem = MonkeySystem.getInstance();
       
      
      private var _clip:PVPHistoryinfoBoxClip;
      
      private var _data:Object = null;
      
      private var _selectionGroup:String = "default_selection_group";
      
      private var _clanHolder:MovieClip;
      
      public const selectedSignal:Signal = new Signal(Object);
      
      public function PVPHistoryInfoBox()
      {
         this._clip = new PVPHistoryinfoBoxClip();
         this._clanHolder = this._clip.clanContainer;
         super();
         addChild(this._clip);
         this.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
      }
      
      public function destroy() : void
      {
         var _loc1_:* = null;
         LGDisplayListUtil.getInstance().removeAllChildren(this);
         LGDisplayListUtil.getInstance().removeAllChildren(this._clip);
         LGDisplayListUtil.getInstance().removeAllChildren(this._clanHolder);
         this._clip = null;
         this._data = null;
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
         this._clanHolder = null;
         for(_loc1_ in _selectedInstances)
         {
            delete _selectedInstances[_loc1_];
         }
         _selectedInstances = null;
      }
      
      public function onClick(param1:Event) : void
      {
         this.select();
         this.selectedSignal.dispatch(this._data);
      }
      
      public function deselect() : void
      {
         this.filters = [];
      }
      
      public function select() : void
      {
         var _loc1_:PVPHistoryInfoBox = _selectedInstances[this._selectionGroup];
         if(_loc1_ !== null)
         {
            _loc1_.deselect();
         }
         _selectedInstances[this._selectionGroup] = this;
         this.filters = [selectedGlowFilter];
      }
      
      private function setWonView(param1:Boolean) : void
      {
         this._clip.youLostMessage.visible = !param1;
         this._clip.youWonMessage.visible = param1;
         this._clip.star.visible = param1;
         this._clip.skull.visible = !param1;
         this._clip.backgroundLight.visible = param1;
         this._clip.backgroundDark.visible = !param1;
      }
      
      private function setWasDefender(param1:Boolean) : void
      {
         this._clip.shield.visible = param1;
         this._clip.dart.visible = !param1;
      }
      
      private function setClan(param1:String) : void
      {
         while(this._clanHolder.numChildren > 0)
         {
            this._clanHolder.removeChildAt(0);
         }
         this._clanHolder.addChild(UIConstants.getClanIconSmall(param1));
      }
      
      public function syncToData(param1:Object) : void
      {
         var _loc2_:String = _system.nkGatewayUser.loginInfo.id;
         var _loc3_:* = param1.sender.userID === _loc2_;
         var _loc4_:* = !_loc3_;
         this._data = param1;
         var _loc5_:Boolean = _loc3_ && param1.resolution == "win" || _loc4_ && param1.resolution == "loss" || _loc3_ && param1.resolution == "expire";
         this.setWonView(_loc5_);
         this.setWasDefender(!_loc3_);
         var _loc6_:Object = !!_loc3_?param1.target:param1.sender;
         this.setClan(_loc6_.clan);
         this._clip.playerNameField.text = _loc6_.name == null?"":_loc6_.name;
         this._clip.levelField.text = _loc6_.cityLevel == null?"":_loc6_.cityLevel;
         var _loc7_:Date = new Date(param1.timeResolved);
         this._clip.dateField.htmlText = "<b>" + _loc7_.toString() + "</b>";
         if(param1.isNew)
         {
            this._clip.NewMessage.visible = true;
         }
         else
         {
            this._clip.NewMessage.visible = false;
         }
      }
   }
}
