//! account: alice, 1000000, 0
//! account: vivian, 1000000, 0, validator

//! sender: alice
module FooConfig {
    use 0x0::LibraConfig;

    struct T {
        version: u64,
    }

    public fun new(version: u64, account: &signer) {
        LibraConfig::publish_new_config<T>(T { version: version }, account);
    }

    public fun set(version: u64, account: &signer) {
        LibraConfig::set(
            T { version },
            account
        )
    }
}

//! block-prologue
//! proposer: vivian
//! block-time: 2

//! new-transaction
//! sender: config
// Publish a new config item.
script {
use {{alice}}::FooConfig;
fun main(account: &signer) {
    FooConfig::new(0, account);
}
}
// check: EXECUTED

//! block-prologue
//! proposer: vivian
//! block-time: 3

//! new-transaction
//! sender: config
// Update the value.
script {
use {{alice}}::FooConfig;
fun main(account: &signer) {
    FooConfig::set(0, account);
}
}
// Should trigger a reconfiguration
// check: NewEpochEvent
// check: EXECUTED

//! block-prologue
//! proposer: vivian
//! block-time: 4

//! new-transaction
//! sender: alice
script {
use {{alice}}::FooConfig;
fun main(account: &signer) {
    FooConfig::set(0, account);
}
}
// check: ABORT
