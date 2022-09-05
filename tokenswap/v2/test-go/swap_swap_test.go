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

func TestSwap(t *testing.T) {
	ctx := context.Background()

	// swap account
	swapWallet, err := wallet.NewFromKeygenFile("account_swap")
	if err != nil {
		panic(err)
	}
	swapAddress := swapWallet.Address()
	fmt.Printf("swap rpcmodule publish address: %s\n", swapAddress)

	userWallet, err := wallet.NewFromKeygenFile("account_user")
	if err != nil {
		panic(err)
	}
	userAddress := userWallet.Address()
	fmt.Printf("user address: %s\n", userAddress)
	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// from account
	account, aptosErr := client.Account(ctx, userAddress, 0)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// swap
	// todo
	coin1 := aptos.CoinType[aptos.AptosCoin]
	coin2 := aptos.CoinType[aptos.USDTCoin]
	payload := rpcmodule.TransactionPayloadEntryFunctionPayload{
		Type:          rpcmodule.EntryFunctionPayload,
		Function:      fmt.Sprintf("%s::swap::swap", swapAddress),
		TypeArguments: []string{coin1, coin2},
		Arguments:     []interface{}{fmt.Sprintf("1000"), fmt.Sprintf("9523000")},
	}

	txHash, aptosErr := client.SignAndSubmitTransaction(ctx, userAddress, account.SequenceNumber,
		&rpcmodule.TransactionPayload{
			Type:   rpcmodule.EntryFunctionPayload,
			Object: payload,
		}, userWallet,
		)
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
