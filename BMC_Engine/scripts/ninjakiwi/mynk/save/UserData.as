package ninjakiwi.mynk.save
{
   public class UserData extends SerialisableData
   {
      
      private static const PROPERTIES:Vector.<EncodingDef> = new <EncodingDef>[new EncodingDef("gxp","xp",false),new EncodingDef("gcash","cash",false),new EncodingDef("glevel","level",false),new EncodingDef("gnum","number",false),new EncodingDef("data","stuff",true)];
       
      
      public var xp:Number;
      
      public var cash:int;
      
      public var level:int;
      
      public var number:Number;
      
      public var stuff:Object;
      
      public function UserData(param1:Object = null)
      {
         this.xp = 0;
         this.cash = 0;
         this.level = 0;
         this.number = 0;
         this.stuff = {};
         super(PROPERTIES,param1);
      }
      
      public function isBlank() : Boolean
      {
         return equals(new UserData());
      }
   }
}
