package ninjakiwi.monkeyTown.town.ui.helpFromFriends
{
   import ninjakiwi.data.TypeSafeStruct;
   
   public class CrateStruct extends TypeSafeStruct
   {
       
      
      public var id:String;
      
      public var sender:String;
      
      public var receiver:String;
      
      public var senderName:String;
      
      public function CrateStruct(param1:Object)
      {
         super();
         populateFromDataObject(param1);
      }
   }
}
