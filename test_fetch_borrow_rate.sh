scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

function test_borrow_rate() {
    exchange=$1
    method=$2
    echo "### exchange=${exchange}, method=${method} currency=${currency},  " >> $file
    echo '```' >> $file
    node $cli $exchange $method $currency 2>&1 | condense_output >> $file
    echo '```' >> $file
    echo "" >> $file
}

function test_borrow_rate_tests() {
    currency=$1
    file="${output_folder}/test_borrow_rate.md"
    ccxt_diagnostics > $file

    test_borrow_rate binance fetchBorrowRate
    test_borrow_rate ftx fetchBorrowRate
    test_borrow_rate ftx fetchBorrowRates
    test_borrow_rate gateio fetchBorrowRate
    test_borrow_rate okex fetchBorrowRate
    test_borrow_rate okex fetchBorrowRates
}
