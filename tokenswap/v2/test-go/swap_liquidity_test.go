package tokenswap_example

import (
	"context"
	"encoding/hex"
	"fmt"
	"github.com/motoko9/aptos-go/aptos"
	"github.com/motoko9/aptos-go/rpc"
	"github.com/motoko9/aptos-go/rpcmodule"
	"github.com/motoko9/aptos-go/wallet"
	"testing"
)

func TestAddLiquidity(t *testing.T) {
	ctx := context.Background()

	// swap account
	swapWallet, err := wallet.LoadFromKeygenFile("account_swap")
	if err != nil {
		panic(err)
	}
	swapAddress := swapWallet.Address()
	fmt.Printf("swap rpcmodule publish address: %s\n", swapAddress)

	userWallet, err := wallet.LoadFromKeygenFile("account_user")
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

	// add liquidity
	// todo
	coin1 := aptos.CoinType[aptos.AptosCoin]
	coin2 := aptos.CoinType[aptos.USDTCoin]
	payload := rpcmodule.TransactionPayloadEntryFunctionPayload{
		Type:          rpcmodule.EntryFunctionPayload,
		Function:      fmt.Sprintf("%s::swap::add_liquidity", swapAddress),
		TypeArguments: []string{coin1, coin2},
		Arguments:     []interface{}{fmt.Sprintf("10000"), fmt.Sprintf("100000000"), fmt.Sprintf("10000"), fmt.Sprintf("100000000")},
	}
	txHash, aptosErr := client.SignAndSubmitTransaction(ctx, userAddress, account.SequenceNumber,
		&rpcmodule.TransactionPayload{
		Type:   rpcmodule.EntryFunctionPayload,
		Object: payload,
	}, userWallet)
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

func TestRemoveLiquidity(t *testing.T) {
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

	// remove liquidity
	// todo
	coin1 := aptos.CoinType[aptos.AptosCoin]
	coin2 := aptos.CoinType[aptos.USDTCoin]
	payload := rpcmodule.TransactionPayloadEntryFunctionPayload{
		Type:          rpcmodule.EntryFunctionPayload,
		Function:      fmt.Sprintf("%s::swap::remove_liquidity", swapAddress),
		TypeArguments: []string{coin1, coin2},
		Arguments:     []interface{}{"0", "0", "0"},
	}
	encodeSubmissionReq := rpcmodule.EncodeSubmissionReq(userAddress, account.SequenceNumber, &rpcmodule.TransactionPayload{
		Type:   "entry_function_payload",
		Object: payload,
	})

	// sign message
	signData, aptosErr := client.EncodeSubmission(ctx, encodeSubmissionReq)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// sign
	signature, err := userWallet.Sign(signData)
	if err != nil {
		panic(err)
	}

	// add signature
	submitReq := rpcmodule.SubmitTransactionReq(encodeSubmissionReq, rpcmodule.Signature{
		Type: "ed25519_signature",
		Object: rpcmodule.SignatureEd25519Signature{
			Type:      "ed25519_signature",
			PublicKey: "0x" + userWallet.PublicKey().String(),
			Signature: "0x" + hex.EncodeToString(signature),
		},
	})

	// submit
	txHash, aptosErr := client.SubmitTransaction(ctx, submitReq)
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
