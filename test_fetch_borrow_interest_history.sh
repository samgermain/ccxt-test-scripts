scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

function test_borrow_interest_history() {
    currency=$1
    symbol=$2
    since=$3
    limit=$4
    if [ ! -z $since ] && [ $since != undefined ]; then
        seconds=$(echo " $since / 1000 " | bc -l | sed -e 's/\..*//g' )
        d=$( date -u -r $seconds )
    fi
    echo "### currency=${currency} symbol=${symbol}, since=${since}, date=${d} limit=${limit}" >> $file
    echo '```' >> $file
    node $cli $exchange fetchBorrowInterestHistory $currency $symbol $since $limit 2>&1 | condense_output >> $file
    echo '```' >> $file
    echo "" >> $file
}

function test_borrow_interest_history_tests() {
    exchange=$1
    cur=$2
    sym=$3
    file="test-borrow-interest-history.md"
    ccxt_diagnostics > $file

    test_borrow_interest_history
    test_borrow_interest_history $cur
    test_borrow_interest_history undefined $sym
    test_borrow_interest_history $cur $sym
    test_borrow_interest_history $cur $sym 1638396000000
    test_borrow_interest_history $cur $sym undefined 20
    test_borrow_interest_history $cur $sym 1638396000000 3
}