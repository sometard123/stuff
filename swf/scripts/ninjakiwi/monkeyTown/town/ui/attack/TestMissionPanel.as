package ninjakiwi.monkeyTown.town.ui.attack
{
   import assets.ui.TestMissionDetail;
   import assets.ui.TestMissionPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsData;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import org.osflash.signals.Signal;
   
   public class TestMissionPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:TestMissionPanelClip = new TestMissionPanelClip();
      
      private const _ok:ButtonControllerBase = new ButtonControllerBase(this._clip.attackButton);
      
      private const _cancel:ButtonControllerBase = new ButtonControllerBase(this._clip.cancelButton);
      
      private const _idList:Vector.<String> = new Vector.<String>();
      
      private const _list:Vector.<TickBox> = new Vector.<TickBox>();
      
      private var _lastSelectedID:String = "";
      
      private var _signal:Signal;
      
      public function TestMissionPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         var _loc4_:TestMissionDetail = null;
         var _loc5_:TickBox = null;
         super(param1,param2);
         this.isModal = true;
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._ok.setClickFunction(this.onAttack);
         this._cancel.setClickFunction(this.onCancel);
         var _loc3_:int = 0;
         while(_loc3_ < SpecialMissionsData.SPECIAL_MISSIONS.length)
         {
            _loc4_ = new TestMissionDetail();
            _loc4_.x = 78;
            _loc4_.y = 50 + _loc3_ * 20;
            _loc4_.scaleX = _loc4_.scaleY = 0.8;
            _loc4_.missionNameText.text = SpecialMissionsData.SPECIAL_MISSIONS[_loc3_].name;
            _loc5_ = new TickBox(_loc4_.missionSelectCheckBox);
            _loc5_.clickedSignal.add(this.onTick);
            this._list.push(_loc5_);
            this._idList.push(SpecialMissionsData.SPECIAL_MISSIONS[_loc3_].id);
            this._clip.addChild(_loc4_);
            _loc3_++;
         }
         this.onTick(this._list[0]);
      }
      
      private function onTick(param1:TickBox) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._list.length)
         {
            if(this._list[_loc2_] == param1)
            {
               this._list[_loc2_].ticked = true;
               this._lastSelectedID = this._idList[_loc2_];
            }
            else
            {
               this._list[_loc2_].ticked = false;
            }
            _loc2_++;
         }
      }
      
      public function setAttackSignal(param1:Signal) : void
      {
         this._signal = param1;
      }
      
      private function onAttack() : void
      {
         var _loc1_:int = 0;
         hide();
         if(this._signal != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._list.length)
            {
               if(this._list[_loc1_].ticked == true)
               {
                  MonkeyCityMain.getInstance().signals.btdGameRequestSet.addOnce(this.onSetRequest);
                  break;
               }
               _loc1_++;
            }
            this._signal.dispatch(true);
         }
      }
      
      private function onCancel() : void
      {
         hide();
      }
      
      private function onSetRequest(param1:BTDGameRequest) : void
      {
         param1.SpecialMissionID(this._lastSelectedID);
      }
   }
}
