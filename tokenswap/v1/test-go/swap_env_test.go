package tokenswap_example

import (
	"context"
	"fmt"
	"github.com/motoko9/aptos-go/aptos"
	"github.com/motoko9/aptos-go/faucet"
	"github.com/motoko9/aptos-go/rpc"
	"github.com/motoko9/aptos-go/wallet"
	"testing"
	"time"
)

func TestNewSwapAccount(t *testing.T) {
	ctx := context.Background()

	// new account
	wallet := wallet.New()
	wallet.Save("account_swap")
	address := wallet.Address()
	fmt.Printf("address: %s\n", address)

	// fund (max: 20000)
	amount := uint64(20000)
	hashes, err := faucet.FundAccount(address, amount)
	if err != nil {
		panic(err)
	}
	fmt.Printf("fund txs: %v\n", hashes)

	//
	time.Sleep(time.Second * 5)

	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// latest ledger
	ledger, err := client.Ledger(ctx)
	if err != nil {
		panic(err)
	}

	// check account
	balance, err := client.AccountBalance(ctx, address, aptos.AptosCoin, ledger.LedgerVersion)
	if err != nil {
		panic(err)
	}
	fmt.Printf("account balance: %d\n", balance)
}

func TestReadSwapAccount(t *testing.T) {
	ctx := context.Background()

	// new account
	wallet, err := wallet.NewFromKeygenFile("account_swap")
	if err != nil {
		panic(err)
	}
	address := wallet.Address()
	fmt.Printf("address: %s\n", address)
	fmt.Printf("public key: %s\n", wallet.PublicKey().String())
	fmt.Printf("private key: %s\n", wallet.PrivateKey.String())

	// fund (max: 20000)
	amount := uint64(20000)
	hashes, aptosErr := faucet.FundAccount(address, amount)
	if aptosErr != nil {
		panic(aptosErr)
	}
	fmt.Printf("fund txs: %v\n", hashes)

	//
	time.Sleep(time.Second * 5)

	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// latest ledger
	ledger, aptosErr := client.Ledger(ctx)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// check account
	balance, aptosErr := client.AccountBalance(ctx, address, aptos.AptosCoin, ledger.LedgerVersion)
	if aptosErr != nil {
		panic(aptosErr)
	}
	fmt.Printf("account balance: %d\n", balance)
}

func TestNewUserAccount(t *testing.T) {
	ctx := context.Background()

	// new account
	wallet := wallet.New()
	wallet.Save("account_user")
	address := wallet.Address()
	fmt.Printf("user address: %s\n", address)

	// fund (max: 20000)
	amount := uint64(20000)
	hashes, err := faucet.FundAccount(address, amount)
	if err != nil {
		panic(err)
	}
	fmt.Printf("fund txs: %v\n", hashes)

	//
	time.Sleep(time.Second * 5)

	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// latest ledger
	ledger, err := client.Ledger(ctx)
	if err != nil {
		panic(err)
	}

	// check account
	balance, err := client.AccountBalance(ctx, address, aptos.AptosCoin, ledger.LedgerVersion)
	if err != nil {
		panic(err)
	}
	fmt.Printf("account balance: %d\n", balance)
}

func TestReadUserAccount(t *testing.T) {
	ctx := context.Background()

	// new account
	wallet, err := wallet.NewFromKeygenFile("account_user")
	if err != nil {
		panic(err)
	}
	address := wallet.Address()
	fmt.Printf("address: %s\n", address)
	fmt.Printf("public key: %s\n", wallet.PublicKey().String())
	fmt.Printf("private key: %s\n", wallet.PrivateKey.String())

	// fund (max: 20000)
	amount := uint64(20000)
	hashes, aptosErr := faucet.FundAccount(address, amount)
	if aptosErr != nil {
		panic(aptosErr)
	}
	fmt.Printf("fund txs: %v\n", hashes)

	//
	time.Sleep(time.Second * 5)

	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// latest ledger
	ledger, aptosErr := client.Ledger(ctx)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// check account
	balance, aptosErr := client.AccountBalance(ctx, address, aptos.AptosCoin, ledger.LedgerVersion)
	if aptosErr != nil {
		panic(aptosErr)
	}
	fmt.Printf("account balance: %d\n", balance)
}
