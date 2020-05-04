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

test "PINA 0x01 => PORTC: 0x08, state: sq_1_2"

set state = Start

print state
setPINA 0x01
continue 2

print state
expectPORTB 0x2A
expect state sq_1_2
checkResult

# Test sequence continue !A1 && A0 => PORTB: 0x08
test "PINA 0x01 => PORTB: 0x08, state: increment"

print state
print PORTB
setPINA 0x01
continue 5

print state
expectPORTB 0x08
expect state increment
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
