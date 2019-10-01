package ninjakiwi.mynk.save
{
   public class EncodingDef
   {
       
      
      public var encodedName:String;
      
      public var decodedName:String;
      
      public var needsEncoding:Boolean;
      
      public function EncodingDef(param1:String, param2:String, param3:Boolean)
      {
         super();
         this.encodedName = param1;
         this.decodedName = param2;
         this.needsEncoding = param3;
      }
   }
}
