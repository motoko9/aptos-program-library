/// This module defines a minimal Coin and Balance.
module NamedAddr::usdc {
    use std::signer;
    use std::string;
    use aptos_std::event;

    /// Address of the owner of this module
    const MODULE_OWNER: address = @NamedAddr;

    /// Error codes
    const ENOT_MODULE_OWNER: u64 = 0;
    const EINSUFFICIENT_BALANCE: u64 = 1;
    const EALREADY_HAS_BALANCE: u64 = 2;

    struct Coin has store {
        value: u64,
    }

    /// Struct representing the balance of each address.
    struct CoinStore has key {
        coin: Coin,
        deposit_events: event::EventHandle<DepositEvent>,
        withdraw_events: event::EventHandle<WithdrawEvent>,
    }

    /// Information about a specific coin type. Stored on the creator of the coin's account.
    struct CoinInfo has key {
        name: string::String,
        /// Symbol of the coin, usually a shorter version of the name.
        /// For example, Singapore Dollar is SGD. 
        symbol: string::String,
        /// Number of decimals used to get its user representation.
        /// For example, if `decimals` equals `2`, a balance of `505` coins should
        /// be displayed to a user as `5.05` (`505 / 10 ** 2`).  
        decimals: u64,
        /// Amount of this coin type in existence.
        supply: u64, 
    }

    /// Event emitted when some amount of a coin is deposited into an account.
    struct DepositEvent has drop, store {
        amount: u64,
    }

    /// Event emitted when some amount of a coin is withdrawn from an account.
    struct WithdrawEvent has drop, store {
        amount: u64,
    }

    /// Returns the balance of `owner`.
    public fun balance_of(owner: address): u64 acquires CoinStore {
        borrow_global<CoinStore>(owner).coin.value
    }

    /// Returns `true` if `account_addr` is registered to receive.
    public fun is_account_registered(account: address): bool {
        exists<CoinStore>(account)
    }

    /// Returns the name of the coin.
    public fun name(): string::String acquires CoinInfo {
        borrow_global<CoinInfo>(MODULE_OWNER).name
    }

    /// Returns the symbol of the coin, usually a shorter version of the name.
    public fun symbol(): string::String acquires CoinInfo {
        borrow_global<CoinInfo>(MODULE_OWNER).symbol
    }

    /// Returns the number of decimals used to get its user representation.
    /// For example, if `decimals` equals `2`, a balance of `505` coins should
    /// be displayed to a user as `5.05` (`505 / 10 ** 2`).
    public fun decimals(): u64 acquires CoinInfo {
        borrow_global<CoinInfo>(MODULE_OWNER).decimals
    }

    /// Returns the amount of coin in existence.
    public fun supply(): u64 acquires CoinInfo {
        borrow_global<CoinInfo>(MODULE_OWNER).supply
    } 

    /// Publish an empty balance resource under `account`'s address. This function must be called before
    /// minting or transferring to the account.
    public fun register(account: &signer) {
        assert!(!exists<CoinStore>(signer::address_of(account)), EALREADY_HAS_BALANCE);
        let coin_store = CoinStore {
            coin:  Coin { value: 0 },
            deposit_events: event::new_event_handle<DepositEvent>(account),
            withdraw_events: event::new_event_handle<WithdrawEvent>(account),
        };
        move_to(account, coin_store);
    }

    /// Mint `amount` tokens to `mint_addr`. Mint must be approved by the module owner.
    public fun mint(account: &signer, to: address, amount: u64) acquires CoinStore, CoinInfo {
        // Only the owner of the module can initialize this module
        assert!(signer::address_of(account) == MODULE_OWNER, ENOT_MODULE_OWNER);

        // Deposit `amount` of tokens to `mint_addr`'s balance
        deposit(to, Coin { value: amount });

        // total supply
        let supply_ref = &mut borrow_global_mut<CoinInfo>(signer::address_of(account)).supply;
        *supply_ref = *supply_ref + amount;
    }

    /// Transfers `amount` of tokens from `from` to `to`.
    public fun transfer(from: &signer, to: address, amount: u64) acquires CoinStore {
        let check = withdraw(signer::address_of(from), amount);
        deposit(to, check);
    }

    /// Withdraw `amount` number of tokens from the balance under `addr`.
    fun withdraw(addr: address, amount: u64) : Coin acquires CoinStore {
        let balance = balance_of(addr);
        // balance must be greater than the withdraw amount
        assert!(balance >= amount, EINSUFFICIENT_BALANCE);

        let coin_store = borrow_global_mut<CoinStore>(addr);
        event::emit_event<WithdrawEvent>(
            &mut coin_store.withdraw_events,
            WithdrawEvent { amount },
        );

        let balance_ref = &mut coin_store.coin.value;
        *balance_ref = balance - amount;
        Coin { value: amount }
    }

    /// Deposit `amount` number of tokens to the balance under `addr`.
    fun deposit(addr: address, check: Coin) acquires CoinStore{
        let Coin { value } = check;
        let balance = balance_of(addr);
        //
        let coin_store = borrow_global_mut<CoinStore>(addr);
        event::emit_event<DepositEvent>(
            &mut coin_store.deposit_events,
            DepositEvent { amount : value },
        );

        let balance_ref = &mut coin_store.coin.value;
        *balance_ref = balance + value;
    }

    /// Creates a new Coin and returns minting/burning capabilities.
    /// The given signer also becomes the account hosting the information
    /// about the coin (name, supply, etc.).
    public fun initialize(account: &signer, name: string::String, symbol: string::String, decimals: u64) {
        // Only the owner of the module can initialize this module
        assert!(signer::address_of(account) == MODULE_OWNER, ENOT_MODULE_OWNER);

        let coin_info = CoinInfo {
            name,
            symbol,
            decimals,
            supply: 0,
        };
        move_to(account, coin_info);
    }

    #[test(account = @0x1)]
    #[expected_failure] // This test should abort
    fun mint_non_owner(account: signer) acquires CoinStore {
        // Make sure the address we've chosen doesn't match the module
        // owner address
        publish_balance(&account);
        assert!(signer::address_of(&account) != MODULE_OWNER, 0);
        mint(&account, @0x1, 10);
    }

    #[test(account = @NamedAddr)]
    fun mint_check_balance(account: signer) acquires CoinStore {
        let addr = signer::address_of(&account);
        publish_balance(&account);
        mint(&account, @NamedAddr, 42);
        assert!(balance_of(addr) == 42, 0);
    }

    #[test(account = @0x1)]
    fun publish_balance_has_zero(account: signer) acquires CoinStore {
        let addr = signer::address_of(&account);
        publish_balance(&account);
        assert!(balance_of(addr) == 0, 0);
    }

    #[test(account = @0x1)]
    #[expected_failure(abort_code = 2)] // Can specify an abort code
    fun publish_balance_already_exists(account: signer) {
        publish_balance(&account);
        publish_balance(&account);
    }

    #[test]
    #[expected_failure]
    fun balance_of_dne() acquires CoinStore {
        balance_of(@0x1);
    }

    #[test]
    #[expected_failure]
    fun withdraw_dne() acquires CoinStore {
        // Need to unpack the coin since `Coin` is a resource
        Coin { value: _ } = withdraw(@0x1, 0);
    }

    #[test(account = @0x1)]
    #[expected_failure] // This test should fail
    fun withdraw_too_much(account: signer) acquires CoinStore {
        let addr = signer::address_of(&account);
        publish_balance(&account);
        Coin { value: _ } = withdraw(addr, 1);
    }

    #[test(account = @NamedAddr)]
    fun can_withdraw_amount(account: signer) acquires CoinStore {
        publish_balance(&account);
        let amount = 1000;
        let addr = signer::address_of(&account);
        mint(&account, addr, amount);
        let Coin { value } = withdraw(addr, amount);
        assert!(value == amount, 0);
    }
}
