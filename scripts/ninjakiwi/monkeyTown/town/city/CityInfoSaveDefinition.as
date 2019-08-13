package ninjakiwi.monkeyTown.town.city
{
   public class CityInfoSaveDefinition
   {
       
      
      public var name:String = "Unnamed City";
      
      public var cityIndex:int = 0;
      
      public var xp:int = 0;
      
      public var xpDebt:int = 0;
      
      public var cityLevel:int = 0;
      
      public var honour:int = 0;
      
      public function CityInfoSaveDefinition()
      {
         super();
      }
      
      public function clone() : CityInfoSaveDefinition
      {
         var _loc1_:CityInfoSaveDefinition = new CityInfoSaveDefinition();
         _loc1_.copy(this);
         return _loc1_;
      }
      
      public function copy(param1:CityInfoSaveDefinition) : void
      {
         var _loc2_:CityInfoSaveDefinition = new CityInfoSaveDefinition();
         this.name = param1.name;
         this.cityIndex = param1.cityIndex;
         this.xp = param1.xp;
         this.xpDebt = param1.xpDebt;
         this.cityLevel = param1.cityLevel;
         this.honour = param1.honour;
      }
   }
}
