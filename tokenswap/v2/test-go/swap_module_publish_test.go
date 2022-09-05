package tokenswap_example

import (
	"context"
	"fmt"
	"github.com/motoko9/aptos-go/aptos"
	"github.com/motoko9/aptos-go/rpc"
	"github.com/motoko9/aptos-go/wallet"
	"io/ioutil"
	"testing"
)

func TestSwapModulePublish(t *testing.T) {
	ctx := context.Background()

	// coin account
	wallet, err := wallet.NewFromKeygenFile("account_swap")
	if err != nil {
		panic(err)
	}
	address := wallet.Address()
	fmt.Printf("swap rpcmodule publish address: %s\n", wallet.Address())

	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// read move byte code
	content, err := ioutil.ReadFile("./swap.mv")
	if err != nil {
		panic(err)
	}

	// publish message
	txHash, aptosErr := client.PublishMoveModuleLegacy(ctx, address, content, wallet)
	if aptosErr != nil {
		panic(aptosErr)
	}
	//
	fmt.Printf("publish move rpcmodule transaction hash: %s\n", txHash)

	//
	confirmed, aptosErr := client.ConfirmTransaction(ctx, txHash)
	if aptosErr != nil {
		panic(aptosErr)
	}
	fmt.Printf("publish move rpcmodule transaction confirmed: %v\n", confirmed)
}
