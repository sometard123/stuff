package ninjakiwi.mynk
{
   public interface IStore
   {
       
      
      function showItem(param1:*) : void;
      
      function showItems(param1:Array) : void;
      
      function showStore(param1:Boolean = false) : void;
      
      function showSpecials() : void;
      
      function getItemInfo(param1:Array = null) : Array;
   }
}
