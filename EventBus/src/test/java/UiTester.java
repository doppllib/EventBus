/**
 * EventBus needs the main thread to be functional, but unit tests are called on the main thread in
 * ios, so we can't really run these on the command line. You'll need to run the app to see
 * unit tests run. They call this class, which runs the actual tests on a background thread.
 *
 * Created by kgalligan on 1/20/17.
 */
public class UiTester
{
    public static void runTests()
    {
        new Thread()
        {
            @Override
            public void run()
            {
                AllTests.runAllTests();
            }
        }.start();
    }
}
