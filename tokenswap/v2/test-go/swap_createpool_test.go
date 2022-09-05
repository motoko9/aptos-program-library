package tokenswap_example

import (
	"context"
	"fmt"
	"github.com/motoko9/aptos-go/aptos"
	"github.com/motoko9/aptos-go/rpc"
	"github.com/motoko9/aptos-go/rpcmodule"
	"github.com/motoko9/aptos-go/wallet"
	"testing"
)

func TestCreatePool(t *testing.T) {
	ctx := context.Background()

	// swap Module account
	swapWallet, err := wallet.LoadFromKeygenFile("account_swap")
	if err != nil {
		panic(err)
	}
	address := swapWallet.Address()
	fmt.Printf("move rpcmodule address: %s\n", address)

	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// from account
	account, aptosErr := client.Account(ctx, address, 0)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// create pool
	coin1 := aptos.CoinType[aptos.AptosCoin]
	coin2 := aptos.CoinType[aptos.USDTCoin]
	payload := rpcmodule.TransactionPayloadEntryFunctionPayload{
		Type:          rpcmodule.EntryFunctionPayload,
		Function:      fmt.Sprintf("%s::swap::create_pool", address),
		TypeArguments: []string{coin1, coin2},
		Arguments:     []interface{}{},
	}
	txHash, aptosErr := client.SignAndSubmitTransaction(ctx, address, account.SequenceNumber, &rpcmodule.TransactionPayload{
		Type:   rpcmodule.EntryFunctionPayload,
		Object: payload,
	},swapWallet)
	if aptosErr != nil {
		panic(aptosErr)
	}
	//
	fmt.Printf("transaction hash: %s\n", txHash)

	//
	confirmed, aptosErr := client.ConfirmTransaction(ctx, txHash)
	if aptosErr != nil {
		panic(aptosErr)
	}
	fmt.Printf("transaction confirmed: %v\n", confirmed)
}
