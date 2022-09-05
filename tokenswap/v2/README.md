# TokenSwap

## Prerequisites

[Install Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli)

[Create an account and fund](https://aptos.dev/cli-tools/aptos-cli-tool/use-aptos-cli)

## Build Module

```
aptos move compile --package-dir . --named-addresses NamedAddr=0x74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c
```

```
{
  "Result": [
    "74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c::swap"
  ]
}
```

## Publish Module

```
aptos move publish --package-dir . --named-addresses NamedAddr=0x74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c
```

```
package size 4911 bytes
{
  "Result": {
    "transaction_hash": "0x35de170126b9360c04e673ae8fc115e1717ce498a6ae6e6a6941e399830fa5c9",
    "gas_used": 543,
    "gas_unit_price": 1,
    "sender": "74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c",
    "sequence_number": 0,
    "success": true,
    "timestamp_us": 1662359983741639,
    "version": 61591476,
    "vm_status": "Executed successfully"
  }
}
```

check publish successful.

```
aptos account list --query modules --account 0x74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c
```

we can see account modules.

```
{
  "Result": [
    {
      "bytecode": "0xa11ceb0b050000000e01000e020e3a0348c8010490024605d602b703078d068e04089b0a4006db0a40109b0b6e0a890c380bc10c040cc50cf2060db713080ebf13080000010101020103010401050106000708020001000100080002000100010009080200010001010b04010001011c05010001011e05010001011f0501000106270700042e07010000000a0001020000000c0203020000000d0405020000000e0606020000000f0701020000001001050200000011010601000012030202000000130506000014080600001508060000160901020000001706060000000a0102000000180b0c0200000120101101000521071300012213150100032307010100012416010100012518060100010c1901010001261a11010002280606000229060600012a01110100012b011d0100062c1e0100012d1f200100012f012301000426250f0100013027010100011228110100020e0f0f0f12070e11141214131414140614140f14121514160f1612050e190f19121a0f1a121c141d0f1e241f0f1f1220140f14010e110f120f130f111212121312030e0e0e05060c0303030300010b03010b010209000901020b030109000b030109010403030303020303010301060c0303030304060c03030303060c0303020b0301090003010b030109010503030b030109000b030109010b03010b010209000901020900090101090002060c03010b030109000109010105010b010209000901010102050b030109000a03030b030109000b03010901060b020209000901070b0002090009010303030301060b03010900020b03010900060b0601090002070b03010900030501030303030b0b04010b0102090009010b06010b0102090009010b05010b010209000901060c0b06010b01020900090108070807050b05010b0102090009010b04010b010209000901080701080702070807080705060c080708070201030b060109000b050109000b0401090003070b0002090009010303020b08010404010b080104010401070b080109000d03030303030303060b0202090009010b03010b010209000901070b00020900090103030302070b030109000b030109000203060b04010900030b030109000b030109010b03010b01020900090103030b030109000b03010901020b03010901070b000209000901047377617004636f696e056572726f720c6d616e616765645f636f696e066f7074696f6e067369676e657206737472696e670d4c6971756964697479506f6f6c0e4c6971756964697479546f6b656e184c6971756964697479546f6b656e4361706162696c6974790d6164645f6c697175696469747904436f696e046275726e1e63616c63756c6174655f616d6f756e745f666f725f6c69717569646974790d636f6d707574655f795f6f75740b6372656174655f706f6f6c0c6765745f7265736572766573106765745f746f74616c5f737570706c79046d696e74036d756c076d756c5f6469760571756f74651072656d6f76655f6c697175696469747904737172740b737761705f615f746f5f620d636f696e315f726573657276650d636f696e325f726573657276650b64756d6d795f6669656c640e4d696e744361706162696c69747906667265657a6510467265657a654361706162696c6974790e4275726e4361706162696c6974790877697468647261770a616464726573735f6f661569735f6163636f756e745f72656769737465726564087265676973746572076465706f7369740576616c7565076578747261637406537472696e6710696e76616c69645f617267756d656e740e616c72656164795f657869737473047a65726f046e616d6506617070656e640a696e697469616c697a65064f7074696f6e06737570706c79056d6572676574f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c0000000000000000000000000000000000000000000000000000000000000001030800000000000000000308020000000000000003080100000000000000052074f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c126170746f733a3a6d657461646174615f76305a030000000000000000164552524f525f434f494e535741505f414444524553530001000000000000000a4552524f525f504f4f4c0002000000000000001b4552524f525f4f55545f4c4553535448414e5f455850454354454400000202190b030109001a0b030109010102011b01020203120b04010b0102090009011d0b05010b0102090009010c0b06010b010209000901000e020e0001040200020d200b010b020b030b0438000c060c050a000b0538010c070a000b0638020c080b070b0838030c090a0011103804200319051b0a0038050b0011100b09380602010000020002172e0e0038070c0938080c0a07033c000c060a06370038090c070a063701380a0c080a090b070a0a11090c010b090b080b0a11090c0207033d010c050b000b053702380b0a0636000b01380c0c030b0636010b02380d0c040b030b040202000001001b2a380e0c080c070a07060000000000000000210308050b080c04050f0a08060000000000000000210c040b04031205150b000b01020a000a070a08110a0c060a060a0125031f05220b000b06020a010b080b07110a0c050b050b010203000001000410380e0c040c030a030b00160c010b030a040b0111090c020b040b021702040104001c3f0a0011100c080a0807032103080509050e0b000107001117270b083b00200313051405190b000107021118270a00380f381039003f0038110c0638120c070b060c0b0d0b0b07111b0a000a0b0b0b31060838130c0a0c090c050b000c040b0a0c010b050c020b090c030b040b010b030b0239013f01020500000100210e07033c000c000a00370038090c010b003701380a0c020b010b020206000000220838140c000d0038150c010b013402070000020002264338080c0e380e0c0d0c0c0e0038090c040e01380a0c050a0e06000000000000000021031005160b040b051108110c0c03052c0b040a0e0b0c11090c070b050b0e0b0d11090c080a070a0823032505280b070c02052a0b080c020b020c030b030c0607033c000c0b0a0b36000b0038160b0b36010b01381707033d010c090b060b09370338180c0a0b0a020800000001040b000b0118020900000001060b000b01180b021a020a00000006070b000b020b0111090c030b03020b010402000229210a000b0138190c060b06381a0c050c040a001110381b20030e05100a00381c0a0011100b04381d0a001110381e20031a051c0a00381f0b0011100b053820020c00000001040b000640420f00000000001a020d010401002a2a0a001110381e20030605080a00381f0a0138210c030a030b02260310051105150b00010701270a000b0138010c040b040b0338220c050a001110381e20032305250a00381f0b0011100b053820020e000001002b0e07033c000c030a0336000b0038160b0336010b01380d0c020b02020000000102020200000e010e020e030e00",
      "abi": {
        "address": "0x74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c",
        "name": "swap",
        "friends": [],
        "exposed_functions": [
          {
            "name": "add_liquidity",
            "visibility": "public",
            "is_entry": true,
            "generic_type_params": [
              {
                "constraints": []
              },
              {
                "constraints": []
              }
            ],
            "params": [
              "&signer",
              "u64",
              "u64",
              "u64",
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
                "constraints": []
              },
              {
                "constraints": []
              }
            ],
            "params": [
              "&signer"
            ],
            "return": []
          },
          {
            "name": "remove_liquidity",
            "visibility": "public",
            "is_entry": true,
            "generic_type_params": [
              {
                "constraints": []
              },
              {
                "constraints": []
              }
            ],
            "params": [
              "&signer",
              "u64",
              "u64",
              "u64"
            ],
            "return": []
          },
          {
            "name": "swap",
            "visibility": "public",
            "is_entry": true,
            "generic_type_params": [
              {
                "constraints": []
              },
              {
                "constraints": []
              }
            ],
            "params": [
              "&signer",
              "u64",
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
                "name": "coin1_reserve",
                "type": "0x1::coin::Coin<T0>"
              },
              {
                "name": "coin2_reserve",
                "type": "0x1::coin::Coin<T1>"
              }
            ]
          },
          {
            "name": "LiquidityToken",
            "is_native": false,
            "abilities": [],
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
                "name": "dummy_field",
                "type": "bool"
              }
            ]
          },
          {
            "name": "LiquidityTokenCapability",
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
                "name": "mint",
                "type": "0x1::coin::MintCapability<0x74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c::swap::LiquidityToken<T0, T1>>"
              },
              {
                "name": "freeze",
                "type": "0x1::coin::FreezeCapability<0x74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c::swap::LiquidityToken<T0, T1>>"
              },
              {
                "name": "burn",
                "type": "0x1::coin::BurnCapability<0x74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c::swap::LiquidityToken<T0, T1>>"
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

two tokens on chain: 

* 0x1::coin::CoinInfo<0x1685cdc9a83c3da34c59208f34bddb3217f63bfbe0c393f04462d1ba06465d08::usdt::USDT>
* 0x1::coin::CoinInfo<0x1::aptos_coin::AptosCoin>

one user account: 0xe8b01f1d672f177926c56213196a719dabd142dd16ff1b9c033a9254a6ffd2e3

* have two tokens usdt and aptos
* add liquidity、swap、remove liquidity

```
```

## ceate pool

[create pool](./test-go/swap_createpool_test.go)

create pool by 0x74f3bbe39c7e2793a2e5445ee0336c9ac3191534762b41dcfc1054ad077ccc7c

transaction: 0xeeb05a309d5d2e521aff47eacc86befeb2419d686c2d3c71519d4764b7b51496

## add liquidity

[add liquidity](./test-go/swap_liquidity_test.go)

add liquidity by 0xe8b01f1d672f177926c56213196a719dabd142dd16ff1b9c033a9254a6ffd2e3

* transaction: 0xa0afddfed1675ca18396a257f174af527406fc1617e4fde62c1ea95ea5fea9bb
* transaction: 0x5928f1de9fa8c41f0fae5355c6387e06308f86b21e22eee132867bd3bcb2e4eb

## swap

[swap](./test-go/swap_swap_test.go)

* transaction: 0xbdd73da947bc3e8251f20f91fe03a6f6f576788be0012b8ce6836cb5f0b6e9b0


## remove liquidity


