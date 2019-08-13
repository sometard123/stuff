package ninjakiwi.monkeyTown.town.cityCommon
{
   public class CityCommonDataSlot
   {
       
      
      public var bucketID:int = 0;
      
      public var name:String;
      
      public var incomingAttacks:Array;
      
      public var cityLevel:int = 0;
      
      public function CityCommonDataSlot()
      {
         super();
      }
      
      public function clone() : CityCommonDataSlot
      {
         var _loc1_:CityCommonDataSlot = new CityCommonDataSlot();
         _loc1_.bucketID = this.bucketID;
         _loc1_.name = this.name;
         _loc1_.incomingAttacks = !!this.incomingAttacks?this.incomingAttacks:new Array();
         _loc1_.cityLevel = this.cityLevel;
         return _loc1_;
      }
   }
}
