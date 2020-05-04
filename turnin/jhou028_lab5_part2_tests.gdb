# Test file for "Lab5_atmega1284Chip"


# commands.gdb provides the following functions for ease:
#   test "<message>"
#       Where <message> is the message to print. Must call this at the beginning of every test
#       Example: test "PINA: 0x00 => expect PORTC: 0x01"
#   checkResult
#       Verify if the test passed or failed. Prints "passed." or "failed." accordingly, 
#       Must call this at the end of every test.
#   expectPORTx <val>
#       With x as the port (A,B,C,D)
#       The value the port is epected to have. If not it will print the erroneous actual value
#   setPINx <val>
#       With x as the port or pin (A,B,C,D)
#       The value to set the pin to (can be decimal or hexidecimal
#       Example: setPINA 0x01
#   printPORTx f OR printPINx f 
#       With x as the port or pin (A,B,C,D)
#       With f as a format option which can be: [d] decimal, [x] hexadecmial (default), [t] binary 
#       Example: printPORTC d
#   printDDRx
#       With x as the DDR (A,B,C,D)
#       Example: printDDRB

echo ======================================================\n
echo Running all tests..."\n\n

test "PINA 0x01 => PORTC: 0x08, state: increment"

set state = init

print state
setPINA 0x01
continue 2

print state
expectPORTC 0x08
expect state increment
checkResult

# Test sequence continue !A1 && A0 => PORTC: 0x08
test "PINA 0x01 => PORTC: 0x08, state: increment"

print state
setPINA 0x01
continue 2

print state
expectPORTC 0x08
expect state increment
checkResult

# Test sequence from init: A1 && A0 => PORTC: 0x00
test "PINA 0x03 => PORTC: 0x00, state: reset"

set state = init

print state
setPINA 0x03
continue 2

print state
expectPORTC 0x00
expect state reset
checkResult

# Test sequence from init: (!A1 && A0) * 2, (!A1 && !A0), (!A1 && A0) * 2, (!A1 && !A0) => PORTC: 0x09
test "PINA 0x01, 0x01, 0x00, 0x01, 0x01, 0x00 => PORTC: 0x09, state: wait"

set state = init

print tmpC
print state
setPINA 0x01
continue 2

print tmpC
print state
setPINA 0x01
continue 2

print tmpC
print state
setPINA 0x00
continue 2

print tmpC
print state
setPINA 0x01
continue 2

print tmpC
print state
setPINA 0x01
continue 2

print tmpC
print state
setPINA 0x00
continue 2

print tmpC
print state
expectPORTC 0x09
expect state wait
checkResult

# Report on how many tests passed/tests ran
set $passed=$tests-$failed
eval "shell echo Passed %d/%d tests.\n",$passed,$tests
echo ======================================================\n
