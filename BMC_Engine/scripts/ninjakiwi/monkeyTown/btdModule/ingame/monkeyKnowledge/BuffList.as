package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge
{
   public class BuffList
   {
       
      
      private var buffs:Vector.<Buff>;
      
      public function BuffList()
      {
         this.buffs = new Vector.<Buff>();
         super();
      }
      
      public function addBuffToList(param1:Buff) : void
      {
         this.buffs.push(param1);
      }
      
      public function getBuffsOfPath(param1:String) : Vector.<Buff>
      {
         var _loc2_:Vector.<Buff> = new Vector.<Buff>();
         var _loc3_:int = 0;
         while(_loc3_ < this.buffs.length)
         {
            if(this.buffs[_loc3_].buffPathID == param1)
            {
               _loc2_.push(this.buffs[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getBuffsOfMethod(param1:Class) : Vector.<Buff>
      {
         var _loc2_:Vector.<Buff> = new Vector.<Buff>();
         var _loc3_:int = 0;
         while(_loc3_ < this.buffs.length)
         {
            if(this.buffs[_loc3_].buffMethodModuleClass == param1)
            {
               _loc2_.push(this.buffs[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getBuffsOfMethodInPath(param1:Class, param2:String) : Vector.<Buff>
      {
         var _loc3_:Vector.<Buff> = new Vector.<Buff>();
         var _loc4_:int = 0;
         while(_loc4_ < this.buffs.length)
         {
            if(this.buffs[_loc4_].buffPathID == param2 && this.buffs[_loc4_].buffMethodModuleClass == param1)
            {
               _loc3_.push(this.buffs[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function removeBuffFromList(param1:Buff) : void
      {
         var _loc2_:int = this.buffs.indexOf(param1);
         if(-1 != _loc2_)
         {
            this.buffs.splice(_loc2_,1);
         }
      }
      
      public function clear() : void
      {
         this.buffs.length = 0;
      }
   }
}
