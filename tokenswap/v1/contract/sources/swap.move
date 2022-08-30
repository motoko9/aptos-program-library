module NamedAddr::swap {
    use std::signer;
    use std::error;
    use aptos_std::coin;
    use aptos_std::managed_coin;

    /// Address of the owner of this module
    const Owner: address = @NamedAddr;

    const ERROR_COINSWAP_ADDRESS: u64 = 0;
    const ERROR_POOL: u64 = 1;

    struct LiquidityPool<phantom CoinType1, phantom CoinType2> has key {
        coin1: u64,
        coin2: u64,
        share: u64,
    }

    public entry fun create_pool<CoinType1: drop + store, CoinType2: drop + store, LpType: drop + store>(
        coinswap: &signer,
        requester: &signer,
        coin1: u64,
        coin2: u64,
        share: u64
    ) {
        let coinswap_addr = signer::address_of(coinswap);
        assert!(coinswap_addr == Owner, error::invalid_argument(ERROR_COINSWAP_ADDRESS));
        assert!(!exists<LiquidityPool<CoinType1, CoinType2>>(coinswap_addr), error::already_exists(ERROR_POOL));
        // Create a pool at @CoinSwap.
        coin::balance<CoinType1>(coinswap_addr);
        coin::balance<CoinType2>(coinswap_addr);
        move_to(coinswap, LiquidityPool<CoinType1, CoinType2>{
            coin1,
            coin2,
            share,
        });

        // Transfer the initial liquidity of CoinType1 and CoinType2 to the pool under @CoinSwap.
        coin::transfer<CoinType1>(requester, coinswap_addr, coin1);
        coin::transfer<CoinType2>(requester, coinswap_addr, coin2);

        // Mint PoolToken to requester.
        if (!coin::is_account_registered<LpType>(signer::address_of(requester))) {
            managed_coin::register<LpType>(requester);
        };
        managed_coin::mint<LpType>(coinswap, signer::address_of(requester), share);
    }

    fun get_input_price(input_amount: u64, input_reserve: u64, output_reserve: u64): u64 {
        let input_amount_with_fee = input_amount * 997;
        let numerator = input_amount_with_fee * output_reserve;
        let denominator = (input_reserve * 1000) + input_amount_with_fee;
        numerator / denominator
    }

    public entry fun coin1_to_coin2_swap_input<CoinType1: drop + store, CoinType2: drop + store> (
        coinswap: &signer,
        requester: &signer,
        coin1: u64
    ) acquires LiquidityPool {
        let coinswap_addr = signer::address_of(coinswap);
        assert!(coinswap_addr == Owner, error::invalid_argument(ERROR_COINSWAP_ADDRESS));
        assert!(exists<LiquidityPool<CoinType1, CoinType2>>(coinswap_addr), error::not_found(ERROR_POOL));

        //
        let pool = borrow_global_mut<LiquidityPool<CoinType1, CoinType2>>(coinswap_addr);
        let coin2 = get_input_price(coin1, pool.coin1, pool.coin2);
        pool.coin1 = pool.coin1 + coin1;
        pool.coin2 = pool.coin2 - coin2;

        //
        coin::transfer<CoinType1>(requester, coinswap_addr, coin1);
        coin::transfer<CoinType2>(coinswap, signer::address_of(requester), coin2);
    }

    public entry fun add_liquidity<CoinType1: drop + store, CoinType2: drop + store, LpType: drop + store>(
        coinswap: &signer,
        requester: &signer,
        coin1: u64,
        coin2: u64,
    ) acquires LiquidityPool {
        let coinswap_addr = signer::address_of(coinswap);
        assert!(coinswap_addr == Owner, error::invalid_argument(ERROR_COINSWAP_ADDRESS));
        assert!(exists<LiquidityPool<CoinType1, CoinType2>>(coinswap_addr), error::not_found(ERROR_POOL));

        let pool = borrow_global_mut<LiquidityPool<CoinType1, CoinType2>>(Owner);
        //
        let coin1_added_1 = coin1;
        let share_minted_1 = (coin1_added_1 * pool.share) / pool.coin1;
        let coin2_added_1 = (share_minted_1 * pool.coin2) / pool.share;

        let coin2_added_2 = coin2;
        let share_minted_2 = (coin2_added_2 * pool.share) / pool.coin2;
        let coin1_added_2 = (share_minted_2 * pool.coin1) / pool.share;

        let coin1_added = if (coin1_added_1 < coin1_added_2) { coin1_added_1 } else { coin1_added_2 };
        let coin2_added = if (coin2_added_1 < coin2_added_2) { coin2_added_1 } else { coin2_added_2 };
        let share_minted = if (share_minted_1 < share_minted_2) { share_minted_1 } else { share_minted_2 };

        pool.coin1 = pool.coin1 + coin1_added;
        pool.coin2 = pool.coin2 + coin2_added;
        pool.share = pool.share + share_minted;

        //
        coin::transfer<CoinType1>(requester, coinswap_addr, coin1_added);
        coin::transfer<CoinType2>(requester, coinswap_addr, coin2_added);
        // Mint PoolToken to requester.
        if (!coin::is_account_registered<LpType>(signer::address_of(requester))) {
            managed_coin::register<LpType>(requester);
        };
        managed_coin::mint<LpType>(coinswap, signer::address_of(requester), share_minted);
    }

    public entry fun remove_liquidity<CoinType1: drop + store, CoinType2: drop + store, LpType: drop + store>(
        coinswap: &signer,
        requester: &signer, 
        share: u64,     
    ) acquires LiquidityPool {
        let coinswap_addr = signer::address_of(coinswap);
        assert!(coinswap_addr == Owner, error::invalid_argument(ERROR_COINSWAP_ADDRESS));
        assert!(exists<LiquidityPool<CoinType1, CoinType2>>(coinswap_addr), error::not_found(ERROR_POOL));

        let pool = borrow_global_mut<LiquidityPool<CoinType1, CoinType2>>(coinswap_addr);
        //
        let coin1_removed = (pool.coin1 * share) / pool.share;
        let coin2_removed = (pool.coin2 * share) / pool.share;
        pool.coin1 = pool.coin1 - coin1_removed;
        pool.coin2 = pool.coin2 - coin2_removed;
        pool.share = pool.share - share;

        //
        coin::transfer<CoinType1>(coinswap, signer::address_of(requester), coin1_removed);
        coin::transfer<CoinType2>(coinswap, signer::address_of(requester), coin2_removed);
        managed_coin::burn<LpType>(requester, share);
    }
}