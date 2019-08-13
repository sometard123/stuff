package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import assets.ui.ReplayThumbnailClip;
   import flash.display.Bitmap;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class MyTrackThumbNailClip extends ReplayThumbnailClip
   {
      
      private static var _pool:Vector.<MyTrackThumbNailClip> = new Vector.<MyTrackThumbNailClip>();
      
      public static const trackSelected:Signal = new Signal(TrackData);
      
      {
         validateClasses();
      }
      
      public const thumbnail:Bitmap = new Bitmap();
      
      public var buttonControl:ButtonControllerBase;
      
      private var _trackData:TrackData;
      
      public function MyTrackThumbNailClip()
      {
         super();
         this.thumbnail.scaleX = 0.65;
         this.thumbnail.scaleY = 0.65;
         this.track_mc.addChild(this.thumbnail);
         this.name_txt.visible = false;
      }
      
      public static function getThumbNail(param1:TrackData, param2:Boolean = false) : MyTrackThumbNailClip
      {
         var _loc3_:MyTrackThumbNailClip = null;
         if(_pool.length > 0)
         {
            _loc3_ = _pool.pop();
         }
         _loc3_ = new MyTrackThumbNailClip();
         _loc3_.init(param1,param2);
         return _loc3_;
      }
      
      private static function validateClasses() : void
      {
      }
      
      public static function recycleThumbNail(param1:MyTrackThumbNailClip) : void
      {
         param1._trackData.releaseThumbnail();
         param1._trackData = null;
         if(param1.buttonControl != null)
         {
            param1.buttonControl.destroy();
            param1.buttonControl = null;
         }
         _pool.push(param1);
      }
      
      public function init(param1:TrackData, param2:Boolean = false) : void
      {
         this._trackData = param1;
         this.loadTrack(param2);
         if(this._trackData.unlocked && param2 == false)
         {
            this.buttonControl = new ButtonControllerBase(this);
            this.buttonControl.setClickFunction(this.onSelectTrack);
         }
         else
         {
            this.gotoAndStop(1);
         }
      }
      
      private function loadTrack(param1:Boolean = false) : void
      {
         this.thumbnail.bitmapData = this._trackData.loadThumbnail();
         if(this._trackData.unlocked || param1 == true)
         {
            this.lock_mc.visible = false;
         }
         else
         {
            this.lock_mc.visible = true;
         }
         if(this._trackData.played || param1 == true)
         {
            this.new_mc.visible = false;
         }
         else
         {
            this.new_mc.visible = true;
         }
         this.name_txt.text = this._trackData.trackName;
      }
      
      private function onSelectTrack() : void
      {
         trackSelected.dispatch(this._trackData);
      }
   }
}
