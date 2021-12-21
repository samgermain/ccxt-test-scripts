scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

exchange=$1
currency=$2
file="${output_folder}/test_borrow_rate_history.md"

function test_borrow_rate_history() {
    since=$1
    limit=$2
    tier=$3
    if [ ! -z $tier ]; then
        params="{\"tier\": \"${tier}\"}"
    fi
    if [ ! -z $since ] && [ $since != undefined ]; then
        seconds=$(echo " $since / 1000 " | bc -l | sed -e 's/\..*//g' )
        d=$( date -u -r $seconds )
    fi
    echo "### currency=${currency}, since=${since}, date=${d} limit=${limit}, params=${params}" >> $file
    echo '```' >> $file
    node $ccxt_path $exchange fetchBorrowRateHistory $currency $since $limit "$params" 2>&1 | condense_output >> $file
    echo '```' >> $file
    echo "" >> $file
}

ccxt_diagnostics > $file

test_borrow_rate_history
test_borrow_rate_history undefined 93
test_borrow_rate_history undefined 94
test_borrow_rate_history undefined undefined 0
test_borrow_rate_history 1630141200000          # Sat 28 Aug 2021 09:00:00 UTC
test_borrow_rate_history 1630227600000          # Sun 29 Aug 2021 09:00:00 UTC
test_borrow_rate_history 1630227600000 20       # Sun 29 Aug 2021 09:00:00 UTC
test_borrow_rate_history 1630227600000 93 1     # Sun 29 Aug 2021 09:00:00 UTC
