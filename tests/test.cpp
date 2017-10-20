#include <gtest/gtest.h>
#include <dlt.h>

DLT_DECLARE_CONTEXT(myContext1);

TEST(test1, case1)
{
   /* register application */
   DLT_REGISTER_APP("MAPP","Test Application for Logging");

   /* register all contexts */
   DLT_REGISTER_CONTEXT(myContext1,"TES1","Test Context 1 for Logging");

   /* Write your logs */
   DLT_LOG(myContext1,DLT_LOG_ERROR,DLT_INT(5),DLT_STRING("This is a error"));

   /* unregister your contexts */
   DLT_UNREGISTER_CONTEXT(myContext1);

   /* unregister your application */
   DLT_UNREGISTER_APP();
}
