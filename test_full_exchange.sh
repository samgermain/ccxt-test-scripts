scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

exchange=$1
symbol=$2
code=$3
file="full_exchange_test.md"

source "${scripts_path}/test_fetch_funding_history.sh"
source "${scripts_path}/test_fetch_my_trades.sh"
source "${scripts_path}/test_fetch_ohlcv.sh"
source "${scripts_path}/test_fetch_order_book.sh"
source "${scripts_path}/test_fetch_positions.sh"
source "${scripts_path}/test_fetch_trades.sh"
source "${scripts_path}/test_order.sh"
source "${scripts_path}/test_transfer.sh"

test_fetch_funding_history_tests $exchange $symbol
sleep 1
test_fetch_my_trades_tests $exchange $symbol
sleep 1
test_fetch_ohlcv_tests $exchange $symbol
sleep 1
test_fetch_order_book_tests $exchange $symbol
sleep 3
test_fetch_positions_tests $exchange $symbol
sleep 1
test_fetch_trades_tests $exchange $symbol
sleep 1
test_order_book_tests $exchange $symbol
sleep 1
test_order_tests $exchange $symbol
sleep 1
test_transfer_tests $exchange $code
sleep 1

node $ccxt_path $exchange fetchAccounts >> $file
node $ccxt_path $exchange fetchMarkets >> $file
node $ccxt_path $exchange fetchTime >> $file
node $ccxt_path $exchange createDepositAddress $code >> $file
node $ccxt_path $exchange fetchDepositAddress $code >> $file
node $ccxt_path $exchange fetchTicker $symbol >> $file
node $ccxt_path $exchange fetchBalance >> $file
node $ccxt_path $exchange fetchFundingFee $code >> $file
node $ccxt_path $exchange fetchFundingRate $symbol >> $file