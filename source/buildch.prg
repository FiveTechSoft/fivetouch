#include "FiveTouch.ch"

function Build_FiveTouch_CH()

   local cCode

   #define READ_CH
   #include "FiveTouch.ch"

   MemoWrit( "FiveTouch.ch", cCode )

return nil