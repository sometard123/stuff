package ninjakiwi.monkeyTown.pvp
{
   import ninjakiwi.data.TypeSafeStruct;
   
   public class Friend extends TypeSafeStruct
   {
       
      
      public var name:String = "Unnamed Opponent";
      
      public var userID:String = "";
      
      public var clan:String = "Clan Not Set";
      
      public var avatar:String;
      
      public var cities:Array;
      
      public var quickMatchID:String = "";
      
      public function Friend(param1:Object)
      {
         super();
         if(param1 === null)
         {
            return;
         }
         renameField(param1,"user_id","userID");
         renameField(param1,"username","name");
         populateFromDataObject(param1);
         if(param1.hasOwnProperty("quickMatchID"))
         {
            this.quickMatchID = param1.quickMatchID;
         }
      }
   }
}
