scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

exchange=$1
symbol=$2
code=$3
file="full_exchange_test.md"

"${scripts_path}/test_fetch_funding_history.sh" $exchange $symbol
sleep 1
"${scripts_path}/test_fetch_my_trades.sh" $exchange $symbol
sleep 1
"${scripts_path}/test_fetch_ohlcv.sh" $exchange $symbol
sleep 1
"${scripts_path}/test_fetch_order_book.sh" $exchange $symbol
sleep 3
"${scripts_path}/test_fetch_positions.sh" $exchange $symbol
sleep 1
"${scripts_path}/test_fetch_trades.sh" $exchange $symbol
sleep 1
"${scripts_path}/test_order.sh" $exchange $symbol
sleep 1
"${scripts_path}/test_transfer.sh" $exchange $symbol
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