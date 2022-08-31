# TokenSwap

## Prerequisites

[Install Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli)

[Create an account and fund](https://aptos.dev/cli-tools/aptos-cli-tool/use-aptos-cli)

## Build Module

```
aptos move compile --package-dir . --named-addresses NamedAddr=0x65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e
```

```
{
  "Result": [
    "65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e::swap"
  ]
}
```

## Publish Module

```
aptos move publish --package-dir . --named-addresses NamedAddr=0x65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e
```

```
package size 2958 bytes
{
  "Result": {
    "transaction_hash": "0xb72255db9374dd74fb0f45d4056888d33c4c63f11515200d2ef0af10bdbbc168",
    "gas_used": 330,
    "gas_unit_price": 1,
    "sender": "65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e",
    "sequence_number": 0,
    "success": true,
    "timestamp_us": 1661852860814263,
    "version": 25760644,
    "vm_status": "Executed successfully"
  }
}
```

check publish successful.

```
aptos account list --query modules --account 0x65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e
```

we can see account modules.

```
{
  "Result": [
    {
      "bytecode": "0xa11ceb0b050000000e01000a020a0803125c046e10057e6707e501880208ed034006ad043610e304490aac05090bb505020cb705c4050dfb0a060e810b0600000101010201030104000508020001000100060001030606060007020102060600080301030606060009040500000a020103060606040e070800020f050500021005050001110b0101000112080e010003130701010003140b0101000215050500011608050100031711010100080a080c090d0a0d0b0d0d0a0d0c0e0d04060c060c03030003060c060c0305060c060c0303030303030301030e03030303030303030305070b00020900090103030301060c0105020900090101090003060c05030109010109020101030305070b00020900090104030305070b00020900090102060c03047377617004636f696e056572726f720c6d616e616765645f636f696e067369676e65720d4c6971756964697479506f6f6c0d6164645f6c697175696469747919636f696e315f746f5f636f696e325f737761705f696e7075740b6372656174655f706f6f6c0f6765745f696e7075745f70726963651072656d6f76655f6c697175696469747905636f696e3105636f696e320573686172650a616464726573735f6f6610696e76616c69645f617267756d656e74096e6f745f666f756e64087472616e736665721569735f6163636f756e745f72656769737465726564087265676973746572046d696e740e616c72656164795f6578697374730762616c616e6365046275726e65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e00000000000000000000000000000000000000000000000000000000000000010308000000000000000003080100000000000000052065631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e126170746f733a3a6d657461646174615f763035020000000000000000164552524f525f434f494e535741505f414444524553530001000000000000000a4552524f525f504f4f4c000002030b030c030d03000900010401000699010a0011050c0d0a0d070221030e0b01010b000107001106270a0d3b0003180b01010b0001070111072707023c000c0e0b020c080a080a0e370014180a0e3701141a0c100a100a0e370214180a0e3700141a0c0b0b030c0c0a0c0a0e370014180a0e3702141a0c110a110a0e370114180a0e3700141a0c090a080a0923034c054f0b080c0405510b090c040b040c070a0b0a0c230358055b0b0b0c05055d0b0c0c050b050c0a0a100a1123036405670b100c0605690b110c060b060c0f0a0e3701140a07160a0e3601150a0e3702140a0a160a0e3602150a0e3700140a0f160b0e3600150a010a0d0b0738000a010b0d0b0a38010a0111053802200391010593010a0138030b000b0111050b0f38040201010401000f3e0a0011050c040a04070221030e0b01010b000107001106270a043b0003180b01010b000107011107270a043c000c050a020a053701140a0537021411030c030a053701140a02160a053601150a053702140a03170b053602150a010b040b0238000b000b0111050b0338010202010400083b0a0011050c050a05070221030e0b01010b000107001106270a053b002003190b01010b00010701110c270a053805010a053806010a000a020a030a0439003f000a010a050b0238000a010b050b0338010a011105380220033305350a0138030b000b0111050b043804020300000004120b0006e503000000000000180c040a040b02180c050b0106e803000000000000180b04160c030b050b031a02040104010010550a0011050c050a05070221030e0b01010b000107001106270a053b0003180b01010b000107011107270b053c000c060a063701140a02180a063700141a0c030a063702140a02180a063700141a0c040a063701140a03170a063601150a063702140a04170a063602150a063700140a02170b063600150a000a0111050b0338000b000a0111050b0438010b010b0238070200020000000100090109020900",
      "abi": {
        "address": "0x65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e",
        "name": "swap",
        "friends": [],
        "exposed_functions": [
          {
            "name": "add_liquidity",
            "visibility": "public",
            "is_entry": true,
            "generic_type_params": [
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              },
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              },
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              }
            ],
            "params": [
              "&signer",
              "&signer",
              "u64",
              "u64"
            ],
            "return": []
          },
          {
            "name": "coin1_to_coin2_swap_input",
            "visibility": "public",
            "is_entry": true,
            "generic_type_params": [
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              },
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              }
            ],
            "params": [
              "&signer",
              "&signer",
              "u64"
            ],
            "return": []
          },
          {
            "name": "create_pool",
            "visibility": "public",
            "is_entry": true,
            "generic_type_params": [
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              },
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              },
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              }
            ],
            "params": [
              "&signer",
              "&signer",
              "u64",
              "u64",
              "u64"
            ],
            "return": []
          },
          {
            "name": "remove_liquidity",
            "visibility": "public",
            "is_entry": true,
            "generic_type_params": [
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              },
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              },
              {
                "constraints": [
                  "drop",
                  "store"
                ]
              }
            ],
            "params": [
              "&signer",
              "&signer",
              "u64"
            ],
            "return": []
          }
        ],
        "structs": [
          {
            "name": "LiquidityPool",
            "is_native": false,
            "abilities": [
              "key"
            ],
            "generic_type_params": [
              {
                "constraints": [],
                "is_phantom": true
              },
              {
                "constraints": [],
                "is_phantom": true
              }
            ],
            "fields": [
              {
                "name": "coin1",
                "type": "u64"
              },
              {
                "name": "coin2",
                "type": "u64"
              },
              {
                "name": "share",
                "type": "u64"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## initilize

Before swap, we have

three token: 

* 0x1::coin::CoinInfo<0x1685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08::usdt::USDT>
* 0x1::coin::CoinInfo<0x1::aptos_coin::AptosCoin>
* 0x1::coin::CoinInfo<0x65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e::lp::LP> (this is lp token, owner is swap account 0x65631df1ec5a46f37dcf64c4606e394e3e371a83b02072eb4c4c20d0795fe82e)

one user: 0x4a519d3be650792b231a3a7df67ac0dae825253a5dda929e111dbe46f78f1e49

* have two tokens usdt and aptos
* add liquidity、swap、remove liquidity

```
```

## ceate pool


## add liquidity


## swap


## remove liquidity


