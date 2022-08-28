# Token

## Prerequisites

[Install Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli)

[Create an account and fund](https://aptos.dev/cli-tools/aptos-cli-tool/use-aptos-cli)

## Build Module

```
aptos move compile --package-dir . --named-addresses NamedAddr=0xf0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a
```

```
{
  "Result": [
    "f0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a::usdc"
  ]
}
```

## Publish Module

```
aptos move publish --package-dir . --named-addresses NamedAddr=0xf0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a
```

```
package size 3652 bytes
{
  "Result": {
    "transaction_hash": "0xb7224ef9e2bbe451e8ab7965e1f727ead5643bc394f61ed05bdaff9ee9d17992",
    "gas_used": 406,
    "gas_unit_price": 1,
    "sender": "f0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a",
    "sequence_number": 0,
    "success": true,
    "timestamp_us": 1661652056334521,
    "version": 10990987,
    "vm_status": "Executed successfully"
  }
}
```

check publish successful.

```
aptos account list --query modules --account 0xf0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a
```

we can see account modules.

```
{
  "Result": [
    {
      "bytecode": "0xa11ceb0b050000000c01000a020a1e03284d047508057d5107ce01af0208fd034006bd044010fd04780af5052e0ca306f5020d980910000001010102010301040005040000060800000708000008060000090600040d0700021a04010601000a000100000b020100000c030200000e040200000f0005000010060200001102070000120802000013020100001402070000150602000016090a00021d0d020106031e080000011f081101060c0c0e0c0e120c1201050103000205080004060c0805080503010103060c050301080501060c020503010800040307030708020301080302070b060109000900010801010703010802010b06010900010804030307030708020475736463076163636f756e74056576656e74067369676e657206737472696e6704436f696e08436f696e496e666f09436f696e53746f72650c4465706f7369744576656e740d57697468647261774576656e740a62616c616e63655f6f6608646563696d616c73076465706f73697406537472696e670a696e697469616c697a651569735f6163636f756e745f72656769737465726564046d696e74046e616d6508726567697374657206737570706c790673796d626f6c087472616e736665720877697468647261770576616c756504636f696e0e6465706f7369745f6576656e74730b4576656e7448616e646c650f77697468647261775f6576656e747306616d6f756e740a656d69745f6576656e740a616464726573735f6f66106e65775f6576656e745f68616e646c65f0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a00000000000000000000000000000000000000000000000000000000000000010308020000000000000003080100000000000000030800000000000000000520f0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a126170746f733a3a6d657461646174615f76306403000000000000000011454e4f545f4d4f44554c455f4f574e45520b4572726f7220636f64657301000000000000001545494e53554646494349454e545f42414c414e43450002000000000000001445414c52454144595f4841535f42414c414e43450000020117030102041108051408050b031303020203180800190b060108031b0b060108040302011c030402011c03000100010202060b002b021000100114020101000101020507032b011002140202000001020b180b0113000c050a0011000c020b002a020c040a040f030a05120338000b040f000f010c030b020b05160b031502030100000e130a00110d07032103090b00010702270b010b020b0306000000000000000012010c040b000b042d01020401000002030b002902020501000201020f190a00110d07032103090b00010702270b010a02120011020b00110d2a010f040c030a03140b02160b0315020601000101020507032b01100514020701000010150a00110d29022003090b000107002706000000000000000012000a0038010a00380212020c010b000b012d02020801000101020507032b01100414020901000101020507032b01100614020a010001020a090b00110d0b02110b0c030b010b031102020b00000102131d0a0011000c020a020a012603090701270b002a020c040a040f070a01120438030b040f000f010c030b020a01170b03150b011200020200000001020201010301000101020200",
      "abi": {
        "address": "0xf0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a",
        "name": "usdc",
        "friends": [],
        "exposed_functions": [
          {
            "name": "balance_of",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [
              "address"
            ],
            "return": [
              "u64"
            ]
          },
          {
            "name": "decimals",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [],
            "return": [
              "u64"
            ]
          },
          {
            "name": "initialize",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [
              "&signer",
              "0x1::string::String",
              "0x1::string::String",
              "u64"
            ],
            "return": []
          },
          {
            "name": "is_account_registered",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [
              "address"
            ],
            "return": [
              "bool"
            ]
          },
          {
            "name": "mint",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [
              "&signer",
              "address",
              "u64"
            ],
            "return": []
          },
          {
            "name": "name",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [],
            "return": [
              "0x1::string::String"
            ]
          },
          {
            "name": "register",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [
              "&signer"
            ],
            "return": []
          },
          {
            "name": "supply",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [],
            "return": [
              "u64"
            ]
          },
          {
            "name": "symbol",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [],
            "return": [
              "0x1::string::String"
            ]
          },
          {
            "name": "transfer",
            "visibility": "public",
            "is_entry": false,
            "generic_type_params": [],
            "params": [
              "&signer",
              "address",
              "u64"
            ],
            "return": []
          }
        ],
        "structs": [
          {
            "name": "Coin",
            "is_native": false,
            "abilities": [
              "store"
            ],
            "generic_type_params": [],
            "fields": [
              {
                "name": "value",
                "type": "u64"
              }
            ]
          },
          {
            "name": "CoinInfo",
            "is_native": false,
            "abilities": [
              "key"
            ],
            "generic_type_params": [],
            "fields": [
              {
                "name": "name",
                "type": "0x1::string::String"
              },
              {
                "name": "symbol",
                "type": "0x1::string::String"
              },
              {
                "name": "decimals",
                "type": "u64"
              },
              {
                "name": "supply",
                "type": "u64"
              }
            ]
          },
          {
            "name": "CoinStore",
            "is_native": false,
            "abilities": [
              "key"
            ],
            "generic_type_params": [],
            "fields": [
              {
                "name": "coin",
                "type": "0xf0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a::usdc::Coin"
              },
              {
                "name": "deposit_events",
                "type": "0x1::event::EventHandle<0xf0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a::usdc::DepositEvent>"
              },
              {
                "name": "withdraw_events",
                "type": "0x1::event::EventHandle<0xf0881fc180ccb250f3e748730f03a17fb627d824f0a23cf934873304195b609a::usdc::WithdrawEvent>"
              }
            ]
          },
          {
            "name": "DepositEvent",
            "is_native": false,
            "abilities": [
              "drop",
              "store"
            ],
            "generic_type_params": [],
            "fields": [
              {
                "name": "amount",
                "type": "u64"
              }
            ]
          },
          {
            "name": "WithdrawEvent",
            "is_native": false,
            "abilities": [
              "drop",
              "store"
            ],
            "generic_type_params": [],
            "fields": [
              {
                "name": "amount",
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

```
```

## register recipient


## mint


## transfer

