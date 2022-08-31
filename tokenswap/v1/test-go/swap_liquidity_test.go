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

	// swap Module account
	swapWallet, err := wallet.NewFromKeygenFile("account_swap")
	if err != nil {
		panic(err)
	}
	swapAddress := swapWallet.Address()
	fmt.Printf("swap module address: %s\n", swapAddress)

	// user account
	userWallet, err := wallet.NewFromKeygenFile("account_user")
	if err != nil {
		panic(err)
	}
	userAddress := userWallet.Address()
	fmt.Printf("user address: %s\n", userAddress)

	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// user account
	userAccount, aptosErr := client.Account(ctx, userAddress, 0)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// create pool
	coin1 := aptos.CoinType[aptos.AptosCoin]
	coin2 := aptos.CoinType[aptos.USDTCoin]
	lp := "0x65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e::lp::LP"
	payload := rpcmodule.TransactionPayloadEntryFunctionPayload{
		Type:          "entry_function_payload",
		Function:      fmt.Sprintf("%s::swap::add_liquidity", swapAddress),
		TypeArguments: []string{coin1, coin2, lp},
		Arguments:     []interface{}{
			fmt.Sprintf("%d", 10000),
			fmt.Sprintf("%d", 100000000),
		},
	}
	encodeSubmissionReq, err := rpcmodule.EncodeSubmissionWithSecondarySignersReq(
		userAddress, userAccount.SequenceNumber,
		rpcmodule.TransactionPayload{
			Type:   "entry_function_payload",
			Object: payload,
		},
		[]string{swapAddress},
	)
	if err != nil {
		panic(err)
	}

	// sign message
	signData, aptosErr := client.EncodeSubmission(ctx, encodeSubmissionReq)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// sign
	signature1, err := userWallet.Sign(signData)
	if err != nil {
		panic(err)
	}

	signature2, err := swapWallet.Sign(signData)
	if err != nil {
		panic(err)
	}

	// add signature
	submitReq, err := rpcmodule.SubmitTransactionReq(encodeSubmissionReq, rpcmodule.Signature{
		Type: rpcmodule.MultiAgentSignature,
		Object: rpcmodule.SignatureMultiAgentSignature{
			Type:      rpcmodule.MultiAgentSignature,
			Sender: rpcmodule.Signature{
				Type: rpcmodule.Ed25519Signature,
				Object: rpcmodule.SignatureEd25519Signature{
					Type:      rpcmodule.Ed25519Signature,
					PublicKey: "0x" + userWallet.PublicKey().String(),
					Signature: "0x" + hex.EncodeToString(signature1),
				},
			},
			SecondarySignerAddresses: []string{swapAddress},
			SecondarySigners: []rpcmodule.Signature{
				{
					Type: rpcmodule.Ed25519Signature,
					Object: rpcmodule.SignatureEd25519Signature{
						Type:      rpcmodule.Ed25519Signature,
						PublicKey: "0x" + swapWallet.PublicKey().String(),
						Signature: "0x" + hex.EncodeToString(signature2),
					},
				},
			},
		},
	})
	if err != nil {
		panic(err)
	}

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

func TestRemoveLiquidity(t *testing.T) {
	ctx := context.Background()

	// swap Module account
	swapWallet, err := wallet.NewFromKeygenFile("account_swap")
	if err != nil {
		panic(err)
	}
	swapAddress := swapWallet.Address()
	fmt.Printf("swap module address: %s\n", swapAddress)

	// user account
	userWallet, err := wallet.NewFromKeygenFile("account_user")
	if err != nil {
		panic(err)
	}
	userAddress := userWallet.Address()
	fmt.Printf("user address: %s\n", userAddress)

	// new rpc
	client := aptos.New(rpc.DevNet_RPC)

	// user account
	userAccount, aptosErr := client.Account(ctx, userAddress, 0)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// create pool
	coin1 := aptos.CoinType[aptos.AptosCoin]
	coin2 := aptos.CoinType[aptos.USDTCoin]
	lp := "0x65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e::lp::LP"
	payload := rpcmodule.TransactionPayloadEntryFunctionPayload{
		Type:          "entry_function_payload",
		Function:      fmt.Sprintf("%s::swap::remove_liquidity", swapAddress),
		TypeArguments: []string{coin1, coin2, lp},
		Arguments:     []interface{}{
			fmt.Sprintf("%d", 100),
		},
	}
	encodeSubmissionReq, err := rpcmodule.EncodeSubmissionWithSecondarySignersReq(
		userAddress, userAccount.SequenceNumber,
		rpcmodule.TransactionPayload{
			Type:   "entry_function_payload",
			Object: payload,
		},
		[]string{swapAddress},
	)
	if err != nil {
		panic(err)
	}

	// sign message
	signData, aptosErr := client.EncodeSubmission(ctx, encodeSubmissionReq)
	if aptosErr != nil {
		panic(aptosErr)
	}

	// sign
	signature1, err := userWallet.Sign(signData)
	if err != nil {
		panic(err)
	}

	signature2, err := swapWallet.Sign(signData)
	if err != nil {
		panic(err)
	}

	// add signature
	submitReq, err := rpcmodule.SubmitTransactionReq(encodeSubmissionReq, rpcmodule.Signature{
		Type: rpcmodule.MultiAgentSignature,
		Object: rpcmodule.SignatureMultiAgentSignature{
			Type:      rpcmodule.MultiAgentSignature,
			Sender: rpcmodule.Signature{
				Type: rpcmodule.Ed25519Signature,
				Object: rpcmodule.SignatureEd25519Signature{
					Type:      rpcmodule.Ed25519Signature,
					PublicKey: "0x" + userWallet.PublicKey().String(),
					Signature: "0x" + hex.EncodeToString(signature1),
				},
			},
			SecondarySignerAddresses: []string{swapAddress},
			SecondarySigners: []rpcmodule.Signature{
				{
					Type: rpcmodule.Ed25519Signature,
					Object: rpcmodule.SignatureEd25519Signature{
						Type:      rpcmodule.Ed25519Signature,
						PublicKey: "0x" + swapWallet.PublicKey().String(),
						Signature: "0x" + hex.EncodeToString(signature2),
					},
				},
			},
		},
	})
	if err != nil {
		panic(err)
	}

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
