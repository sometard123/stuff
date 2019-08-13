package ninjakiwi.monkeyTown.town.townMap
{
   import flash.display.BitmapData;
   
   public class TrackData
   {
       
      
      public var displayClass:Object;
      
      public var unlocked:Boolean = false;
      
      public var trackName:String;
      
      public var trackDefName:String;
      
      public var terrainID:String = "";
      
      public var terrainName:String = "";
      
      public var played:Boolean = false;
      
      private var _counter:int = 0;
      
      private var _bitmapData:BitmapData;
      
      public function TrackData()
      {
         super();
      }
      
      public function loadThumbnail() : BitmapData
      {
         if(this._counter <= 0)
         {
            this.destroyBitmapdata();
            try
            {
               this._bitmapData = new (this.displayClass as Class)();
            }
            catch(e:Error)
            {
            }
            this._counter = 0;
         }
         this._counter++;
         return this._bitmapData;
      }
      
      public function releaseThumbnail() : void
      {
         this._counter--;
         if(this._counter <= 0)
         {
            this.destroyBitmapdata();
            this._counter = 0;
         }
      }
      
      private function destroyBitmapdata() : void
      {
         if(this._bitmapData != null)
         {
            this._bitmapData.dispose();
         }
         this._bitmapData = null;
      }
      
      public function destory() : void
      {
         this.destroyBitmapdata();
         this.displayClass = null;
      }
   }
}
