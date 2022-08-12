# Token in native

## Prerequisites

[Install Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli)

[Create an account and fund](https://aptos.dev/cli-tools/aptos-cli-tool/use-aptos-cli)

## Build Module

```
aptos move compile --package-dir . --named-addresses NamedAddr=0x697c173eeb917c95a382b60f546eb73a4c6a2a7b2d79e6c56c87104f9c04345f
```

```
{
  "Result": [
    "697C173EEB917C95A382B60F546EB73A4C6A2A7B2D79E6C56C87104F9C04345F::usdt"
  ]
}
```

## Publish Module

```
aptos move publish --package-dir . --named-addresses NamedAddr=0x697c173eeb917c95a382b60f546eb73a4c6a2a7b2d79e6c56c87104f9c04345f
```

check publish successful.

```
aptos account list --query modules --account 0x697c173eeb917c95a382b60f546eb73a4c6a2a7b2d79e6c56c87104f9c04345f
```

we can see account modules.

```
{
  "Result": [
    {
      "bytecode": "0xa11ceb0b050000000501000202020407061a0820200a400500000001000004757364740855534454436f696e0b64756d6d795f6669656c64697c173eeb917c95a382b60f546eb73a4c6a2a7b2d79e6c56c87104f9c04345f000201020100",
      "abi": {
        "address": "0x697c173eeb917c95a382b60f546eb73a4c6a2a7b2d79e6c56c87104f9c04345f",
        "name": "usdt",
        "friends": [],
        "exposed_functions": [],
        "structs": [
          {
            "name": "USDTCoin",
            "is_native": false,
            "abilities": [],
            "generic_type_params": [],
            "fields": [
              {
                "name": "dummy_field",
                "type": "bool"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## initilize usdt

```
aptos move run --function-id 0x1::managed_coin::initialize --type-args 0x697c173eeb917c95a382b60f546eb73a4c6a2a7b2d79e6c56c87104f9c04345f::usdt::USDTCoin --args string:usdt string:USDT u64:6 bool:false
```

## register recipient


## mint


## transfer

