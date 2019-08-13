package ninjakiwi.monkeyTown.town.ui.titleScreen
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.greensock.easing.Cubic;
   import com.lgrey.vectors.LGVector2D;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   
   public class NoticeBoard
   {
       
      
      private var _messageField:TextField;
      
      private var _messageTitleField:TextField;
      
      private var _clip:MovieClip;
      
      private var _messageHomePosition:LGVector2D;
      
      private const REVEAL_TIME:Number = 0.5;
      
      private const HIDE_TIME:Number = 0.5;
      
      public function NoticeBoard(param1:MovieClip)
      {
         this._messageHomePosition = new LGVector2D();
         super();
         this._clip = param1;
         this._messageField = param1.messageField;
         this._messageTitleField = param1.messageTitleField;
         this._messageHomePosition.set(this._clip.x,this._clip.y);
         GameMods.broadcastBonusMessageSignal.add(this.onBonusMessage);
         this.setTitle("");
         this.setMessage("");
      }
      
      private function onBonusMessage(param1:String, param2:String) : void
      {
         this.setTitle(param1);
         this.setMessage(param2);
         this.reveal();
      }
      
      public function setTitle(param1:String) : void
      {
         if(!this._messageTitleField || !param1)
         {
            return;
         }
         this._messageTitleField.htmlText = "<b>" + param1.toUpperCase() + "</b>";
      }
      
      public function setMessage(param1:String) : void
      {
         if(!this._messageField || !param1)
         {
            return;
         }
         this._messageField.htmlText = "<b>" + param1 + "<b/>";
      }
      
      public function reveal(param1:Number = 0.5) : void
      {
         this._clip.visible = true;
         TweenLite.to(this._clip,param1,{
            "x":this._messageHomePosition.x,
            "y":this._messageHomePosition.y,
            "ease":Back.easeOut
         });
      }
      
      public function hide(param1:Number = 0.5) : void
      {
         var time:Number = param1;
         TweenLite.to(this._clip,time,{
            "x":this._messageHomePosition.x,
            "y":this._messageHomePosition.y + 300,
            "ease":Cubic.easeIn,
            "onComplete":function():void
            {
               _clip.visible = true;
            }
         });
      }
   }
}
