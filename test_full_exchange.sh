scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

exchange=$1
symbol=$2
code=$3
file="${scripts_path}/test_output/full_exchange_test.md"
ccxt_diagnostics > $file

# "${scripts_path}/test_fetch_funding_history.sh" $exchange $symbol
# "${scripts_path}/test_fetch_my_trades.sh" $exchange $symbol
# "${scripts_path}/test_fetch_ohlcv.sh" $exchange $symbol
# "${scripts_path}/test_fetch_order_book.sh" $exchange $symbol
# "${scripts_path}/test_fetch_positions.sh" $exchange $symbol
# "${scripts_path}/test_fetch_trades.sh" $exchange $symbol
# "${scripts_path}/test_order.sh" $exchange $symbol
# "${scripts_path}/test_transfer.sh" $exchange $symbol

printf "\n## createDepositAddress\n" >> $file
node $ccxt_path $exchange createDepositAddress $code 2>&1 >> $file
printf "\n## fetchAccounts\n" >> $file
node $ccxt_path $exchange fetchAccounts 2>&1 >> $file
printf "\n## fetchBalance\n" >> $file
node $ccxt_path $exchange fetchBalance 2>&1 >> $file
printf "\n## fetchDepositAddress\n" >> $file
node $ccxt_path $exchange fetchDepositAddress $code 2>&1 >> $file
printf "\n## fetchFundingFee\n" >> $file
node $ccxt_path $exchange fetchFundingFee $code 2>&1 >> $file
printf "\n## fetchFundingRate\n" >> $file
node $ccxt_path $exchange fetchFundingRate $symbol 2>&1 >> $file
printf "\n## fetchMarkets\n" >> $file
node $ccxt_path $exchange fetchMarkets 2>&1 | condense_output >> $file
printf "\n## fetchTicker\n" >> $file
node $ccxt_path $exchange fetchTicker $symbol 2>&1 >> $file
printf "\n## fetchTime\n" >> $file
node $ccxt_path $exchange fetchTime 2>&1 >> $file