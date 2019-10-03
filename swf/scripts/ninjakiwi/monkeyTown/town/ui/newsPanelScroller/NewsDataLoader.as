package ninjakiwi.monkeyTown.town.ui.newsPanelScroller
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.net.JSONRequest;
   import org.osflash.signals.Signal;
   
   public class NewsDataLoader
   {
      
      public static const dataLoadedSignal:Signal = new Signal();
      
      private static var _isReady:Boolean = false;
      
      private static var _data:Object = null;
       
      
      public function NewsDataLoader()
      {
         super();
      }
      
      private static function onDataLoaded(param1:Object) : void
      {
         _data = param1;
         _isReady = true;
         dataLoadedSignal.dispatch(param1);
      }
      
      public static function loadData() : void
      {
         var _loc1_:JSONRequest = new JSONRequest(Constants.NEWS_DATA_URL,null,onDataLoaded);
         _loc1_.go();
      }
      
      public static function get data() : Object
      {
         return _data;
      }
      
      public static function get isReady() : Boolean
      {
         return _isReady;
      }
   }
}
