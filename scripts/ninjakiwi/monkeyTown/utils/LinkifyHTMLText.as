package ninjakiwi.monkeyTown.utils
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class LinkifyHTMLText
   {
       
      
      public function LinkifyHTMLText()
      {
         super();
      }
      
      public static function linkifyTextfield(param1:TextField, param2:String, param3:String, param4:Boolean = true) : void
      {
         var _loc5_:TextFormat = param1.getTextFormat();
         _loc5_.url = param3;
         _loc5_.target = !!param4?"_blank":"_self";
         param1.text = param2;
         param1.setTextFormat(_loc5_);
      }
   }
}
