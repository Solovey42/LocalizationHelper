tests_passed=0
tests_failed=0

function test() {

    test_name=$1
    params=$2
    expected_status=$3

    ./.build/debug/Run $params
    actual_status=$?

    if [ $actual_status -eq $expected_status ]
    then
    ((tests_passed++))
    echo -e "\033[32m$test_name passed \033[0m"
    else
    ((tests_failed++))
    echo -e "\033[31m$test_name failed \033[0m"
    fi
    echo

}

test "T1.1" "search" 0
test "T1.2" "search -q" 1
test "T1.3" "search -l rus"  0
test "T1.4" "search -k hello" 0
test "T1.5" "search -l rus -k day" 0
test "T1.6" "search -l ddd" 2
test "T1.7" "search -l rus -k ddd" 3
test "T1.8" "search -l rus -k terms" 4
test "T2.1" "update -q" 1
test "T2.2" "update приветули -l rus -k hello" 0
test "T2.3" "update приветули -l asd -k hello" 2
test "T2.4" "update приветули -l rus -k asd" 3
test "T2.5" "update приветули -l rus -k terms" 4
test "T3.1" "delete -q"  1
test "T3.2" "delete -k day" 0
test "T3.3" "delete -l rus" 0
test "T3.4" "delete -l pt -k terms" 0
test "T3.5" "delete -l hello" 2
test "T3.6" "delete -k ggg" 3
test "T3.7" "delete -l pt -k hhh" 3
test "T3.8" "delete -l pt -k hello" 4

echo "Tests passed: $tests_passed"
echo "Tests failed: $tests_failed"

if [ $tests_failed -eq 0 ]
then
exit 0
else
exit 1
fi
