#Doppl Changes
UI related stuff removed. Error dialog and such.

## Issues
You can only run the unit tests visually in xcode, because we need main and background threads happening.

## Status
This compiles and the majority of the tests run fine. The only test disabled is verifying that weak references are deleted,
but memory is managed differently, so this may be pointless, or at least should be modified.

Memory leaks have not been tested. Due to the nature of how EventBus works, there are almost certainly going to be leaks.
Need to review code and address this before we can consider this usable production code.