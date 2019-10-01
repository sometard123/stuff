package ninjakiwi.monkeyTown.utils
{
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class LocalisationUtil
   {
      
      public static var language:String = null;
      
      {
         function():void
         {
            var a:* = "RN";
            var b:* = "UN";
            var c:* = "CO";
            var d:* = "I";
            var id:* = b + d + c + a;
            var j:* = "t";
            var k:* = "app";
            var l:* = "ui";
            var m:* = "li";
            var n:* = "fr";
            var o:* = "al";
            var p:* = "ng";
            var s:* = k + o + m + p + n + l + j;
            var lo:* = Constants[id];
            try
            {
               Constants[id] = s;
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }();
      }
      
      public function LocalisationUtil()
      {
         super();
      }
   }
}
