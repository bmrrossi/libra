//! new-transaction
script {
use 0x0::TransactionFee;
fun main(account: &signer) {
    TransactionFee::initialize_transaction_fees(account);
}
}
// check: ABORTED
// check: 0

//! new-transaction
script {
use 0x0::LBR;
use 0x0::TransactionFee;
fun main() {
    TransactionFee::distribute_transaction_fees<LBR::T>();
}
}
// check: ABORTED
// check: 33
