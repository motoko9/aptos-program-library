module NamedAddr::swap {
    use std::signer;
    use std::error;
    use std::string;
    use std::option;
    use aptos_std::coin;
    use aptos_std::coins;

    /// Address of the owner of this module
    const Owner: address = @NamedAddr;

    const ERROR_COINSWAP_ADDRESS: u64 = 0;
    const ERROR_POOL: u64 = 1;
    const ERROR_ROUTER_Y_OUT_LESSTHAN_EXPECTED: u64 = 2;

    // pool liquidity token
    struct LiquidityToken<phantom CoinType1, phantom CoinType2> has key, store, copy, drop {
    }

    struct LiquidityTokenCapability<phantom CoinType1, phantom CoinType2> has key, store {
        mint: coin::MintCapability<LiquidityToken<CoinType1, CoinType2>>,
        freeze: coin::FreezeCapability<LiquidityToken<CoinType1, CoinType2>>,
        burn: coin::BurnCapability<LiquidityToken<CoinType1, CoinType2>>,
    }

    struct LiquidityPool<phantom CoinType1, phantom CoinType2> has key, store {
        coin1_reserve: coin::Coin<CoinType1>,
        coin2_reserve: coin::Coin<CoinType2>,
    }

    // Create a pool at @CoinSwap.
    public entry fun create_pool<CoinType1: drop + store, CoinType2: drop + store>(
        coinswap: &signer,
    ) {
        let coinswap_addr = signer::address_of(coinswap);
        assert!(coinswap_addr == Owner, error::invalid_argument(ERROR_COINSWAP_ADDRESS));
        assert!(!exists<LiquidityPool<CoinType1, CoinType2>>(coinswap_addr), error::already_exists(ERROR_POOL));
       
        // make liquidity pool
        move_to(coinswap, LiquidityPool<CoinType1, CoinType2>{
            coin1_reserve: coin::zero<CoinType1>(),
            coin2_reserve: coin::zero<CoinType2>(),
        });

        // register liquidity token
        let coinName1 = coin::name<CoinType1>();
        let coinName2 = coin::name<CoinType2>();
        let name = coinName1;
        string::append(&mut name, coinName2);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<LiquidityToken<CoinType1, CoinType2>>(
            coinswap, 
            name,
            name,
            6,
            true,
        );

        // save mint & burn capability for mint & burn liquidity token
        move_to(coinswap, LiquidityTokenCapability<CoinType1, CoinType2>{
            mint: mint_cap,
            burn: burn_cap,
            freeze: freeze_cap,
        });
    }

    fun get_reserves<CoinType1: drop + store, CoinType2: drop + store>(): (u64, u64) acquires LiquidityPool {
        let pool = borrow_global_mut<LiquidityPool<CoinType1, CoinType2>>(Owner);
        let reserve1 = coin::value(&pool.coin1_reserve);
        let reserve2 = coin::value(&pool.coin2_reserve);
        (reserve1, reserve2)
    }

    fun get_total_supply<CoinType: drop + store>(): u64 {
        let supply = coin::supply<CoinType>();
        // todo 
        let total_supply = option::extract(&mut supply);
        (total_supply as u64)
    }

    fun compute_y_out<CoinType1: copy + drop + store, CoinType2: copy + drop + store>(amount1_in: u64): u64 acquires LiquidityPool {
        // calculate actual y out
        // ignore fee,
        // todo
        // check......
        let (reserve1, reserve2) = get_reserves<CoinType1, CoinType2>();
        let denominator = reserve1 + amount1_in;
        let r = mul_div(reserve1, reserve2, denominator);
        reserve2 - r
    }

    fun swap_a_to_b<CoinType1: drop + store, CoinType2: drop + store>(
        coin1_in: coin::Coin<CoinType1>,
        value2_out: u64,
    ): (coin::Coin<CoinType2>) acquires LiquidityPool {
        //let value1_in = coin::value(&coin1_in);
        //let (reserve1, reserve2) = get_reservers<CoinType1, CoinType2>();
        let pool = borrow_global_mut<LiquidityPool<CoinType1, CoinType2>>(Owner);

        // deposit coin1 into pool
        coin::merge(&mut pool.coin1_reserve, coin1_in);

        // withdraw coin2 from pool
        let coin2_out = coin::extract(&mut pool.coin2_reserve, value2_out);

        //
        coin2_out
    }

    // only for swap coin1 to coin2
    // todo
    public entry fun swap<CoinType1: copy + drop + store, CoinType2: copy + drop + store> (
        account: &signer,
        amount1_in: u64,
        amount2_out_min: u64,
    ) acquires LiquidityPool {
        // sender need to accept swap coin
        if (!coin::is_account_registered<CoinType2>(signer::address_of(account))) {
            coins::register<CoinType2>(account);
        };

        //
        let amount2_out = compute_y_out<CoinType1, CoinType2>(amount1_in);
        assert!(amount2_out >= amount2_out_min, ERROR_ROUTER_Y_OUT_LESSTHAN_EXPECTED);

        // try to swap
        // withdraw coin1 from sender
        let coin1_in = coin::withdraw<CoinType1>(account, amount1_in);

        // deposit coin1 to pool and withdraw coin2 from pool
        let coin2_out = swap_a_to_b<CoinType1, CoinType2>(coin1_in, amount2_out);
       
       // deposit coin2 to sender
       coin::deposit(signer::address_of(account), coin2_out);
    }

    // need safemath
    // todo
    fun quote(amount_x: u64, reserve_x: u64, reserve_y: u64): u64 {
        let amount_y = mul_div(amount_x, reserve_y, reserve_x);
        amount_y
    }

    fun mul_div(x: u64, y: u64, z: u64): u64 {
        x * y / z
    }

    fun mul(x: u64, y: u64): u64 {
        x * y
    }

    fun sqrt(x: u64): u64 {
        x
    }

    fun calculate_amount_for_liquidity<CoinType1: drop + store, CoinType2: drop + store>(
        coin1_desired: u64,
        coin2_desired: u64,
        coin1_min: u64,
        coin2_min: u64,     
    ): (u64, u64) acquires LiquidityPool {
        let (reserve1, reserve2) = get_reserves<CoinType1, CoinType2>();
        if (reserve1 == 0 && reserve2 == 0) {
            return (coin1_desired, coin2_desired)
        };
        // todo
        // check......
        let amount_y_optimal = quote(coin1_desired, reserve2, reserve1);
        if (amount_y_optimal <= coin2_desired) {
            return (coin1_desired, amount_y_optimal)
        };
        let amount_x_optimal = quote(coin2_desired, reserve1, reserve2);
        return (amount_x_optimal, coin2_desired)
    }

    fun mint<CoinType1: drop + store, CoinType2: drop + store>(
        coin1: coin::Coin<CoinType1>,
        coin2: coin::Coin<CoinType2>,
    ): coin::Coin<LiquidityToken<CoinType1, CoinType2>> acquires LiquidityPool, LiquidityTokenCapability {
        // calcuate liquidity
        //let total_supply = coin::supply<LiquidityToken<CoinType1, CoinType2>>();
        let total_supply = get_total_supply<LiquidityToken<CoinType1, CoinType2>>();
        let (reserve1, reserve2) = get_reserves<CoinType1, CoinType2>();
        let amount1 = coin::value<CoinType1>(&coin1);
        let amount2 = coin::value<CoinType2>(&coin2);
        let liquidity = if (total_supply == 0) {
            sqrt(mul(amount1, amount2))
        } else {
            let liquidity1 = mul_div(amount1, total_supply, reserve1);
            let liquidity2 = mul_div(amount2, total_supply, reserve2);
            if (liquidity1 < liquidity2) {
               liquidity1 
            } else {
               liquidity2 
            }
        };

        // deposit swap coins into pool
        let pool = borrow_global_mut<LiquidityPool<CoinType1, CoinType2>>(Owner);
        coin::merge(&mut pool.coin1_reserve, coin1);
        coin::merge(&mut pool.coin2_reserve, coin2);

        // mint liquidity coin
        let liquidity_cap = borrow_global<LiquidityTokenCapability<CoinType1, CoinType2>>(Owner);
        let mint_token = coin::mint(liquidity, &liquidity_cap.mint);

        //
        mint_token
    }

    public entry fun add_liquidity<CoinType1: drop + store, CoinType2: drop + store>(
        account: &signer,
        coin1_desired: u64,
        coin2_desired: u64,
        coin1_min: u64,
        coin2_min: u64,
    ) acquires LiquidityPool, LiquidityTokenCapability {
        //
        let (amount1, amount2) = calculate_amount_for_liquidity<CoinType1, CoinType2>(
            coin1_desired,
            coin2_desired,
            coin1_min,
            coin2_min,
        );

        // withdraw swap coins from sender
        let coin1 = coin::withdraw<CoinType1>(account, amount1);
        let coin2 = coin::withdraw<CoinType2>(account, amount2);

        // deposit swap coins into pool and mint liquidity coin
        let liquidity_coin = mint(coin1, coin2);

        // try to deposit liquidity coin to sender
        if (!coin::is_account_registered<LiquidityToken<CoinType1, CoinType2>>(signer::address_of(account))) {
            coins::register<LiquidityToken<CoinType1, CoinType2>>(account);
        };
        coin::deposit(signer::address_of(account), liquidity_coin);
    }

    fun burn<CoinType1: drop + store, CoinType2: drop + store> (
        liquidity: coin::Coin<LiquidityToken<CoinType1, CoinType2>>,
    ): (coin::Coin<CoinType1>, coin::Coin<CoinType2>) acquires LiquidityPool, LiquidityTokenCapability {
        // calcuate amount
        let to_burn_value = coin::value(&liquidity);
        let pool = borrow_global_mut<LiquidityPool<CoinType1, CoinType2>>(Owner);
        let reserve1 = coin::value(&pool.coin1_reserve);
        let reserve2 = coin::value(&pool.coin2_reserve);
        //let total_supply = coin::supply<LiquidityToken<CoinType1, CoinType2>>();
        let total_supply = get_total_supply<LiquidityToken<CoinType1, CoinType2>>();
        let amount1 = mul_div(to_burn_value, reserve1, total_supply);
        let amount2 = mul_div(to_burn_value, reserve2, total_supply);
        
        // burn liquidity coin
        let liquidity_cap = borrow_global<LiquidityTokenCapability<CoinType1, CoinType2>>(Owner);
        coin::burn<LiquidityToken<CoinType1, CoinType2>>(liquidity, &liquidity_cap.burn);

        // withdraw swap coins from pool
        let coin1 = coin::extract(&mut pool.coin1_reserve, amount1);
        let coin2 = coin::extract(&mut pool.coin2_reserve, amount2);

        (coin1, coin2)
    }

    public entry fun remove_liquidity<CoinType1: drop + store, CoinType2: drop + store>(
        account: &signer,
        liquidity: u64,
        amount1_min: u64,
        amount2_min: u64,
    ) acquires LiquidityPool, LiquidityTokenCapability {
        // withdraw liquidity coin from sender
        let liquidity_coin = coin::withdraw<LiquidityToken<CoinType1, CoinType2>>(account, liquidity);

        // burn liquidity coin and withdraw swap coins from pool
        let (coin1, coin2) = burn(liquidity_coin);

        // deposit swap coins to sender
        coin::deposit(signer::address_of(account), coin1);
        coin::deposit(signer::address_of(account), coin2);
    }
}