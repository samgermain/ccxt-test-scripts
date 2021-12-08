scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"
exchange=$1
symbol=$2
file="${output_folder}/fetch_ohlcv_test.md"

function test_fetch_ohlcv() {
    timeframe=$1
    since=$2
    limit=$3
    echo "### SYMBOL=${symbol}, TIMEFRAME=${timeframe}, SINCE=${since} AND LIMIT=${limit}" >> $file
    echo '```' >> $file
    node $ccxt_path $exchange fetchOHLCV $symbol $timeframe $since $limit  2>&1 | condense_output >> $file
    echo "" >> $file
    node $ccxt_path $exchange fetchMarkOHLCV $symbol $timeframe $since $limit  2>&1 | condense_output >> $file
    echo "" >> $file
    node $ccxt_path $exchange fetchIndexOHLCV $symbol $timeframe $since $limit  2>&1 | condense_output >> $file
    echo "" >> $file
    node $ccxt_path $exchange fetchPremiumIndexOHLCV $symbol $timeframe $since $limit  2>&1 | condense_output >> $file
    echo '```' >> $file
    echo "" >> $file
    echo "------------------------------------------------------------------------------------" >> $file
    echo "" >> $file
}


ccxt_diagnostics > $file

test_fetch_ohlcv
test_fetch_ohlcv "1h"
test_fetch_ohlcv undefined 1636420813000
test_fetch_ohlcv undefined undefined 10
test_fetch_ohlcv "1h" 1636420813000
test_fetch_ohlcv "1h" undefined 10
test_fetch_ohlcv undefined 1636420813000 10
test_fetch_ohlcv "1h" 1636420813000 10
