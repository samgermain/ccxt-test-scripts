scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

exchange=$1
symbol=$2

test_symbol_since_limit_tests fetch_funding_history $symbol $exchange
