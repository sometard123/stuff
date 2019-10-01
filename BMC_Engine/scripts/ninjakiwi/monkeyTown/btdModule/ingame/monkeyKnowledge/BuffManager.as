package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge
{
   import assets.bloons.VortexEntryPortalTopClip;
   import display.Clip;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BuffMethodModuleList;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   
   public class BuffManager
   {
      
      public static const instance:BuffManager = new BuffManager();
       
      
      private var buffMethodModuleList:BuffMethodModuleList;
      
      private var buffList:BuffList;
      
      public function BuffManager()
      {
         this.buffMethodModuleList = new BuffMethodModuleList();
         this.buffList = new BuffList();
         super();
         if(Main.standalone)
         {
            MonkeyKnowledgeBuffData.getInstance().initialiseWithDebugData();
         }
      }
      
      public function reset() : void
      {
         this.buffList.clear();
      }
      
      public function buildListOfBuffsToActivate() : void
      {
         var _loc3_:MonkeyKnowledgePath = null;
         var _loc4_:int = 0;
         this.reset();
         var _loc1_:Vector.<MonkeyKnowledgePath> = MonkeyKnowledgeTree.getInstance().allPaths;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            if(Main.standalone)
            {
               _loc4_ = 1;
            }
            else
            {
               this.addBuffsForPath(_loc3_.id,_loc3_.rank);
            }
            _loc2_++;
         }
      }
      
      private function addBuffsForPath(param1:String, param2:int) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:Boolean = false;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc11_:Class = null;
         var _loc12_:Buff = null;
         var _loc3_:Object = MonkeyKnowledgeBuffData.getInstance().dataTable;
         if(false == _loc3_.hasOwnProperty(param1))
         {
            return;
         }
         var _loc4_:Object = _loc3_[param1];
         var _loc5_:int = 0;
         while(_loc5_ < param2)
         {
            _loc6_ = "rank" + (_loc5_ + 1) + "Value";
            _loc7_ = "rank" + (_loc5_ + 1) + "Method";
            _loc8_ = this.tableValidityCheck(param1,_loc4_,_loc6_,_loc7_);
            if(false != _loc8_)
            {
               _loc9_ = _loc4_[_loc6_];
               _loc10_ = _loc4_[_loc7_];
               _loc11_ = this.buffMethodModuleList.getBuffMethodModuleClass(_loc10_);
               _loc12_ = new Buff().BuffPathID(param1).BuffValue(_loc9_).BuffMethodModuleClass(_loc11_).HasBeenInvoked(false);
               this.buffList.addBuffToList(_loc12_);
            }
            _loc5_++;
         }
      }
      
      private function tableValidityCheck(param1:String, param2:Object, param3:String, param4:String) : Boolean
      {
         var _loc5_:Boolean = true;
         if(param1 == "WildCard")
         {
            return true;
         }
         if(false == param2.hasOwnProperty(param3))
         {
            _loc5_ = false;
         }
         if(false == param2.hasOwnProperty(param4))
         {
            _loc5_ = false;
         }
         if(false == _loc5_)
         {
            return false;
         }
         var _loc6_:Boolean = true;
         if(0 == param2[param3])
         {
            _loc6_ = false;
         }
         if("" == param2[param4])
         {
            _loc6_ = false;
         }
         return _loc6_;
      }
      
      public function activateBuffsOfPath(param1:String) : void
      {
         var _loc2_:Vector.<Buff> = this.buffList.getBuffsOfPath(param1);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            this.buffMethodModuleList.invokeBuffMethod(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      public function activateBuffsOfMethodInPath(param1:Class, param2:String) : void
      {
         var _loc3_:Vector.<Buff> = this.buffList.getBuffsOfMethodInPath(param1,param2);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            this.buffMethodModuleList.invokeBuffMethod(_loc3_[_loc4_]);
            _loc4_++;
         }
      }
   }
}
